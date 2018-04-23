package com.blockchain.timebank.admin;

import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.dao.ViewRecordDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.RecordService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class RecordManageController {

    @Autowired
    ViewRecordDetailDao viewRecordDetailDao;

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @Autowired
    UserService userService;

    @Autowired
    RecordService recordService;

    @RequestMapping(value = "/recordList", method = RequestMethod.GET)
    public String recordListPage(ModelMap map) {
        List<ViewPublishOrderDetailEntity> list = (List<ViewPublishOrderDetailEntity>) viewRecordDetailDao.findAll();
        map.addAttribute("list", list);
        return "../admin/record_list";
    }

    @RequestMapping(value = "/recordAddChoosePublish", method = RequestMethod.GET)
    public String recordAddChoosePublishPage(ModelMap map) {
        List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>) viewPublishDetailDao.findAll();
        map.addAttribute("list", list);
        map.addAttribute("link_recordAdd", "1");
        return "../admin/publish_list";
    }


    @RequestMapping(value = "/recordAdd", method = RequestMethod.GET)
    public String recordAddPage(ModelMap map, @RequestParam long publishId) {
        map.addAttribute("publish", viewPublishDetailDao.findOne(publishId));
        return "../admin/record_add";
    }

    //申请服务页面
    @RequestMapping(value = "/recordAddSubmit", method = RequestMethod.POST)
    public String recordAddSubmit(ModelMap map, @RequestParam long serviceUserId, @RequestParam long publishId, @RequestParam String applyUserName, @RequestParam String applyUserPhone, @RequestParam String address, @RequestParam String beginTime, @RequestParam int serveTime, @RequestParam int payWay) {
        UserEntity applyUser = userService.findUserEntityByPhone(applyUserPhone);
        map.addAttribute("publish", viewPublishDetailDao.findOne(publishId));
        if (applyUser == null) {
            map.addAttribute("error", "手机号错误，手机号不存在对应用户不存在！");
            return "../admin/record_add";
        }
        try {
            PublishOrderEntity publishOrderEntity = new PublishOrderEntity();
            publishOrderEntity.setServiceUserId(serviceUserId);
            publishOrderEntity.setPublishId(publishId);
            publishOrderEntity.setApplyUserId(applyUser.getId());
            publishOrderEntity.setApplyUserName(applyUserName);
            publishOrderEntity.setApplyUserPhone(applyUserPhone);
            publishOrderEntity.setApplyAddress(address);
            Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(beginTime);
            //Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            publishOrderEntity.setBeginTime(new Timestamp(date.getTime()));
            publishOrderEntity.setEndTime(new Timestamp(date.getTime() + serveTime * 60 * 60 * 1000));
            publishOrderEntity.setPayWay(payWay);
            publishOrderEntity.setStatus(OrderStatus.alreadyApply);
            recordService.saveRecordEntity(publishOrderEntity);
            map.addAttribute("ok", "添加成功！");
            return "../admin/record_add";
        } catch (ParseException e) {
            map.addAttribute("error", "预约失败！");
            return "../admin/record_add";
        }
    }

}
