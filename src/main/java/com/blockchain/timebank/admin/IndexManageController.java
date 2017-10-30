package com.blockchain.timebank.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class IndexManageController {

    @RequestMapping(value = {"/","/index"}, method = RequestMethod.GET)
    public String serviceListPage(ModelMap map) {
        return "../admin/index";
    }
}
