package com.blockchain.timebank.controller;


import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.service.VolunteerRequestMatchService;
import com.blockchain.timebank.service.VolunteerRequestService;
import com.blockchain.timebank.weixin.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/request")
public class RequestController {

    @Autowired
    UserService userService;

    @Autowired
    ServiceService serviceService;

    @Autowired
    VolunteerRequestService volunteerRequestService;

    @Autowired
    VolunteerRequestMatchService volunteerRequestMatchService;

    //发布需求页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map) {
        UserEntity user =  getCurrentUser();
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        return "request_add";
    }

    //发布需求提交接口
    @RequestMapping(value = "/add/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map,
                                @RequestParam String serviceType,
                                @RequestParam String serviceName,
                                @RequestParam String description,
                                @RequestParam String beginTime,
                                @RequestParam String endTime,
                                @RequestParam BigDecimal price,
                                @RequestParam String address) {
        try {
            if (serviceType.equals("志愿者服务")) {
                try {
                    UserEntity user =  getCurrentUser();
                    VolunteerRequestEntity volunteerRequestEntity = new VolunteerRequestEntity();
                    volunteerRequestEntity.setAddress(address);
                    volunteerRequestEntity.setDescription(description);
                    volunteerRequestEntity.setUserId(user.getId());
                    volunteerRequestEntity.setPrice(price);
                    volunteerRequestEntity.setServiceId(serviceService.findFirstByTypeAndName(serviceType, serviceName).getId());//serviceId
                    Date beginDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(beginTime);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
                    Date endDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTime);
                    volunteerRequestEntity.setBeginTime(new Timestamp(beginDateTime.getTime()));
                    volunteerRequestEntity.setEndTime(new Timestamp(endDateTime.getTime()));
                    volunteerRequestEntity.setRequesterName(user.getName());
                    volunteerRequestEntity.setRequesterPhone(user.getPhone());
                    volunteerRequestEntity.setPayway(1);
                    volunteerRequestService.saveVolunteerRequestEntity(volunteerRequestEntity);
                }
                catch (ParseException e) {
                    e.printStackTrace();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        map.addAttribute("type", serviceType);
        return "redirect:/request/volunteerList";
    }

    //志愿者需求详细列表
    @RequestMapping(value = "/detail_volunteer", method = RequestMethod.GET)
    public String detailVolunteerPage(ModelMap map, @RequestParam long id) {
        ViewVolunteerRequestDetailEntity viewVolunteerRequestDetailEntity = volunteerRequestService.findDetailById(id);
        map.addAttribute("detail", viewVolunteerRequestDetailEntity);

        UserEntity user = userService.findUserEntityById(viewVolunteerRequestDetailEntity.getUserId());
        String cardID = user.getIdCard();
        try {
            Map<String, Object> info =  CommonUtil.getCarInfo(cardID);
            map.addAttribute("age",info.get("age"));
        } catch (Exception e) {
            map.addAttribute("age",-1);
            e.printStackTrace();
        }

        map.addAttribute("timeVol", user.getTimeVol());
        return "request_volunteer/detail";
    }

    //志愿者申请需求页面
    @RequestMapping(value = "/volunteerApply", method = RequestMethod.GET)
    public String volunteerApply(ModelMap map, long id){
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("detail", volunteerRequestService.findDetailById(id));
        map.addAttribute("name", userEntity.getName());
        map.addAttribute("phone", userEntity.getPhone());
        return "request_volunteer/apply";
    }

    //志愿者需求申请提交
    @RequestMapping(value = "/volunteerApplySubmit", method = RequestMethod.POST)
    public String volunteerApplySubmit(ModelMap map,
                                       @RequestParam long requestUserId,
                                       @RequestParam long requestId,
                                       @RequestParam String beginTime,
                                       @RequestParam int serveTime){
        long applyUserId = getCurrentUser().getId();
        //判断是否申请自己的服务
        boolean isOneself = false;
        if(requestUserId == applyUserId){
            isOneself = true;
        }
        try {
            VolunteerRequestMatchEntity volunteerRequestMatchEntity = new VolunteerRequestMatchEntity();
            volunteerRequestMatchEntity.setApplyUserId(applyUserId);
            volunteerRequestMatchEntity.setRequestUserId(requestUserId);
            volunteerRequestMatchEntity.setRequestId(requestId);
            volunteerRequestMatchEntity.setApplyUserId(getCurrentUser().getId());
            Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            volunteerRequestMatchEntity.setBeginTime(new Timestamp(date.getTime()));
            volunteerRequestMatchEntity.setEndTime(new Timestamp(date.getTime() + serveTime * 60 * 60 * 1000));
            volunteerRequestMatchEntity.setStatus(OrderStatus.alreadyApply);
            volunteerRequestMatchService.saveVolunteerRequestMatchEntity(volunteerRequestMatchEntity);
            map.addAttribute("msg","ok");
        } catch (ParseException e) {
            e.printStackTrace();
            map.addAttribute("msg","error");
            map.addAttribute("detail","parseException");
        }
        if(isOneself){
            map.addAttribute("msg","error");
            map.addAttribute("detail","isOneself");
        }
        return "request_volunteer/apply_result";
    }

    @RequestMapping(value = "/volunteerList", method = RequestMethod.GET)
    public String volunteerList(ModelMap map) {
        List<ViewVolunteerRequestDetailEntity> viewVolunteerRequestDetailEntities = volunteerRequestService.findAllVolunteerRequestDetail();
        map.addAttribute("list", viewVolunteerRequestDetailEntities);
        return "request_volunteer/list";
    }

    //条件筛选需求
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    public String selectService(ModelMap map, @RequestParam String type) {
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        map.addAttribute("type", type);
        return "service_select";
    }

    //需求者处理订单
    @RequestMapping(value = "/handleVolunteerRequestMatch", method = RequestMethod.GET)
    public String handleApplicantRecord(ModelMap map,@RequestParam long matchID,@RequestParam String handle){
        VolunteerRequestMatchEntity matchEntity = volunteerRequestMatchService.findVolunteerRequestMatchEntityById(matchID);
        if(handle.equals("refuse")){
            matchEntity.setStatus(OrderStatus.alreadyRefuse);
            volunteerRequestMatchService.updateVolunteerRequestMatchEntity(matchEntity);
        }

        if(handle.equals("confirm")){
            matchEntity.setStatus(OrderStatus.waitingService);
            volunteerRequestMatchService.updateVolunteerRequestMatchEntity(matchEntity);
        }

        UserEntity userEntity = userService.findUserEntityById(matchEntity.getApplyUserId());
        VolunteerRequestEntity requestEntity = volunteerRequestService.findRequestById(matchEntity.getRequestId());
        map.addAttribute("userEntity",userEntity);
        map.addAttribute("requestEntity",requestEntity);
        map.addAttribute("matchEntity",matchEntity);

        return "request_volunteer/taken_detail";
    }

    private UserEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserEntity userEntity = userService.findUserEntityByPhone(userDetails.getUsername());
            return userEntity;
        } else {
            return null;
        }
    }
}
