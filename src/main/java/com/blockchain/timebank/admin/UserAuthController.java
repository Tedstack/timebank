package com.blockchain.timebank.admin;

import com.blockchain.timebank.entity.UserAuthEntity;
import com.blockchain.timebank.service.UserAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class UserAuthController {

    @Autowired
    UserAuthService userAuthService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(ModelMap map) {
        return "../admin/user_login";
    }

    @RequestMapping(value = "/loginSubmit", method = RequestMethod.POST)
    public String loginSubmit(ModelMap map, @RequestParam String phone, @RequestParam String password) {
        if (phone.equals("") || password.equals("")) {
            map.addAttribute("error", "输入的手机号或者密码不能为空");
            return "../admin/user_login";
        }
        UserAuthEntity userEntity = userAuthService.findUserAuthEntityByPhone(phone);
        if (userEntity == null || (!userEntity.getPassword().equals(password))) {
            map.addAttribute("error", "错误的用户名或者密码");
            return "../admin/user_login";
        } else {
            Authentication token = new UsernamePasswordAuthenticationToken(phone, password);
            SecurityContextHolder.getContext().setAuthentication(token);
            return "redirect:/admin/index";
        }
    }

    // 登出请求
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(ModelMap map) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            SecurityContextHolder.getContext().setAuthentication(null);
        }
        map.addAttribute("ok", "已经为您安全退出！");
        return "../admin/user_login";
    }

    @RequestMapping(value = "/userAuthList", method = RequestMethod.GET)
    public String userAuthListPage(ModelMap map) {
        List<UserAuthEntity> list = userAuthService.findAll();
        map.addAttribute("list", list);
        for (UserAuthEntity userAuthEntity : list) {
            List<String> auth = userAuthService.getAllAuthoritiesFromJSONString(userAuthEntity.getAuthority());
            map.addAttribute("auth" + userAuthEntity.getId(), auth);
        }
        return "../admin/user_auth_list";
    }

    @RequestMapping(value = "/userAuthAdd", method = RequestMethod.GET)
    public String userAuthAddPage(ModelMap map) {
        return "../admin/user_auth_add";
    }

    @RequestMapping(value = "/userAuthAddSubmit", method = RequestMethod.POST)
    public String userAuthAddSubmit(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String password, @RequestParam String password2, @RequestParam String[] auth) {
        if (phone.equals("") || name.equals("") || password.equals("")) {
            map.addAttribute("error", "姓名、手机号或者密码不能为空");
            return "../admin/user_auth_add";
        }
        if(!password.equals(password2)){
            map.addAttribute("error", "两次输入的密码不一致");
            return "../admin/user_auth_add";
        }
        if (userAuthService.findUserAuthEntityByPhone(phone) != null) {
            map.addAttribute("error", "添加失败，手机号已经被注册！");
            return "../admin/user_add";
        }

        UserAuthEntity userAuthEntity = new UserAuthEntity();
        userAuthEntity.setName(name);
        userAuthEntity.setPhone(phone);
        userAuthEntity.setPassword(password);
        userAuthEntity.setAuthority(userAuthService.getJSONStringFromAllAuthorities(auth));
        userAuthService.saveUserAuthEntity(userAuthEntity);
        map.addAttribute("ok", "添加成功！");
        return "../admin/user_auth_add";
    }


    @RequestMapping(value = "/userAuthEdit", method = RequestMethod.GET)
    public String userAuthEditPage(ModelMap map, long id) {
        UserAuthEntity userAuthEntity = userAuthService.findUserAuthEntityById(id);
        List<String> auth = userAuthService.getAllAuthoritiesFromJSONString(userAuthEntity.getAuthority());
        map.addAttribute("userAuth",userAuthEntity);
        map.addAttribute("auth", auth);
        return "../admin/user_auth_edit";
    }

    @RequestMapping(value = "/userAuthEditSubmit", method = RequestMethod.POST)
    public String userAuthEditSubmit(ModelMap map, long id, @RequestParam String name, @RequestParam String phone, @RequestParam String[] auth) {
        UserAuthEntity userAuthEntity = userAuthService.findUserAuthEntityById(id);
        userAuthEntity.setName(name);
        userAuthEntity.setPhone(phone);
        userAuthEntity.setAuthority(userAuthService.getJSONStringFromAllAuthorities(auth));
        map.addAttribute("userAuth",userAuthEntity);
        map.addAttribute("auth", Arrays.asList(auth));
        if (phone.equals("") || name.equals("")) {
            map.addAttribute("error", "姓名和手机号不能为空");
            return "../admin/user_auth_edit";
        }

        UserAuthEntity userAuthEntity1 = userAuthService.findUserAuthEntityByPhone(phone);
        if(userAuthEntity1!=null && userAuthEntity1.getId()!=id){
            map.addAttribute("error", "手机号已被其他账号绑定，不能重复绑定！");
            return "../admin/user_auth_edit";
        }else{
            userAuthService.saveUserAuthEntity(userAuthEntity);
            map.addAttribute("ok", "信息更新成功！");
            return "../admin/user_auth_edit";
        }

    }

}
