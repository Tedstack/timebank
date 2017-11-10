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
        map.addAttribute("link_userView","1");
        map.addAttribute("link_userEdit","1");
        return "../admin/user_list";
    }

    @RequestMapping(value = "/userAdd", method = RequestMethod.GET)
    public String userAddPage(ModelMap map) {
        return "../admin/user_add";
    }

    @RequestMapping(value = "/userEdit", method = RequestMethod.GET)
    public String userEditPage(ModelMap map, @RequestParam long userId) {
        map.addAttribute("user", userService.findUserEntityById(userId));
        return "../admin/user_edit";
    }

    @RequestMapping(value = "/userVerify", method = RequestMethod.GET)
    public String userVerifyPage(ModelMap map, @RequestParam long userId) {
        map.addAttribute("user", userService.findUserEntityById(userId));
        return "../admin/user_edit";
    }

    @RequestMapping(value = "/userView", method = RequestMethod.GET)
    public String userViewPage(ModelMap map, @RequestParam long userId) {
        map.addAttribute("user", userService.findUserEntityById(userId));
        return "../admin/user_view";
    }

    @RequestMapping(value = "/userAddMany", method = RequestMethod.GET)
    public String userAddManyPage(ModelMap map) {
        return "../admin/user_add_many";
    }


    @RequestMapping(value = "/userAddSubmit", method = RequestMethod.POST)
    public String userAddSubmit(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String idCard, @RequestParam String sex, @RequestParam Date birth, @RequestParam String QRCode) {
        if (phone.equals("") || name.equals("")) {
            map.addAttribute("error", "姓名和手机号不能为空");
            return "../admin/user_add";
        }
        if (userService.findUserEntityByPhone(phone) != null) {
            map.addAttribute("error", "添加失败，手机号已经被注册！");
            return "../admin/user_add";
        }
        UserEntity userEntity = new UserEntity();
        userEntity.setName(name);
        userEntity.setPhone(phone);
        userEntity.setIdCard(idCard);
        userEntity.setPassword(idCard.substring(12, idCard.length()));
        userEntity.setSex(sex);
        userEntity.setBirth(birth);
        userEntity.setQrCode(QRCode);

        userService.updateUserEntity(userEntity);
        map.addAttribute("ok", "添加成功，用户初始密码为注册身份证的后6位！");
        return "../admin/user_add";
    }

    @RequestMapping(value = "/userEditSubmit", method = RequestMethod.POST)
    public String userEditSubmit(ModelMap map, @RequestParam long userId, @RequestParam String name, @RequestParam String phone, @RequestParam String idCard, @RequestParam String sex, @RequestParam Date birth, @RequestParam String QRCode) {
        UserEntity userEntity = userService.findUserEntityById(userId);
        userEntity.setName(name);
        userEntity.setPhone(phone);
        userEntity.setIdCard(idCard);
        userEntity.setSex(sex);
        userEntity.setBirth(birth);
        userEntity.setQrCode(QRCode);
        map.addAttribute("user", userEntity);
        UserEntity user = userService.findUserEntityByPhone(phone);
        if (user != null && user.getId() != userId) {
            map.addAttribute("error", "手机号已被其他账号绑定，不能重复绑定！");
            return "../admin/user_edit";
        }
        if (phone.equals("") || name.equals("")) {
            map.addAttribute("error", "姓名和手机号不能为空");
            return "../admin/user_edit";
        } else {
            userService.updateUserEntity(userEntity);
            map.addAttribute("ok", "信息更新成功！");
            return "../admin/user_edit";
        }
    }

}
