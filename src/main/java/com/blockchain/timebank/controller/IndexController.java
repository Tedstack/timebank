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
        System.out.println("��Ȩ�룺"+ code);

        // �û�ͬ����Ȩ
        if(null != code) {
            // ��code��ȡaccess_token��ͬʱ��õ�OpenID��
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            System.out.println("�û���OPENID��" + wot.getOpenId());

            String openId = wot.getOpenId();
            String accessToken = wot.getAccessToken();
            // ��ȡ�û�������Ϣ
            SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
            System.out.println("�ǳƣ�" + snsUserInfo.getNickName());

            map.addAttribute("openId",wot.getOpenId());
            map.addAttribute("nickname",snsUserInfo.getNickName());
            map.addAttribute("sex",snsUserInfo.getSex());
            map.addAttribute("headimgurl",snsUserInfo.getHeadimgurl());
            map.addAttribute("city",snsUserInfo.getCity());

        }
        return "register";
    }

}
