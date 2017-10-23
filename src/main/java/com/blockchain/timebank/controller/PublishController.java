package com.blockchain.timebank.controller;

import com.blockchain.timebank.entity.PublishEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.PublishService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/publish")
public class PublishController {

    @Autowired
    PublishService publishService;

    @Autowired
    UserService userService;

    //发布服务页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map) {
        return "publish_add";
    }

    //发布服务显示列表
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listPage(ModelMap map) {
        List<PublishEntity> list=publishService.findAllPublishEntity();
        map.addAttribute("list",list);
        return "publish_list";
    }

    //发布服务提交接口
    @RequestMapping(value = "/add/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map, @RequestParam String name, @RequestParam String description, @RequestParam String beginDate, @RequestParam String endDate, @RequestParam double price, @RequestParam String address) {
        PublishEntity publishEntity = new PublishEntity();
        publishEntity.setAddress(address);
        publishEntity.setDescription(description);
        publishEntity.setUserId(getCurrentUser().getId());
        publishEntity.setPrice(price);
        publishEntity.setServiceId(0L);
        publishEntity.setBeginDate(new Timestamp(System.currentTimeMillis()));
        publishEntity.setEndDate(new Timestamp(System.currentTimeMillis()));
        publishService.savePublishEntity(publishEntity);
        return "redirect:/publish/list";
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
