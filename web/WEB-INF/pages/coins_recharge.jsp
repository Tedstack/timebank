<%@ page import="java.util.ArrayList" %>
<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.controller.RechargeController" %><%--
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
    <form action="${pageContext.request.contextPath}/recharge/coins_recharge" method="post">
        <div class="weui-msg__icon-area">
            <img src="../img/coin.jpg" width="300" height="100">
        </div>

        <div class="weui-msg__text-area">
            <h1 class="weui-msg__title" style="font-size: x-large"><b>充值金额</b></h1>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label class="weui-label" style="font-size: xx-large">￥</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" type="number" name="totalAmount" style="font-size: xx-large"  placeholder="" required/>
                </div>
            </div>
        </div>

        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <button type="submit" href="" class="weui-btn weui-btn_primary">下一步</button>
            </p>
        </div>
    </form>

</div>
</body>
</html>
