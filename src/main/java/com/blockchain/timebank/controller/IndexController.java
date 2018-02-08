package com.blockchain.timebank.controller;


import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.weixin.model.SNSUserInfo;
import com.blockchain.timebank.weixin.model.WeixinOauth2Token;
import com.blockchain.timebank.weixin.util.AdvancedUtil;
import com.blockchain.timebank.weixin.util.Configs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    @RequestMapping(value = "/changePassword", method = RequestMethod.GET)
    public String changePassword(HttpServletRequest request, ModelMap map) {

        return "login_changepassword";
    }
//    @RequestMapping(value = "/change_Password", method = RequestMethod.GET)
//    public String change_Password(ModelMap map,@RequestParam String phone,@RequestParam String password) {
//        String status="";
//        UserEntity userentity=userService.findUserEntityByPhone(phone);
//        if(userentity.getPassword()!=null)
//        {
//            String MD5Password = MD5Util.getMD5(password);
//            userentity.setPassword(MD5Password);
//            userService.updateUserEntity(userentity);
//            status = "success";
//        }
//        else {
//            status="notregistered";
//        }
//        return status;
//    }
    @RequestMapping(value = "/loginPage", method = RequestMethod.GET)
    public String loginPage2(HttpServletRequest request, ModelMap map) {

        return "auto_login";
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
                    String localHeadUrl = "";
                    if(url != null && !url.equals(headImgUrl)){
                        userEntity.setHeadImgUrl(url);
                        localHeadUrl = userService.saveUserHeadImgUrl(userEntity,request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/userAvatar/");
                    }
                    String country=snsUserInfo.getCountry();
                    String province=snsUserInfo.getProvince();
                    String city=snsUserInfo.getCity();
                    String nickname=snsUserInfo.getNickName();

                    System.out.println("======nickName:"+nickname+"======headImgUrl:"+url);
                    int sex=snsUserInfo.getSex();
                    String sex1;
                    if(sex==1) {
                        sex1="男";
                    } else {
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

                //userService.saveUserHeadImgUrl(null,openId, accessToken, request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/userAvatar/");
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

    @RequestMapping(value="/share",method = RequestMethod.GET)
    public String visitSharePage(@RequestParam String code,@RequestParam String url){
        if(null != code){
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            if(wot!=null){
                System.out.println("用户的OPENID：" + wot.getOpenId());
                String openId = wot.getOpenId();
                UserEntity user=userService.findUserEntityByOpenID(openId);
                if(user!=null){
                    return "redirect:"+url;
                }
                return "login";
            }
        }
        return "login";
    }

    @RequestMapping(value="/navigate",method = RequestMethod.GET)
    public String navigate(RedirectAttributes attributes, HttpServletRequest request, ModelMap map, @RequestParam String code, @RequestParam String target){
        System.out.println("授权码："+ code);
        String openIDValue = "noID";
        // 用户同意授权
        if(null != code) {
            // 用code换取access_token（同时会得到OpenID）
            WeixinOauth2Token wot = AdvancedUtil.getOAuth2AceessToken(Configs.APPID, Configs.APPSECRET, code);
            if(wot!=null){
                System.out.println("用户的OPENID：" + wot.getOpenId());

                String openId = wot.getOpenId();
                openIDValue = openId;
                String accessToken = wot.getAccessToken();
                UserEntity userEntity = userService.findUserEntityByOpenID(wot.getOpenId());
                SNSUserInfo snsUserInfo = AdvancedUtil.getSNSUserInfo(accessToken, openId);
                if((userEntity!=null)&&(snsUserInfo!=null)){
                    String headImgUrl = userEntity.getHeadImgUrl();
                    String url = snsUserInfo.getHeadimgurl();
                    String localHeadUrl = "";
                    if(url != null && !url.equals(headImgUrl)){
                        userEntity.setHeadImgUrl(url);
                        localHeadUrl = userService.saveUserHeadImgUrl(userEntity,request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/userAvatar/");
                    }
                    String country=snsUserInfo.getCountry();
                    String province=snsUserInfo.getProvince();
                    String city=snsUserInfo.getCity();
                    String nickname=snsUserInfo.getNickName();

                    System.out.println("======nickName:"+nickname+"======headImgUrl:"+url);
                    int sex=snsUserInfo.getSex();
                    String sex1;
                    if(sex==1) {
                        sex1="男";
                    } else {
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
                }else{
                    SecurityContextHolder.getContext().setAuthentication(null);
                }
            }
        }

        if(target.equals("userinfo")){
            return "redirect:/user/";
        }

        if(target.equals("timebank")){
            return "redirect:/user/timebankinfo";
        }
        if(target.equals("activities")){
            return "redirect:/team/teamActivities";
        }

        if(target.equals("teams")){
            return "redirect:/team/teamList";
        }

        if(target.equals("services")){
            attributes.addAttribute("type","志愿者服务");
            return "redirect:/publish/list";
        }

        if(target.equals("requests")){
            attributes.addAttribute("type","volunteer");
            return "redirect:/request/list";
        }

        map.addAttribute("openID",openIDValue);
        return "login";
    }
}
