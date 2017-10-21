package com.blockchain.timebank.controller;

import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(ModelMap map) {
        return "login";
    }


    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(ModelMap map) {
        return "register";
    }


    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public String userLogin(ModelMap map) {
        return "/index";
    }

    @RequestMapping(value = "/user/logout", method = RequestMethod.GET)
    public String logoutPage(ModelMap map) {
        return "/login?logout=1";
    }


    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public String userRegister(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String password) {
        UserEntity userEntity = new UserEntity();
        userEntity.setName(name);
        userEntity.setPhone(phone);
        userEntity.setPassword(password);
        userService.saveUserEntity(userEntity);
        return "/index";
    }

    private String getPrincipal(){
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return  principal.toString();
    }

}
