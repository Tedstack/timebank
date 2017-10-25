package com.blockchain.timebank.controller;


import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.entity.OrderEntity;
import com.blockchain.timebank.entity.PayWay;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    UserService userService;

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    //申请服务页面
    @RequestMapping(value = "/apply", method = RequestMethod.GET)
    public String applyPage(ModelMap map, long id) {
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("detail", viewPublishDetailDao.findOne(id) );
        map.addAttribute("name", userEntity.getName());
        map.addAttribute("phone", userEntity.getPhone());
        return "order_apply";
    }

    //申请服务页面
    @RequestMapping(value = "/apply/submit", method = RequestMethod.POST)
    public String applySubmit(ModelMap map, long id) {
        OrderEntity orderEntity = new OrderEntity();
        orderEntity.setApplyUserId(getCurrentUser().getId());
        orderEntity.setPayWay(PayWay.PAY_WAY_TIME_COIN);
        return "order_apply";
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
