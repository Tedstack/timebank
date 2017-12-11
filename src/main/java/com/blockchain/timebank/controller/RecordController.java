package com.blockchain.timebank.controller;


import com.blockchain.timebank.dao.RecordDao;
import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.AccountService;
import com.blockchain.timebank.service.PublishService;
import com.blockchain.timebank.service.RecordService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.security.auth.login.AccountException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequestMapping("/record")
public class RecordController {

    @Autowired
    UserService userService;

    @Autowired
    RecordService recordService;

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @Autowired
    PublishService publishService;


    //申请服务页面
    @RequestMapping(value = "/apply", method = RequestMethod.GET)
    public String applyPage(ModelMap map, long id) {
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("detail", viewPublishDetailDao.findOne(id));
        map.addAttribute("name", userEntity.getName());
        map.addAttribute("phone", userEntity.getPhone());
        return "record_apply";
    }
    // 申请评价页面
    @RequestMapping(value = "/rate", method = RequestMethod.GET)
    public String ratePage(ModelMap map) {

        return "rate";
    }

    // 申请活动列表页面
    @RequestMapping(value = "/activities", method = RequestMethod.GET)
    public String activities(ModelMap map) {

        return "activities";
    }
    //申请已申请的活动页面（参与活动）
    @RequestMapping(value = "/yishenqing_activities", method = RequestMethod.GET)
    public String Yisheningactivities(ModelMap map) {

        return "activities_yishenqin_volunteer";
    }

    //申请待执行的活动页面（参与活动）
    @RequestMapping(value = "/daizhixing_activities", method = RequestMethod.GET)
    public String Daizhixingactivities(ModelMap map) {

        return "activities_daizhixing_volunteer";
    }

    //申请已完成的活动界面（参与活动）
    @RequestMapping(value = "/yiwancheng_activities", method = RequestMethod.GET)
    public String Yiwanchengactivities(ModelMap map) {
        return "activities_yiwancheng_volunteer";
    }
    //申请活动详情的界面（参与活动）
    @RequestMapping(value = "/detail_activities", method = RequestMethod.GET)
    public String Detailactivities(ModelMap map) {
        return "activities_details";
    }
    //申请发布团体活动页面
    @RequestMapping(value = "/activities_add", method = RequestMethod.GET)
    public String addactivities(ModelMap map) {
        return "activities_add";
    }
    //申请待申请团体活动页面（发布活动）
    @RequestMapping(value = "/daishenqing_activities", method = RequestMethod.GET)
    public String daishenqingactivities(ModelMap map) {
        return "activities_daishenqing_publish";
    }
    //申请待执行团体活动页面（发布活动）
    @RequestMapping(value = "/daizhixing_activities_publish", method = RequestMethod.GET)
    public String daishenqingactivitiespublish(ModelMap map) {
        return "activities_daizhixing_publish";
    }
    //申请已完成团体活动页面（发布活动）
    @RequestMapping(value = "/yiwancheng_activities_publish", method = RequestMethod.GET)
    public String yiwanchengactivitiespublish(ModelMap map) {
        return "activities_yiwancheng_publish";
    }

    //申请服务页面
    @RequestMapping(value = "/applySubmit", method = RequestMethod.POST)
    public String applySubmit(ModelMap map, @RequestParam long serviceUserId, @RequestParam long publishId, @RequestParam String applyUserName, @RequestParam String applyUserPhone, @RequestParam String address, @RequestParam String beginTime, @RequestParam int serveTime, @RequestParam int payWay) {

        //判断余额是否充足
        double price = publishService.findPublishEntityById(publishId).getPrice();
        double sum = price * serveTime;
        boolean hasMoney = true;
        if(payWay==1){
            if(getCurrentUser().getTimeVol()<sum){
                hasMoney = false;
            }
        }
        if(payWay==2){
            if(getCurrentUser().getTimeCoin()<sum){
                hasMoney = false;
            }
        }

        //判断是否申请自己的服务
        boolean isOneself = false;
        if(serviceUserId == getCurrentUser().getId()){
            isOneself = true;
        }


        if(hasMoney){
            try {
                RecordEntity recordEntity = new RecordEntity();
                recordEntity.setServiceUserId(serviceUserId);
                recordEntity.setPublishId(publishId);
                recordEntity.setApplyUserId(getCurrentUser().getId());
                recordEntity.setApplyUserName(applyUserName);
                recordEntity.setApplyUserPhone(applyUserPhone);
                recordEntity.setApplyAddress(address);
                Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
                recordEntity.setBeginTime(new Timestamp(date.getTime()));
                recordEntity.setEndTime(new Timestamp(date.getTime() + serveTime * 60 * 60 * 1000));
                recordEntity.setPayWay(payWay);
                recordEntity.setStatus(OrderStatus.alreadyApply);
                recordService.saveRecordEntity(recordEntity);
                map.addAttribute("msg","ok");
            } catch (ParseException e) {
                e.printStackTrace();
                map.addAttribute("msg","error");
                map.addAttribute("detail","parseException");
            }
        }else{
            map.addAttribute("msg","error");
            map.addAttribute("detail","noMoney");
        }

        if(isOneself){
            map.addAttribute("msg","error");
            map.addAttribute("detail","isOneself");
        }

        return "record_apply_result";
    }

    //服务者处理订单
    @RequestMapping(value = "/handleApplicantRecord", method = RequestMethod.GET)
    public String handleApplicantRecord(ModelMap map,@RequestParam long recordID,@RequestParam String handle){
        RecordEntity recordEntity = recordService.findRecordEntityById(recordID);
        if(handle.equals("refuse")){
            recordEntity.setStatus(OrderStatus.alreadyRefuse);
            recordService.updateRecordEntity(recordEntity);
        }

        if(handle.equals("confirm")){
            recordEntity.setStatus(OrderStatus.waitingService);
            recordService.updateRecordEntity(recordEntity);
        }

        UserEntity userEntity = userService.findUserEntityById(recordEntity.getApplyUserId());
        PublishEntity publishEntity = publishService.findPublishEntityById(recordEntity.getPublishId());
        map.addAttribute("userEntity",userEntity);
        map.addAttribute("publishEntity",publishEntity);
        map.addAttribute("recordEntity",recordEntity);

        return "takendetails";
    }

    public UserEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserEntity userEntity = userService.findUserEntityByPhone(userDetails.getUsername());
            return userEntity;
        } else {
            return null;
        }
    }

}
