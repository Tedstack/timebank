package com.blockchain.timebank.controller;

import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/recharge")
public class RechargeController {


    @Autowired
    UserService userService;


    @RequestMapping(value = "/rechargeAdd", method = RequestMethod.GET)
    public String rechargeAddPage(ModelMap map) {
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("timeCoin", userEntity.getTimeCoin());
        return "recharge_add";
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
