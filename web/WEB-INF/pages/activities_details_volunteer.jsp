<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %><%--
<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/20
  Time: 13:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.blockchain.timebank.entity.ActivityPublishEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserActivityEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>活动详情</title>
</head>
<body>
<%
    ViewPublishDetailEntity detailEntity = (ViewPublishDetailEntity) request.getAttribute("detail");
%>
<div class="weui-tab">
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0;">
            <a href="javascript:void(0)">
                <div class="shop-logo">
                    <img src="../img/服务类型/志愿者服务.png" alt="">
                </div>
                <div class="txt"></div>
                <div class="tags-rz">
                    <span class="tag-sm">志愿者活动</span>
                </div>
            </a>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动名称</p>
                </div>
                <div class="weui-cell__ft"><%=detailEntity.getUserId()%></div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>组织团队</p>
                </div>
                <div class="weui-cell__ft"><%=detailEntity.getUserId()%></div>
            </div>

            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>开始时间</p>
                </div>
                <div class="weui-cell__ft">
                    <!--<%-->
                    <!--Timestamp beginTimestamp = activity.getBeginTime();-->
                    <!--Date date = new Date(beginTimestamp.getTime());-->
                    <!--SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");-->
                    <!--out.print(bartDateFormat.format(date));-->
                    <!--%>-->
                </div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>结束时间</p>
                </div>
                <div class="weui-cell__ft">
                    <!--<%-->
                    <!--Timestamp endTimestamp = activity.getEndTime();-->
                    <!--Date date2 = new Date(endTimestamp.getTime());-->
                    <!--SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");-->
                    <!--out.print(bartDateFormat2.format(date2));-->
                    <!--%>-->
                </div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>申请结束时间</p>
                </div>
                <div class="weui-cell__ft">
                    <!--<%-->
                    <!--Timestamp applyEndTimestamp = activity.getApplyEndTime();-->
                    <!--Date date3 = new Date(applyEndTimestamp.getTime());-->
                    <!--SimpleDateFormat bartDateFormat3 = new SimpleDateFormat("yyyy-MM-dd HH:mm");-->
                    <!--out.print(bartDateFormat3.format(date3));-->
                    <!--%>-->
                </div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动地点</p>
                </div>
                <div class="weui-cell__ft">地点</div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span>详情描述</span>
            </div>
            <div class="con_u">描述</div>
        </div>
        <div class="weui-cells__title" style="color: #7ACF41;text-align:center;font-size: small;font-weight: bold">已报名人员</div>
        <div class="weui-cells">
            <!--以下循环参加的人数-->
            <div class="weui-cell" id="cell1">
                <div class="weui-cell__bd">
                    <p style="font-size: 90%">孙芃达+团队身份</p>
                </div>
            </div>
            <!--以上-->
        </div>
        <div style="padding: 10px; margin-bottom: 20px;">
            <a id="applyBtn" href=" " class="weui-btn weui-btn_primary">退出活动</a>
        </div>
    </div>
</body>
</html>
