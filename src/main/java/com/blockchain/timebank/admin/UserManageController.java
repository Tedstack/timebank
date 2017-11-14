package com.blockchain.timebank.admin;

import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class UserManageController {

    @Autowired
    private HttpServletRequest request;

    @Autowired
    UserService userService;

    @RequestMapping(value = "/userList", method = RequestMethod.GET)
    public String userListPage(ModelMap map) {
        List<UserEntity> list_user = userService.findAll();
        map.addAttribute("list_user", list_user);
        map.addAttribute("link_userView", "1");
        map.addAttribute("link_userEdit", "1");
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

    @RequestMapping(value = "/userView", method = RequestMethod.GET)
    public String userViewPage(ModelMap map, @RequestParam long userId) {
        UserEntity user = userService.findUserEntityById(userId);
        map.addAttribute("user", user);
        if (user.getIdCard() == null || user.getIdCard().equals("")) {
            map.addAttribute("error","身份证号未填写");
        }
        return "../admin/user_view";
    }

    @RequestMapping(value = "/userPhotoAdd", method = RequestMethod.GET)
    public String userAddPhotoPage(ModelMap map, @RequestParam long userId) {
        map.addAttribute("user", userService.findUserEntityById(userId));
        return "../admin/user_photo_add";
    }

    @RequestMapping(value = "/userVerify", method = RequestMethod.GET)
    public String userVerifyPage(ModelMap map, @RequestParam long userId) {
        map.addAttribute("user", userService.findUserEntityById(userId));
        return "../admin/user_edit";
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
        if (userService.findUserEntityByIdCard(idCard) != null) {
            map.addAttribute("error", "添加失败，身份证号已经被注册！");
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
        userEntity.setRegisterDate(new Date(System.currentTimeMillis()));
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


    @RequestMapping(value = "/userUploadPhoto")
    @ResponseBody
    public Map<String, Object> upload(@RequestParam(value = "file", required = false) MultipartFile file, String idCard, String img) {
        Map<String, Object> map = new HashMap<String, Object>();
        File uploadDir = new File(getUploadPath());
        if (!uploadDir.exists()) uploadDir.mkdir();
        try {
            String suffix = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            String fileName = idCard + "_" + img + suffix;
            file.transferTo(new File(getUploadPath() + fileName));// 转存文件
            map.put("url", "/img/profile/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }


    // 文件上传路径
    private String getUploadPath() {
        return request.getSession().getServletContext().getRealPath("/") + "WEB-INF\\img\\profile\\";
    }
}
