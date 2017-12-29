package com.blockchain.timebank.controller;


import com.blockchain.timebank.entity.ServiceEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.entity.VolunteerRequestEntity;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.service.VolunteerRequestService;
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

@Controller
@RequestMapping("/request")
public class RequestController {

    @Autowired
    UserService userService;

    @Autowired
    ServiceService serviceService;

    @Autowired
    VolunteerRequestService volunteerRequestService;

    //发布服务页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map) {
        UserEntity user =  getCurrentUser();
        if(user.getIsVerify()==null){
            map.addAttribute("msg", "notVerify");
            return "publish_service_result";
        }else if(user.getIsVerify()==0){
            map.addAttribute("msg", "failVerify");
            return "publish_service_result";
        }

        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        return "request_add";
    }

    //发布需求提交接口
    @RequestMapping(value = "/add/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map, @RequestParam String serviceType, @RequestParam String serviceName, @RequestParam String description, @RequestParam String beginDate, @RequestParam String endDate, @RequestParam BigDecimal price, @RequestParam String address) {
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
                    Date beginTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(beginDate);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
                    Date endTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endDate);
                    volunteerRequestEntity.setBeginTime(new Timestamp(beginTime.getTime()));
                    volunteerRequestEntity.setEndTime(new Timestamp(endTime.getTime()));
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
        return "redirect:/publish/list";
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
