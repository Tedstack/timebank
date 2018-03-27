package com.blockchain.timebank.weixin.util;


import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.weixin.model.Template;
import com.blockchain.timebank.weixin.model.TemplateParam;
import com.blockchain.timebank.weixin.model.Text;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;

public class MessageUtil {

    /*你需要填入添加模板式的参数值以及模板id号，发送给目标对象使用的是user表中的openid*/
    public static boolean team_join_success(UserEntity user, TeamEntity team){
        /*
        * 团队加入成功通知:
        * {{first.DATA}}
        * 团队名称：{{keyword1.DATA}}
        * 加入时间：{{keyword2.DATA}}
        * {{remark.DATA}}
        * 样例：
        * 您已成功加入团队！
        *团队名称：爱心志愿者团队
        * 加入时间：2017-1-11 8:18:18
        *可进入我的团队查看详情
        * */
        String str_first = "您已成功加入团队！";
        String team_name = team.getName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String join_time = bartDateFormat.format(new Date().getTime());
        String str_remark = "可进入查看我的团队详情";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", team_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",join_time,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("Ak8Bbtgn2Mes6i0Hh7AAwIdc3Xb9sMxG1HE6ata943I");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/team/teamInfo?teamId="+team.getId());/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        return AdvancedUtil.sendTemplateMessage(template);
    }

