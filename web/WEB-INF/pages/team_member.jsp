<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.TeamEntity" %>
<%@ page import="com.blockchain.timebank.entity.TeamUserEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %><%--
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
    <title>团队成员</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    List<UserEntity> userList=(List<UserEntity>) request.getAttribute("userList");
    String managerName=(String) request.getAttribute("managerName");
%>
<div class="page">
    <div class="weui-panel__hd">
        <div class="weui-flex__item" id="return" onclick="goBack()" >
            <p><img src="../img/back.png" width="20" height="15"alt="">团体成员</p>
        </div>
    </div>
    <div class="weui-navbar" style="top: 0px;margin : 35px 0px 10px 0px;">
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/teamIndex?teamId=<%out.print((String) request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">简介</a>
        </div>
        <div class="weui-navbar__item" style="background-color: #0076FF;">
            <a class="weui-btn weui-btn_plain-default" style="background-color:#0076FF;color: #ffffff;border: none;height: 25px;font-size: 14px; ">成员</a>
        </div>
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/historyActivity?teamId=<%out.print((String) request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">历史活动</a>
        </div>
    </div>
    <div class="weui-panel__bd" style="margin : 80px 0px 10px 0px;">
        <div class="weui-cells weui-cells_checkbox">
            <label class="weui-cell weui-check__label">
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                    <img src="../img/ezio.jpg" style="width: 50px;display: block">
                </div>
                <div class="weui-cell__bd">
                    <p><%out.print(managerName);%></p>
                    <p style="font-size: 13px;color: #888888;">创建者</p>
                </div>
            </label>
        </div>
    </div>
    <%
        for(int i=0;i<userList.size();i++)
        {
    %>
    <div class="weui-panel__bd" style="margin : 0px 0px 10px 0px;">
        <div class="weui-cells weui-cells_checkbox">
            <label class="weui-cell weui-check__label">
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                    <img src="../img/我的.png" style="width: 50px;display: block">
                </div>
                <div class="weui-cell__bd">
                    <p><%out.print(userList.get(i).getName());%></p>
                    <p style="font-size: 13px;color: #888888;">成员</p>
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
