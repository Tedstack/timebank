package com.blockchain.timebank.controller;

import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
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

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public String userPage(ModelMap map) {
        return "user";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(ModelMap map) {
        return "login";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(ModelMap map) {
        return "register";
    }

    @RequestMapping(value = "/user/login", method = RequestMethod.POST)
    public String userLogin(ModelMap map, @RequestParam String phone, @RequestParam String password) {
        if (phone.equals("") || password.equals("")) {
            map.addAttribute("error", "输入信息不能为空");
            return "login";
        }
        if (userService.findUserEntityByPhoneAndPassword(phone, password) == null) {
            map.addAttribute("error", "错误的用户名或者密码");
            return "login";
        } else {
            Authentication token = new UsernamePasswordAuthenticationToken(phone, password);
            SecurityContextHolder.getContext().setAuthentication(token);
            return "redirect:/index";
        }
    }

    @RequestMapping(value = "/user/logout", method = RequestMethod.GET)
    public String logoutPage(ModelMap map) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){
            SecurityContextHolder.getContext().setAuthentication(null);
        }
        map.addAttribute("logout", "已经为您安全退出！");
        return "/login";
    }


    @RequestMapping(value = "/user/register", method = RequestMethod.POST)
    public String userRegister(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String password) {
        if (phone.equals("") || name.equals("") || password.equals("")) {
            map.addAttribute("error", "输入信息不能为空");
            return "/register";
        }
        if (userService.findUserEntityByPhone(phone) != null) {
            map.addAttribute("error", "注册失败，手机号已经被注册！");
            return "/register";
        }
        try {
            UserEntity userEntity = new UserEntity();
            userEntity.setName(name);
            userEntity.setPhone(phone);
            userEntity.setPassword(password);
            userService.saveUserEntity(userEntity);
            Authentication token = new UsernamePasswordAuthenticationToken(phone, password);
            SecurityContextHolder.getContext().setAuthentication(token);
            return "/index";
        } catch (Exception e) {
            map.addAttribute("error", "注册失败，重复的用户！");
            return "/register";
        }
    }

}
