<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2017/12/25
  Time: 15:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的志愿者时间</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="weui-tab">
    <%
        UserEntity userEntity = (UserEntity) request.getAttribute("user");
    %>
    <div class="weui-tab__panel">
        <div class="weui-panel">
            <div class="weui-panel__hd">
                <span>志愿者时间</span>
                <a href="${pageContext.request.contextPath}/user/queryVolPublishAlComplete" style="float:right;text-decoration: none">志愿者时间明细</a>
            </div>
            <div class="weui-panel__bd">
                <div class="weui-msg">
                    <div class="weui-msg__icon-area">
                        <img src="../img/userdetails/志愿者.png" width="100" height="100">
                    </div>

                    <div class="weui-msg__text-area">
                        <h1 class="weui-msg__title" style="font-size: x-large">我的志愿者时间</h1>
                        <h2 class="weui-msg__title" style="font-size: xx-large"><%out.print(userEntity.getTimeVol()); %></h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>