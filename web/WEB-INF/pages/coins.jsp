<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%--
Created by IntelliJ IDEA.
User: bobo9978
Date: 2017/12/11
Time: 19:28
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的时间币</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>

<div class="weui-tab">
    <%
        UserEntity userEntity=(UserEntity)request.getAttribute("user");
    %>
    <div class="weui-tab__panel">
        <div class="weui-panel__hd">
            <span>我的时间币</span>
            <a href="../pages/coins_detail.html" style="float:right;text-decoration: none">时间币明细</a>
        </div>
        <div class="weui-panel__bd">
            <div class="weui-msg">
                <div class="weui-msg__icon-area">
                    <img src="../img/userdetails/时间币.png" width="100" height="100">
                </div>

                <div class="weui-msg__text-area">
                    <p class="weui-msg__title">我的时间币</p>
                    <p class="weui-msg__title"><%out.print(userEntity.getTimeCoin()); %></p>
                </div>

                <div class="weui-msg__opr-area">
                    <p class="weui-btn-area">
                        <a href="${pageContext.request.contextPath}/user/pay" class="weui-btn weui-btn_primary">充值</a>
                    </p>
                    <p class="weui-btn-area">
                        <a href="" class="weui-btn weui-btn_default">提现</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
