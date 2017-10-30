package com.blockchain.timebank.admin;

import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class UserManageController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/userList", method = RequestMethod.GET)
    public String userListPage(ModelMap map) {
        List<UserEntity> list_user = userService.findAll();
        map.addAttribute("list_user", list_user);
        return "../admin/user_list";
    }

    @RequestMapping(value = "/userAdd", method = RequestMethod.GET)
    public String userAddPage(ModelMap map) {
        return "../admin/user_add";
    }


    @RequestMapping(value = "/userAddMany", method = RequestMethod.GET)
    public String userAddManyPage(ModelMap map) {
        return "../admin/user_add_many";
    }
}
