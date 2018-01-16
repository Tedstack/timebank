<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.*" %><%--
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
    List<ViewTeamUserDetailEntity> userList=(List<ViewTeamUserDetailEntity>) request.getAttribute("userList");
    List<ViewTeamUserDetailEntity> managerList=(List<ViewTeamUserDetailEntity>) request.getAttribute("managerList");
    UserEntity creator=(UserEntity) request.getAttribute("creator");
    String tab=(String) request.getAttribute("tab");
    long activityId=CommenData.getActivityId();
%>
<div class="page">
    <div class="weui-navbar" style="top: 0px;margin : 0px 0px 10px 0px;">
        <%if(tab.equalsIgnoreCase("0")){%>
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/teamIndex?tab=0&teamId=<%out.print((String) request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">简介</a>
        </div>
        <div class="weui-navbar__item" style="background-color: #0076FF;">
            <a class="weui-btn weui-btn_plain-default" style="background-color:#0076FF;color: #ffffff;border: none;height: 25px;font-size: 14px; ">成员</a>
        </div>
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/historyActivity?tab=0&teamId=<%out.print((String) request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">历史活动</a>
        </div>
        <%}else{%>
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/teamIndex?tab=1&teamId=<%out.print((String) request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">简介</a>
        </div>
        <div class="weui-navbar__item" style="background-color: #0076FF;">
            <a class="weui-btn weui-btn_plain-default" style="background-color:#0076FF;color: #ffffff;border: none;height: 25px;font-size: 14px; ">成员</a>
        </div>
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/historyActivity?tab=1&teamId=<%out.print((String) request.getAttribute("teamId"));%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">历史活动</a>
        </div>
        <%}%>

    </div>
    <div class="weui-panel__bd" style="margin : 80px 0px 10px 0px;">
        <div class="weui-cells weui-cells_checkbox">
            <label class="weui-cell weui-check__label">
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                    <img src="<%out.print(creator.getHeadImgUrl());%>" style="width: 50px;display: block">
                </div>
                <div class="weui-cell__bd">
                    <p><%out.print(creator.getName());%></p>
                    <p style="font-size: 13px;color: #888888;">创建者</p>
                </div>
            </label>
        </div>
    </div>
    <%
        if(managerList.size()>0){
            for(int i=0;i<managerList.size();i++){%>
    <div class="weui-panel__bd" style="margin : 0px 0px 10px 0px;">
        <div class="weui-cells weui-cells_checkbox">
            <label class="weui-cell weui-check__label">
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                    <img src="<%out.print(managerList.get(i).getUserHeadImg());%>" style="width: 50px;display: block">
                </div>
                <div class="weui-cell__bd">
                    <p><%out.print(managerList.get(i).getUserName());%></p>
                    <p style="font-size: 13px;color: #888888;">管理员</p>
                </div>
            </label>
        </div>
    </div>
            <%}
        }
    %>
    <%
        for(int i=0;i<userList.size();i++){
    %>
    <div class="weui-panel__bd" style="margin : 0px 0px 10px 0px;">
        <div class="weui-cells weui-cells_checkbox">
            <label class="weui-cell weui-check__label">
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                    <img src="<%out.print(userList.get(i).getUserHeadImg());%>" style="width: 50px;display: block">
                </div>
                <div class="weui-cell__bd">
                    <p><%out.print(userList.get(i).getUserName());%></p>
                    <p style="font-size: 13px;color: #888888;">成员</p>
                </div>
            </label>
        </div>
    </div>
    <%}%>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="../js/utils.js"></script>
<script type="text/javascript">
    var tab='<%=tab%>';
    var activityId='<%=activityId%>';
    if(tab==='0')
        back_to("${pageContext.request.contextPath}/team/teamList");
    else
        back_to("${pageContext.request.contextPath}/team/teamActivityDetails?type=0&activityID="+activityId);
</script>
</html>
