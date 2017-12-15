package com.blockchain.timebank.admin;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class IndexManageController {

    @RequestMapping(value = {"/","/index"}, method = RequestMethod.GET)
    public String indexPage(ModelMap map) {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        map.addAttribute("username",userDetails.getUsername());
        return "../admin/index";
    }


}
