package com.blockchain.timebank.controller;


import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.weixin.model.SNSUserInfo;
import com.blockchain.timebank.weixin.model.WeixinOauth2Token;
import com.blockchain.timebank.weixin.util.AdvancedUtil;
import com.blockchain.timebank.weixin.util.Configs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/")
public class IndexController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = {"/", "/home**", "/index**", "/welcome**"}, method = RequestMethod.GET)
    public String indexPage() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        System.out.println(principal.toString());
        return "index";

    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(HttpServletRequest request, ModelMap map, @RequestParam String code) {
        System.out.println("授权码："+ code);
        // 用户同意授权
        if(null != code) {
            // 用code换取access_token（同时会得到OpenID）
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            if(wot!=null){
                System.out.println("用户的OPENID：" + wot.getOpenId());

                String openId = wot.getOpenId();
                String accessToken = wot.getAccessToken();
                UserEntity userEntity = userService.findUserEntityByOpenID(wot.getOpenId());
                SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
                if(userEntity!=null){
                    String headImgUrl = userEntity.getHeadImgUrl();
                    String url = snsUserInfo.getHeadimgurl();
                    if(url != null && !url.equals(headImgUrl)){
                        userEntity.setHeadImgUrl(url);
                    }
                    String country=snsUserInfo.getCountry();
                    String province=snsUserInfo.getProvince();
                    String city=snsUserInfo.getCity();
                   String nickname=snsUserInfo.getNickName();

                    System.out.println("======nickName:"+nickname+"======headImgUrl:"+url);
                    int sex=snsUserInfo.getSex();
                    String sex1;
                    if(sex==1)
                    {
                        sex1="男";
                    }
                    else
                    {
                        sex1="女";
                    }
                    userEntity.setCountry(country);
                    userEntity.setCity(city);
                    userEntity.setProvince(province);
                    userEntity.setSex(sex1);
                    userEntity.setRemark(nickname);
                    userService.updateUserEntity(userEntity);
                    Authentication token = new UsernamePasswordAuthenticationToken(userEntity.getPhone(), userEntity.getPassword());
                    SecurityContextHolder.getContext().setAuthentication(token);
                    return "redirect:/index";
                }
                map.addAttribute("openID",openId);
            }else{
                map.addAttribute("openID","noID");
            }

        }
        return "login";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(HttpServletRequest request, ModelMap map,@RequestParam String code) {
        System.out.println("授权码："+ code);

        // 用户同意授权
        if(null != code) {
            // 用code换取access_token（同时会得到OpenID）
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            if(wot!=null){
                System.out.println("用户的OPENID：" + wot.getOpenId());

                String openId = wot.getOpenId();
                String accessToken = wot.getAccessToken();
                // 获取用户基本信息
                SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
                System.out.println("昵称：" + snsUserInfo.getNickName());

                //userService.saveUserHeadImgUrl(null, openId, accessToken, request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/userAvatar/");
                map.addAttribute("code",code);
                map.addAttribute("openID",wot.getOpenId());
            }else{
                map.addAttribute("code",code);
                map.addAttribute("openID","noID");
            }

        }else{
            map.addAttribute("code","noCode");
            map.addAttribute("openID","noID");
        }

        return "register";
    }

}