    public static boolean apply_success(UserEntity user,String name, ViewActivityPublishDetailEntity teamDetailEntity){
        /*
        * 报名成功通知
        *{{first.DATA}}
        * 志愿团队：{{keyword1.DATA}}
        * 志愿活动：{{keyword2.DATA}}
        * 开始时间：{{keyword3.DATA}}
        * 活动地点：{{keyword4.DATA}}
        * {{remark.DATA}}
        * 样例
        * 您好，您已成功报名了志愿活动！
          志愿团队：爱心志愿服务队
          志愿活动：爱心义卖活动
          开始时间：2017-1-11
          活动地点：步行街
          点击可查看活动详细
        * */
        String str_first = "您好，"+name+"已成功报名了你的活动！";
        String team_name = teamDetailEntity.getTeamName();
        String activity_name = teamDetailEntity.getName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String begin_time = bartDateFormat.format(teamDetailEntity.getBeginTime());
        String address = teamDetailEntity.getAddress();
        String str_remark = "点击详情查看具体细节";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", team_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",activity_name,"#173177"));
        templateParamList.add(new TemplateParam("keyword3",begin_time,"#173177"));
        templateParamList.add(new TemplateParam("keyword4",address,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("pSvMh9CtTUJrkkbNVbAWW0bIN2Xr5LMHEzF3zw9z05o");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
//        template.setUrl("https://open.weixin.qq.com/connect/oauth2/authorize?appid="+Configs.APPID+"&redirect_uri=http%3A%2F%2F"+Configs.DOMAINNAME+"%2Ftimebank%2share?url="+"team/manageActivities?activityId="+teamDetailEntity.getId()+"&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect");
        template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/team/manageActivities?activityId="+teamDetailEntity.getId());/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        return AdvancedUtil.sendTemplateMessage(template);

    }

    public static boolean sign_team(UserEntity user,String name ,TeamEntity team){
        /*
        *申请加入团队提醒
        *{{first.DATA}}
        * 团队名称：{{keyword1.DATA}}
        * 申请时间：{{keyword2.DATA}}
        * {{remark.DATA}}
        * 您已提交加入团队申请，请等待管理员审核！
          团队名称：天天开心读书会
          申请时间：2014年7月21日 18:36
          点击详情进入团队主页！
        * */
        String str_first = name+"提交加入团队申请，请等待管理员审核！！";
        String team_name = team.getName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String apply_time = bartDateFormat.format(new Date().getTime());
        String str_remark = "点击详情进入团队主页!";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", team_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",apply_time,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("kmZLKoja_RD_8Lx56tOk0t00vUrJY5zzE6i8tig6kOk");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/team/myTeamMember?teamId="+team.getId());/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        return AdvancedUtil.sendTemplateMessage(template);
    }

    public static boolean customer_appoint(UserEntity user, ViewPublishOrderDetailEntity viewPublishOrderDetailEntity){
        /*
        * 用户预约通知
        *{{first.DATA}}
          预约类型：{{keyword1.DATA}}
          预约时间：{{keyword2.DATA}}
          预约人姓名：{{keyword3.DATA}}
          预约人电话：{{keyword4.DATA}}
          {{remark.DATA}}
          样例：
          你有新的预约通知。
          预约类型：参观
          预约时间：2017年5月5日 13:00-14:00
          预约人姓名：小王
          预约人电话：18788888888
        * */
        String str_first = "您有新的预约通知！";
        String  type_name = viewPublishOrderDetailEntity.getServiceType()+":"+viewPublishOrderDetailEntity.getServiceName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String time = bartDateFormat.format(viewPublishOrderDetailEntity.getBeginTime())+"-"+bartDateFormat.format(viewPublishOrderDetailEntity.getEndTime());
        String service_Name = viewPublishOrderDetailEntity.getApplyUserName();
        String phone = viewPublishOrderDetailEntity.getApplyUserPhone().substring(0,7)+"xxxx";
        String str_remark = "点击详情查看具体细节";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", type_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",time,"#173177"));
        templateParamList.add(new TemplateParam("keyword3",service_Name,"#173177"));
        templateParamList.add(new TemplateParam("keyword4",phone,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("RNV0kGzN9THHwld16ACBN9XJDlYfCK3x2neGpf5V9bY");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/user/queryPublishWaitingConfirm");/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        return AdvancedUtil.sendTemplateMessage(template);
    }

    public static boolean customer_appoint(UserEntity user, ViewRequestOrderDetailEntity viewRequestOrderDetailEntity){

        /* 用户预约通知
        *{{first.DATA}}
          预约类型：{{keyword1.DATA}}
          预约时间：{{keyword2.DATA}}
          预约人姓名：{{keyword3.DATA}}
          预约人电话：{{keyword4.DATA}}
          {{remark.DATA}}
          样例：
          你有新的预约通知。
          预约类型：参观
          预约时间：2017年5月5日 13:00-14:00
          预约人姓名：小王
          预约人电话：18788888888
        */
        String str_first = "您有新的预约通知！";
        String service_type = viewRequestOrderDetailEntity.getServiceType().equals("volunteer")?"志愿者需求":viewRequestOrderDetailEntity.getServiceType().equals("mutualAid")?"互助需求":"专业需求";
        String  type_name = service_type+":"+viewRequestOrderDetailEntity.getServiceName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String time = bartDateFormat.format(viewRequestOrderDetailEntity.getBeginTime())+"-"+bartDateFormat.format(viewRequestOrderDetailEntity.getEndTime());
        String applyName = viewRequestOrderDetailEntity.getApplyUserName();
        String phone = viewRequestOrderDetailEntity.getApplyUserPhone().substring(0,7)+"xxxx";
        String str_remark = "点击详情查看具体细节";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", type_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",time,"#173177"));
        templateParamList.add(new TemplateParam("keyword3",applyName,"#173177"));
        templateParamList.add(new TemplateParam("keyword4",phone,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("RNV0kGzN9THHwld16ACBN9XJDlYfCK3x2neGpf5V9bY");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/request/published?tab=2");//此处可以加入想要跳转的链接
        template.setTemplateParamList(templateParamList);
        return AdvancedUtil.sendTemplateMessage(template);
    }

    //微信充值成功提醒
    public static boolean RechargeTemplate(UserEntity user,RechargeEntity recharge){
        //此处用与测试，增加微信充值模板消息提醒,暂时写在这后面模板数目增多，移到专门的类中
        String str_first = "充值通知:尊敬的"+ user.getName()+"您好：";
        String rechargeDate = recharge.getRechargeDate().toString();
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
        template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/user/recharge_detial?id="+recharge.getId());
        template.setTemplateParamList(templateParamList);

        // return AdvancedUtil.sendTemplateMessage(TokenThread.accessToken.getAccessToken(), template);
        return AdvancedUtil.sendTemplateMessage(template);
    }

    //申请结果通知
    public static boolean apply_result(UserEntity userEntity,ViewPublishOrderDetailEntity viewPublishOrderDetailEntity){
        /*
        * 申请结果通知
        *{{first.DATA}}
          申请人：{{keyword1.DATA}}
          申请类型：{{keyword2.DATA}}
          {{remark.DATA}}
        *样例
        * 李先生，您好！
          申请人：张三
          申请类型：预约会见法官
          您的申请已通过！请到个人中心查看详情
        * */
        Template template = new Template();
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        if("待服务".equals(viewPublishOrderDetailEntity.getStatus())) {
            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String time = bartDateFormat.format(viewPublishOrderDetailEntity.getBeginTime()) + "-" + bartDateFormat.format(viewPublishOrderDetailEntity.getEndTime());
            String str_first = "预约时间：" + time;
            String applyName = viewPublishOrderDetailEntity.getApplyUserName();
            String apply_type = viewPublishOrderDetailEntity.getServiceType() + "-" + viewPublishOrderDetailEntity.getServiceName();
            String str_remark = "您的申请已被接受，点击详情查看具体细节";

            templateParamList.add(new TemplateParam("first", str_first, "#173177"));
            templateParamList.add(new TemplateParam("keyword1", applyName, "#173177"));
            templateParamList.add(new TemplateParam("keyword2", apply_type, "#173177"));
            templateParamList.add(new TemplateParam("remark", str_remark, "#173177"));
            template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/user/queryOrderWaitingService");//此处可以加入想要跳转的链接
        }
        else{
            String str_first = "非常遗憾的通知您，您预约的"+viewPublishOrderDetailEntity.getServiceName()+"服务已被拒绝。"+"请不要难过，邻里智助为您提供海量服务，诚邀您前去浏览";
            String applyName = viewPublishOrderDetailEntity.getApplyUserName();
            String apply_type = viewPublishOrderDetailEntity.getServiceType() + "-" + viewPublishOrderDetailEntity.getServiceName();
            String str_remark = "您的申请已被拒绝，点击详情查看具体细节";
            templateParamList.add(new TemplateParam("first", str_first, "#173177"));
            templateParamList.add(new TemplateParam("keyword1", applyName, "#173177"));
            templateParamList.add(new TemplateParam("keyword2", apply_type, "#173177"));
            templateParamList.add(new TemplateParam("remark", str_remark, "#173177"));
            template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/publish/list?type=志愿者服务");//此处可以加入想要跳转的链接
        }
        template.setTemplateId("r3Y2DyaqXeUAqQRxzV8FfjNiXxA8Fax_7MTSx9Tu1hM");
        template.setToUser(userEntity.getOpenId());
        template.setTopColor("#173177");
        template.setTemplateParamList(templateParamList);
        return AdvancedUtil.sendTemplateMessage(template);

    }

    //申请结果通知
    public static boolean apply_result(UserEntity userEntity,ViewRequestOrderDetailEntity viewRequestOrderDetailEntity){
        /*
        * 申请结果通知
        *{{first.DATA}}
          申请人：{{keyword1.DATA}}
          申请类型：{{keyword2.DATA}}
          {{remark.DATA}}
        *样例
        * 李先生，您好！
          申请人：张三
          申请类型：预约会见法官
          您的申请已通过！请到个人中心查看详情
        * */
        Template template = new Template();
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        if("待服务".equals(viewRequestOrderDetailEntity.getStatus())) {
            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String time = bartDateFormat.format(viewRequestOrderDetailEntity.getBeginTime()) + "-" + bartDateFormat.format(viewRequestOrderDetailEntity.getEndTime());
            String str_first = "预约时间：" + time;
            String applyName = viewRequestOrderDetailEntity.getApplyUserName();
            String service_type = viewRequestOrderDetailEntity.getServiceType().equals("volunteer")?"志愿者需求":viewRequestOrderDetailEntity.getServiceType().equals("mutualAid")?"互助需求":"专业需求";
            String apply_type = service_type + "-" + viewRequestOrderDetailEntity.getServiceName();
            String str_remark = "您的申请已被接受，点击详情查看具体细节";

            templateParamList.add(new TemplateParam("first", str_first, "#173177"));
            templateParamList.add(new TemplateParam("keyword1", applyName, "#173177"));
            templateParamList.add(new TemplateParam("keyword2", apply_type, "#173177"));
            templateParamList.add(new TemplateParam("remark", str_remark, "#173177"));
            template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/request/applied?tab=2");//此处可以加入想要跳转的链接
        }
        else{
            String str_first = "非常遗憾的通知您，您预约的"+viewRequestOrderDetailEntity.getServiceName()+"需求已被拒绝。"+"请不要难过，邻里智助为您提供海量需求，诚邀您前去浏览";
            String applyName = viewRequestOrderDetailEntity.getApplyUserName();
            String apply_type = viewRequestOrderDetailEntity.getServiceType() + "-" + viewRequestOrderDetailEntity.getServiceName();
            String str_remark = "您的申请已被拒绝，点击详情查看具体细节";
            templateParamList.add(new TemplateParam("first", str_first, "#173177"));
            templateParamList.add(new TemplateParam("keyword1", applyName, "#173177"));
            templateParamList.add(new TemplateParam("keyword2", apply_type, "#173177"));
            templateParamList.add(new TemplateParam("remark", str_remark, "#173177"));
            template.setUrl("http://"+Configs.DOMAINNAME+"/timebanktest/request/list?type=volunteer");//此处可以加入想要跳转的链接
        }
        template.setTemplateId("r3Y2DyaqXeUAqQRxzV8FfjNiXxA8Fax_7MTSx9Tu1hM");
        template.setToUser(userEntity.getOpenId());
        template.setTopColor("#173177");
        template.setTemplateParamList(templateParamList);
        return AdvancedUtil.sendTemplateMessage(template);

    }

    //发送文字信息
    public static boolean TextMessage(String openid,String content) {
        Text text = new Text();
        text.setToUser(openid);
        text.setMsgType("text");
        text.setContent(content);
        return AdvancedUtil.sendCustomMessage(text.toJSON());
    }


}
