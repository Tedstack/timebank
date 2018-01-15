package com.blockchain.timebank.weixin.util;

import com.blockchain.timebank.weixin.model.Template;
import com.blockchain.timebank.weixin.model.TemplateParam;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.entity.RechargeEntity;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;

public class TemplateUtil {
    public static boolean testTemplate(UserEntity user,RechargeEntity recharge){
        //此处用与测试，增加微信充值模板消息提醒,暂时写在这后面模板数目增多，移到专门的类中
        UserEntity userEntity = user;
        //String accessToken = CommonUtil.getAccessToken(Configs.APPID, Configs.APPSECRET).getAccess_token();
        /*String accessToken = "";
        if(TokenThread.accessToken == null || TokenThread.accessToken.getAccessToken() == ""){
            accessToken = CommonUtil.getAccessToken(Configs.APPID, Configs.APPSECRET).getAccess_token();
        }
        else{
            accessToken = TokenThread.accessToken.getAccessToken();
        }*/
        String str_first = "充值通知:尊敬的"+ user.getName()+"您好：";
        String rechargeDate = recharge.getRechargeDate();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        Date date = null;
        try {
            date = bartDateFormat.parse(rechargeDate);
        }catch (Exception e){
            e.printStackTrace();
        }
        String str_Date = bartDateFormat.format(date);
        String str_type = "微信支付";
        String str_amount = Double.toString(recharge.getTotalAmount());
        String str_remark = "您当前的时间币余额为" + Double.toString(user.getTimeCoin());
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("JFSJ", str_Date, "#173177"));
        templateParamList.add(new TemplateParam("JFFS",str_type,"#173177"));
        templateParamList.add(new TemplateParam("JFJE",str_amount,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("lwq0d7uaWDGj1HsoBD9NuhxITvuq-iglfxfcNRH94gk");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("http://www.i-linli.com/timebanktest/recharge/coins_balance");
        template.setTemplateParamList(templateParamList);

       // return AdvancedUtil.sendTemplateMessage(TokenThread.accessToken.getAccessToken(), template);
        return AdvancedUtil.sendTemplateMessage(template);
    }
}
