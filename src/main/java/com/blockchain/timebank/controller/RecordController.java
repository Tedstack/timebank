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

    //申请服务页面
    @RequestMapping(value = "/applySubmit", method = RequestMethod.POST)
    public String applySubmit(ModelMap map, @RequestParam long serviceUserId, @RequestParam long publishId, @RequestParam String applyUserName, @RequestParam String applyUserPhone, @RequestParam String address, @RequestParam String beginTime, @RequestParam int serveTime, @RequestParam int payWay) {

        double price = publishService.findPublishEntityById(publishId).getPrice();
        double sum = price * serveTime;
        boolean status = true;
        if(payWay==1){
            if(getCurrentUser().getTimeVol()<sum){
                map.addAttribute("detail","noMoney");
                status = false;
            }
        }
        if(payWay==2){
            if(getCurrentUser().getTimeCoin()<sum){
                map.addAttribute("detail","noMoney");
                status = false;
            }
        }

        if(status){
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
            }
        }else{
            map.addAttribute("msg","error");
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
