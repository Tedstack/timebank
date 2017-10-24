package com.blockchain.timebank.controller;


import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class IndexController {

    @RequestMapping(value = {"/", "/home**", "/index**", "/welcome**"}, method = RequestMethod.GET)
    public String indexPage() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println(principal.toString());
        return "index";

    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(ModelMap map) {
        return "login";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(ModelMap map) {
        return "register";
    }

}
