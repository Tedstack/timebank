package com.blockchain.timebank.admin;

import com.blockchain.timebank.entity.ActivityPublishEntity;
import com.blockchain.timebank.service.ActivityPublishService;
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

@Controller
@RequestMapping("/admin")
public class ActivityManagerController {

    @Autowired
    ActivityPublishService activityPublishService;

    @RequestMapping(value = "/activityPublishList", method = RequestMethod.GET)
    public String activityPublishListPage(ModelMap map) {
        map.addAttribute("list",activityPublishService.findAllByDeleted(false));
        return "../admin/activity_publish_list";
    }


    @RequestMapping(value = "/activityPublishAdd", method = RequestMethod.GET)
    public String activityPublishAddPage(ModelMap map) {
        return "../admin/activity_publish_add";
    }

    @RequestMapping(value = "/activityPublishAddSubmit", method = RequestMethod.POST)
    public String activityPublishAddSubmit(ModelMap map, @RequestParam String name, @RequestParam String description, @RequestParam String beginTime, @RequestParam String applyEndTime, @RequestParam String address, @RequestParam int peopleCount, @RequestParam boolean IsPublic) {
        try {
            ActivityPublishEntity activityPublishEntity = new ActivityPublishEntity();
            activityPublishEntity.setDeleted(false);
            activityPublishEntity.setName(name);
            activityPublishEntity.setDescription(description);
            Date beginDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));
            Date applyEndDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(applyEndTime.replace("T", " "));
            activityPublishEntity.setBeginTime(new Timestamp(beginDate.getTime()));
            activityPublishEntity.setApplyEndTime(new Timestamp(applyEndDate.getTime()));
            activityPublishEntity.setAddress(address);
            activityPublishEntity.setCount(peopleCount);
            activityPublishEntity.setPublic(IsPublic);
            activityPublishService.saveActivityPublishEntity(activityPublishEntity);
            map.addAttribute("ok", "发布成功！");
        } catch (ParseException e) {
            e.printStackTrace();
            map.addAttribute("error", "输入有误，发布失败！");
        }
        return "../admin/activity_publish_add";
    }

}
