package com.blockchain.timebank.weixin.util;


import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.weixin.model.Template;
import com.blockchain.timebank.weixin.model.TemplateParam;

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
        UserEntity userEntity = user;
        String str_first = "您已成功加入团队！";
        String team_name = team.getName();
        String join_time = "2017-1-10";
        String str_remark = "可进入查看我的团队详情";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", team_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",join_time,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("-5-0HZeo4Yh1eHQA8aD-kEPOx5v8TqCPEZHDfnqmACk");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("");/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        if(null != TokenThread.accessToken && null != TokenThread.accessToken.getAccessToken()) {
            return AdvancedUtil.sendTemplateMessage(TokenThread.accessToken.getAccessToken(), template);
        }
        else{
            System.out.println("tokenThread.accessToken为空");
            return false;
        }
    }

    public static boolean apply_success(UserEntity user, ViewActivityPublishDetailEntity teamDetailEntity){
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
        UserEntity userEntity = user;
        String str_first = "您好，您已成功报名了志愿活动！";
        String team_name = teamDetailEntity.getTeamName();
        String activity_name = teamDetailEntity.getName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String begin_time = bartDateFormat.format(teamDetailEntity);
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
        template.setTemplateId("9LSNLuG22FxbGV6FAHIY6fmVKC2J-6dzp2USkQwi3jA");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("");/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        if(null != TokenThread.accessToken && null != TokenThread.accessToken.getAccessToken()) {
            return AdvancedUtil.sendTemplateMessage(TokenThread.accessToken.getAccessToken(), template);
        }
        else{
            System.out.println("tokenThread.accessToken为空");
            return false;
        }

    }

    public static boolean sign_team(UserEntity user ,TeamEntity team){
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
        UserEntity userEntity = user;
        String str_first = "您已提交加入团队申请，请等待管理员审核！！";
        String team_name = team.getName();
        String apply_time="2017-01-01 12:18";
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
        template.setUrl("");/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        if(null != TokenThread.accessToken && null != TokenThread.accessToken.getAccessToken()) {
            return AdvancedUtil.sendTemplateMessage(TokenThread.accessToken.getAccessToken(), template);
        }
        else{
            System.out.println("tokenThread.accessToken为空");
            return false;
        }
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
        UserEntity userEntity = user;
        String str_first = "您有新的预约通知！";
        String  type_name = viewPublishOrderDetailEntity.getServiceType()+":"+viewPublishOrderDetailEntity.getServiceName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String time = bartDateFormat.format(viewPublishOrderDetailEntity.getBeginTime())+"-"+bartDateFormat.format(viewPublishOrderDetailEntity.getEndTime());
        String service_Name = viewPublishOrderDetailEntity.getServiceUserName();
        String phone = viewPublishOrderDetailEntity.getServiceUserPhone();
        String str_remark = "点击详情查看具体细节";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", type_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",time,"#173177"));
        templateParamList.add(new TemplateParam("keyword3",service_Name,"#173177"));
        templateParamList.add(new TemplateParam("keyword4",phone,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("qEYO2xxF0FYvQIJddgcQiLTSJi9VSi5kfnDZU1Gbv3E");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("");/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        if(null != TokenThread.accessToken && null != TokenThread.accessToken.getAccessToken()) {
            return AdvancedUtil.sendTemplateMessage(TokenThread.accessToken.getAccessToken(), template);
        }
        else{
            System.out.println("tokenThread.accessToken为空");
            return false;
        }
    }

    public static boolean customer_appoint(UserEntity user, ViewRequestOrderDetailEntity viewRequestOrderDetailEntity){
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
        UserEntity userEntity = user;
        String str_first = "您有新的预约通知！";
        String  type_name = viewRequestOrderDetailEntity.getServiceType()+":"+viewRequestOrderDetailEntity.getServiceName();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String time = bartDateFormat.format(viewRequestOrderDetailEntity.getBeginTime())+"-"+bartDateFormat.format(viewRequestOrderDetailEntity.getEndTime());
        String applyName = viewRequestOrderDetailEntity.getApplyUserName();
        String phone = viewRequestOrderDetailEntity.getApplyUserPhone();
        String str_remark = "点击详情查看具体细节";
        List<TemplateParam> templateParamList = new ArrayList<TemplateParam>();
        templateParamList.add(new TemplateParam("first",str_first, "#173177"));
        templateParamList.add(new TemplateParam("keyword1", type_name, "#173177"));
        templateParamList.add(new TemplateParam("keyword2",time,"#173177"));
        templateParamList.add(new TemplateParam("keyword3",applyName,"#173177"));
        templateParamList.add(new TemplateParam("keyword4",phone,"#173177"));
        templateParamList.add(new TemplateParam("REMARK",str_remark, "#173177"));

        Template template = new Template();
        template.setTemplateId("qEYO2xxF0FYvQIJddgcQiLTSJi9VSi5kfnDZU1Gbv3E");
        template.setToUser(user.getOpenId());
        template.setTopColor("#173177");
        template.setUrl("");/*此处可以加入想要跳转的链接*/
        template.setTemplateParamList(templateParamList);
        if(null != TokenThread.accessToken && null != TokenThread.accessToken.getAccessToken()) {
            return AdvancedUtil.sendTemplateMessage(TokenThread.accessToken.getAccessToken(), template);
        }
        else{
            System.out.println("tokenThread.accessToken为空");
            return false;
        }
    }


}
