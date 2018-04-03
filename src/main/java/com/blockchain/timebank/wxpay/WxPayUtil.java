package com.blockchain.timebank.wxpay;

import com.blockchain.timebank.weixin.model.WeixinOauth2Token;
import com.blockchain.timebank.weixin.model.WeixinUser;
import com.blockchain.timebank.weixin.util.AdvancedUtil;
import com.blockchain.timebank.weixin.util.Configs;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 支付结果处理
 */
public class WxPayUtil {


    //获取用户openid
    public static String getOpenId(){
        String code = "";
        WeixinOauth2Token userprofile = AdvancedUtil.getOAuth2AceessToken(Configs.APPID,Configs.APPSECRET,code);
        return userprofile.getOpenId();
    }

    //获取用户id
    public static String getUserId(){
        return "";
    }

    //获取用户支付金额
    public static Integer getUserFee(){
        return 100;
    }

    //获取用户IP
    public static String getUserIP(){
        return "192.168.1.1";
    }

    //获取用户的预支付信息
    public static String getPayMessage() throws IOException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date()).replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
        String openid = getOpenId();
        String body = "互助时间充值";
        String out_trade_no = time + getUserId();
        double total_fee = getUserFee();
        String spbill_create_ip = getUserIP();

        String payMessage = WxPay.unifiedOrder(body,out_trade_no,total_fee,spbill_create_ip,openid);

        return payMessage;
    }

}
