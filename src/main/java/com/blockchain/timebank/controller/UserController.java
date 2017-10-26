package com.blockchain.timebank.controller;

import com.blockchain.timebank.entity.PublishEntity;
import com.blockchain.timebank.entity.ServiceEntity;
import com.blockchain.timebank.entity.RecordEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.RecordService;
import com.blockchain.timebank.service.PublishService;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    PublishService publishService;

    @Autowired
    RecordService recordService;

    @Autowired
    ServiceService serviceService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String userPage(ModelMap map) {
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("user", userEntity);
        return "userinfo";
    }


    // 登陆请求提交接口
    @RequestMapping(value = "/login", method = RequestMethod.POST)
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

    // 登出请求
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(ModelMap map) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            SecurityContextHolder.getContext().setAuthentication(null);
        }
        map.addAttribute("logout", "已经为您安全退出！");
        return "/login";
    }


    // 注册请求接口
    @RequestMapping(value = "/register", method = RequestMethod.POST)
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

    //查询所有的发布服务的接口
    @RequestMapping(value="/queryPublish",method = RequestMethod.GET)
    public String queryPublish(ModelMap map){
        List<PublishEntity> list = publishService.findByUserID(getCurrentUser().getId());

        for(int i=0;i<list.size();i++){
            ServiceEntity serviceEntity = serviceService.findById(list.get(i).getServiceId());
            //list.get(i).setServiceEntity(serviceEntity);
        }

        map.addAttribute("publishList", list);
        return "service_posted_all";
    }

    //查询申请者申请订单的接口
    @RequestMapping(value = "/queryOrder",method = RequestMethod.GET)
    public String queryOrder(ModelMap map){
        List<RecordEntity> list = recordService.findByApplyUserId(0);
        map.addAttribute("list", list);
        return "service_requested_all";
    }

    public UserEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserEntity userEntity = userService.findUserEntityByPhone(userDetails.getUsername());
            return userEntity;
        } else {
            return null;
        }
    }

}
