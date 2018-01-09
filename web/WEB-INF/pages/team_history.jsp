<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: weiyi
  Date: 2017/12/24
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>历史活动</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    List<ActivityPublishEntity> publicActivity=(List<ActivityPublishEntity>) request.getAttribute("publicActivity");
    List<ActivityPublishEntity> privateActivity=(List<ActivityPublishEntity>) request.getAttribute("privateActivity");
%>
<div class="page">
    <div class="weui-panel__hd">
        <div class="weui-flex__item" id="return" onclick="goBack()" >
            <p><img src="../img/back.png" width="20" height="15"alt="">团体历史活动</p>
        </div>
    </div>
    <div class="weui-navbar" style="top: 0px;margin : 35px 0px 10px 0px;">
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/teamIndex?teamId=<%out.print(request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">简介</a>
        </div>
        <div class="weui-navbar__item" style="border:1px solid #0076FF;">
            <a href="${pageContext.request.contextPath}/team/teamMember?teamId=<%out.print(request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">成员</a>
        </div>
        <div class="weui-navbar__item" style="background-color: #0076FF;">
            <a lass="weui-btn weui-btn_plain-default" style="background-color:#0076FF;border: none;color:#ffffff;height: 25px;font-size: 14px;">历史活动</a>
        </div>
    </div>
    <img src="../img/底部.png" width="100%" height="15" style="margin-top: 60px;">
    <%
        for(int i=0;i<publicActivity.size();i++){
    %>
    <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=1&activityID=<%out.print(publicActivity.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
        <div class="weui-media-box__hd">
            <img class="weui-media-box__thumb" src="../img/userdetails/专业服务认证.png" alt="">
        </div>
        <div class="weui-media-box__bd">
            <h4 class="weui-media-box__title"><%out.print(publicActivity.get(i).getName());%></h4>
            <p class="weui-media-box__desc">开始时间:
                <%
                    Timestamp beginTimestamp = publicActivity.get(i).getBeginTime();
                    Date date = new Date(beginTimestamp.getTime());
                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    out.print(bartDateFormat.format(date));
                %></p>
            <p class="weui-media-box__desc">结束时间:
                <%
                    Timestamp endTimestamp = publicActivity.get(i).getEndTime();
                    Date date2 = new Date(endTimestamp.getTime());
                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    out.print(bartDateFormat2.format(date2));
                %></p>
            <ul class="weui-media-box__info">
                <li class="weui-media-box__info__meta"><%out.print(publicActivity.get(i).getCount());%>人</li>
                <li class="weui-media-box__info__meta"><%out.print(publicActivity.get(i).getAddress());%></li>
            </ul>
        </div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <%}%>
    <%
        for(int i=0;i<privateActivity.size();i++){
    %>
    <div class="weui-panel__bd">
        <div class="weui-cells weui-cells_checkbox">
            <label class="weui-cell weui-check__label">
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                    <img src="../img/ezio.jpg" style="width: 50px;display: block">
                </div>
                <div class="weui-cell__bd">
                    <p><%out.print(privateActivity.get(i).getName());%></p>
                    <%--<p style="font-size: 13px;color: #888888;">地点：中山北路3773号</p>--%>
                    <p style="font-size: 13px;color: #888888;">概要:<%out.print(privateActivity.get(i).getDescription());%></p>
                </div>
                <div class="weui-cell__bd" style="text-align: right;">
                    <p style="font-size: 13px;color: #888888;"><%out.print(privateActivity.get(i).getBeginTime());%></p>
                    <p>~</p>
                    <p style="font-size: 13px;color: #888888;"><%out.print(privateActivity.get(i).getEndTime());%></p>
                </div>
            </label>
        </div>
    </div>
    <%}%>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    function goBack() {
        window.location.href="${pageContext.request.contextPath}/team/teamList";
    }
</script>
</html>
