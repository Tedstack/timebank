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
<div class="weui-msg">
    <div class="weui-msg__icon-area">
        <img src="../img/币.png" width="100" height="100">
    </div>

    <div class="weui-msg__text-area">
        <h1 class="weui-msg__title" style="font-size: x-large">我的时间币</h1>
        <h2 class="weui-msg__title" style="font-size: xx-large">$ 25</h2>
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
</body>
</html>
