package com.blockchain.timebank.controller;


import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.service.RequestOrderService;
import com.blockchain.timebank.service.RequestService;
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
import java.util.Collections;
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
    RequestService requestService;

    @Autowired
    RequestOrderService requestOrderService;

    //发布需求页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map) {
        UserEntity user =  getCurrentUser();
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        return "request/add";
    }

    //发布需求提交接口
    @RequestMapping(value = "/add/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map,
                                @RequestParam Long serviceId,
                                @RequestParam String description,
                                @RequestParam String beginTime,
                                @RequestParam String endTime,
                                @RequestParam BigDecimal price,
                                @RequestParam String address) {
        try {
            UserEntity user =  getCurrentUser();
            RequestEntity requestEntity = new RequestEntity();
            requestEntity.setAddress(address);
            requestEntity.setDescription(description);
            requestEntity.setUserId(user.getId());
            requestEntity.setPrice(price);
            requestEntity.setServiceId(serviceId);//serviceId
            Date beginDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(beginTime);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            Date endDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTime);
            requestEntity.setBeginTime(new Timestamp(beginDateTime.getTime()));
            requestEntity.setEndTime(new Timestamp(endDateTime.getTime()));
            requestEntity.setRequesterName(user.getName());
            requestEntity.setRequesterPhone(user.getPhone());
            requestEntity.setPayway(1);
            requestService.saveRequestEntity(requestEntity);
        }
        catch (ParseException e) {
            e.printStackTrace();
        }

        List<ViewRequestDetailEntity> viewRequestDetailEntities = requestService.findAllRequestDetailByType(getServiceTypeById(serviceId));
        map.addAttribute("list", viewRequestDetailEntities);
        map.addAttribute("type", getServiceTypeById(serviceId));
        return "redirect:/request/list";
    }

    //志愿者需求详细列表
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String detailVolunteerPage(ModelMap map, @RequestParam long id, @RequestParam String type) {
        ViewRequestDetailEntity viewRequestDetailEntity = requestService.findDetailById(id);
        map.addAttribute("detail", viewRequestDetailEntity);
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("currentUser", userEntity);
        map.addAttribute("type", type);
        return "request/detail";
    }

    //申请需求页面
    @RequestMapping(value = "/apply", method = RequestMethod.GET)
    public String apply(ModelMap map, long id){
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("detail", requestService.findDetailById(id));
        map.addAttribute("name", userEntity.getName());
        map.addAttribute("phone", userEntity.getPhone());
        return "request/apply";
    }

    //需求申请提交
    @RequestMapping(value = "/applySubmit", method = RequestMethod.POST)
    public String applySubmit(ModelMap map,
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
            RequestOrderEntity requestOrderEntity = new RequestOrderEntity();
            requestOrderEntity.setApplyUserId(applyUserId);
            requestOrderEntity.setRequestUserId(requestUserId);
            requestOrderEntity.setRequestId(requestId);
            requestOrderEntity.setApplyUserId(getCurrentUser().getId());
            Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            requestOrderEntity.setBeginTime(new Timestamp(date.getTime()));
            requestOrderEntity.setEndTime(new Timestamp(date.getTime() + serveTime * 60 * 60 * 1000));
            requestOrderEntity.setStatus(OrderStatus.alreadyApply);
            requestOrderService.saveVolunteerRequestMatchEntity(requestOrderEntity);
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
        return "request/apply_result";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String volunteerList(ModelMap map, @RequestParam String type) {
        List<ViewRequestDetailEntity> viewRequestDetailEntities = requestService.findAllRequestDetailByType(type);
        map.addAttribute("list", viewRequestDetailEntities);
        map.addAttribute("type", type);
        return "request/list";

    }

    //条件筛选需求
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    public String selectService(ModelMap map, @RequestParam String type) {
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        map.addAttribute("type", type);
        return "request/select";
    }

    @RequestMapping(value = "/selectList", method = RequestMethod.GET)
    //public String listPage(ModelMap map, @RequestParam String type, @RequestParam String[] serviceName, @RequestParam Date upperDate, @RequestParam Date lowerDate, @RequestParam String upper, @RequestParam String lower) {
    public String selectRequestList(ModelMap map, @RequestParam String type,@RequestParam String upper, @RequestParam String lower, @RequestParam String upperDate, @RequestParam String lowerDate, @RequestParam String serviceName) {
        try {
            BigDecimal upperPrice = BigDecimal.valueOf(Double.valueOf(upper));
            BigDecimal lowerPrice = BigDecimal.valueOf(Double.valueOf(lower));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(lowerDate);
            Date endDate = sdf.parse(upperDate);
            Timestamp lowerTime = new Timestamp(startDate.getTime());
            Timestamp upperTime = new Timestamp(endDate.getTime());
            String[] serviceNameArr = serviceName.split(",");
            //List<ViewPublishDetailEntity> list = selectServiceDao.findPublishEntityByCondition(type, serviceName, upperTime, lowerTime, upperPrice, lowerPrice);
            List<ViewRequestDetailEntity> list = requestService.findAllByCondition(type, upperPrice, lowerPrice, upperTime, lowerTime, serviceNameArr);
            //倒序排列
            Collections.reverse(list);
            map.addAttribute("list", list);
            map.addAttribute("type", type);
        } catch(Exception e){
            e.printStackTrace();
        }
        return "request/list";
    }

    //需求者处理订单
    @RequestMapping(value = "/handleRequestMatch", method = RequestMethod.GET)
    public String handleRequestMatch(ModelMap map,@RequestParam long matchID,@RequestParam String handle){
        RequestOrderEntity matchEntity = requestOrderService.findVolunteerRequestMatchEntityById(matchID);
        if(handle.equals("refuse")){
            matchEntity.setStatus(OrderStatus.alreadyRefuse);
            requestOrderService.updateVolunteerRequestMatchEntity(matchEntity);
        }

        if(handle.equals("confirm")){
            matchEntity.setStatus(OrderStatus.waitingService);
            requestOrderService.updateVolunteerRequestMatchEntity(matchEntity);
        }

        UserEntity userEntity = userService.findUserEntityById(matchEntity.getApplyUserId());
        RequestEntity requestEntity = requestService.findRequestById(matchEntity.getRequestId());
        map.addAttribute("userEntity",userEntity);
        map.addAttribute("requestEntity",requestEntity);
        map.addAttribute("matchEntity",matchEntity);

        return "request/taken_detail";
    }

    @RequestMapping(value = "/published", method = RequestMethod.GET)
    public String published(ModelMap map){
        long id = getCurrentUser().getId();
        
        List<ViewRequestDetailEntity> requestPublished = requestService.findUserRequestPublished(id);
        //倒序排列
        Collections.reverse(requestPublished);
        map.addAttribute("requestPublished", requestPublished);
        
        List<ViewRequestOrderDetailEntity> requestToConfirm = requestOrderService.findUserRequestToConfirm(id);
        //倒序排列
        Collections.reverse(requestToConfirm);
        map.addAttribute("requestToConfirm", requestToConfirm);

        List<ViewRequestOrderDetailEntity> requestToService = requestOrderService.findUserRequestToServe(id);
        //倒序排列
        Collections.reverse(requestToService);
        map.addAttribute("requestToService", requestToService);

        List<ViewRequestOrderDetailEntity> requestToPay = requestOrderService.findUserRequestToPay(id);
        //倒序排列
        Collections.reverse(requestToPay);
        map.addAttribute("requestToPay", requestToPay);
        
        List<ViewRequestOrderDetailEntity> requestCompleted = requestOrderService.findUserRequestCompleted(id);
        //倒序排列
        Collections.reverse(requestCompleted);
        map.addAttribute("requestCompleted", requestCompleted);
        
        return "request/published";

    }

    @RequestMapping(value = "/applied", method = RequestMethod.GET)
    public String applied(ModelMap map){
        long id = getCurrentUser().getId();

        List<ViewRequestOrderDetailEntity> requestApplied = requestOrderService.findUserApplyApplied(id);
        //倒序排列
        Collections.reverse(requestApplied);
        map.addAttribute("requestApplied", requestApplied);

        List<ViewRequestOrderDetailEntity> requestToService = requestOrderService.findUserApplyToServe(id);
        //倒序排列
        Collections.reverse(requestToService);
        map.addAttribute("requestToService", requestToService);

        List<ViewRequestOrderDetailEntity> requestToPay = requestOrderService.findUserApplyToPay(id);
        //倒序排列
        Collections.reverse(requestToPay);
        map.addAttribute("requestToPay", requestToPay);

        List<ViewRequestOrderDetailEntity> requestCompleted = requestOrderService.findUserApplyCompleted(id);
        //倒序排列
        Collections.reverse(requestCompleted);
        map.addAttribute("requestCompleted", requestCompleted);
        
        return "request/applied";

    }
    
    private String getServiceTypeById(Long id){
        if(100<=id && id<200)
            return "volunteer";
        else if(200<=id && id<300)
            return "technic";
        else
            return "mutualAid";

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
