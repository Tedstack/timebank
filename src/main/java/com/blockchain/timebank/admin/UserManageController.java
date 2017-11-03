package com.blockchain.timebank.admin;

import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Date;
import java.text.SimpleDateFormat;
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


    @RequestMapping(value = "/userAddSubmit", method = RequestMethod.POST)
    public String userAddPage(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String idCard, @RequestParam String sex, @RequestParam String birth, @RequestParam String QRCode) {
        if (phone.equals("") || name.equals("")) {
            map.addAttribute("error", "姓名和手机号不能为空");
            return "../admin/user_add";
        }
        if (userService.findUserEntityByPhone(phone) != null) {
            map.addAttribute("error", "添加失败，手机号已经被注册！");
            return "../admin/user_add";
        }
        try {
            UserEntity userEntity = new UserEntity();
            userEntity.setName(name);
            userEntity.setPhone(phone);
            userEntity.setIdCard(idCard);
            userEntity.setSex(sex);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            userEntity.setBirth(new Date(dateFormat.parse(birth).getTime()));
            userEntity.setQrCode(QRCode);
            userService.saveUserEntity(userEntity);
            map.addAttribute("ok","添加成功！");
            return "../admin/user_add";
        } catch (Exception e) {
            map.addAttribute("error", "添加失败，输入信息错误！");
            return "../admin/user_add";
        }
    }


    @RequestMapping(value = "/userAddMany", method = RequestMethod.GET)
    public String userAddManyPage(ModelMap map) {
        return "../admin/user_add_many";
    }
}
