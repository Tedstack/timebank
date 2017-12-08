package com.blockchain.timebank.controller;


import com.blockchain.timebank.weixin.model.SNSUserInfo;
import com.blockchain.timebank.weixin.model.WeixinOauth2Token;
import com.blockchain.timebank.weixin.util.AdvancedUtil;
import com.blockchain.timebank.weixin.util.Configs;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String registerPage(ModelMap map,@RequestParam String code) {
        System.out.println("授权码："+ code);

        // 用户同意授权
        if(null != code) {
            // 用code换取access_token（同时会得到OpenID）
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            System.out.println("用户的OPENID：" + wot.getOpenId());

            String openId = wot.getOpenId();
            String accessToken = wot.getAccessToken();
            // 获取用户基本信息
            SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
            System.out.println("昵称：" + snsUserInfo.getNickName());

            map.addAttribute("openId",wot.getOpenId());
            map.addAttribute("nickname",snsUserInfo.getNickName());
            map.addAttribute("sex",snsUserInfo.getSex());
            map.addAttribute("headimgurl",snsUserInfo.getHeadimgurl());
            map.addAttribute("city",snsUserInfo.getCity());

        }
        return "register";
    }

}
