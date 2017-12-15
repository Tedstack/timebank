package com.blockchain.timebank.controller;

import com.blockchain.timebank.entity.RechargeEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.RechargeService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.wxpay.WxPay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;

@Controller
@RequestMapping("/recharge")
public class RechargeController {


    @Autowired
    UserService userService;

    @Autowired
    RechargeService rechargeService;


    @RequestMapping(value = "/rechargeAdd", method = RequestMethod.GET)
    public String rechargeAddPage(ModelMap map) {
        return "recharge_add";
    }

    @RequestMapping(value = "/rechargeAddSubmit", method = RequestMethod.POST)
    public String rechargeAddSubmit(ModelMap map,  @RequestParam Integer totalAmount) throws IOException {
        UserEntity userEntity = getCurrentUser();
        String prePayXml = rechargeService.getUnifiedMessage(userEntity.getOpenId(),totalAmount,userEntity.getId());
        map.addAttribute("prePayInfo",prePayXml);

/*        RechargeEntity rechargeEntity = new RechargeEntity();
        rechargeEntity.setRechargeDate();


        rechargeService.saveRechargeEntity(rechargeEntity)*/
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
