
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
        <img src="../img/coin.jpg" width="100" height="100">
    </div>

    <div class="weui-msg__text-area">
        <h1 class="weui-msg__title" style="font-size: x-large">我的时间币</h1>
        <h2 class="weui-msg__title" style="font-size: xx-large">$ ${TimeCoin}</h2>
    </div>

    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="${pageContext.request.contextPath}/recharge/coins_recharge" class="weui-btn weui-btn_primary">充值</a>
        </p>
        <p class="weui-btn-area">
            <a href="" class="weui-btn weui-btn_default">提现</a>
        </p>
    </div>
</div>
</body>
</html>