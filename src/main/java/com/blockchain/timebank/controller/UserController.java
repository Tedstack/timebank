package com.blockchain.timebank.controller;

import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Date;


@Controller
@RequestMapping("/")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "login", method = RequestMethod.GET)
    public String userLogin(ModelMap map) {
        UserEntity userEntity=new UserEntity();
        userEntity.setName("测试姓名");
        userEntity.setPhone("测试号码");
        userEntity.setTimeCoin(0);
        userEntity.setTimeVol(0);
        userEntity.setPassword("测试密码");
        userEntity.setRegisterDate(new java.sql.Date(new Date().getTime()));
        userService.saveUserEntity(userEntity);
        return "login";
    }

}
