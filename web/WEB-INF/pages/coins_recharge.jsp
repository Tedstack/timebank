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

    <div class="weui-msg__icon-area">
        <img src="../img/coin.jpg" width="300" height="100">
    </div>

    <div class="weui-msg__text-area">
        <h1 class="weui-msg__title" style="font-size: x-large"><b>充值金额</b></h1>
        <div class="weui-cell">
            <div class="weui-cell__hd"><label class="weui-label" style="font-size: xx-large">￥</label></div>
            <div class="weui-cell__bd">
                <input class="weui-input" type="number" id="totalAmount" name="totalAmount" style="font-size: xx-large"  placeholder="" required/>
            </div>
        </div>
    </div>

    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <button type="submit" id="btn_charge" class="weui-btn weui-btn_primary">下一步</button>
        </p>
    </div>

</div>

<script>
    var url='${pageContext.request.contextPath}';

    $(document).ready(function(){
        $("#btn_charge").click(function () {
            var amount = $("#totalAmount").val();
            $.post(
                url + "/coins_recharge_submit",
                {
                    totalAmount: amount
                },
                function (data, status) {
                    console.log("accept data:" + data);
                    alert(data);

                    $.post(
                            "https://api.mch.weixin.qq.com/pay/unifiedorder",
                            {
                                data
                            },
                            function (data, status) {
                                alert(data);
                            }
                    );

                }
            );
        });
    });




    $().invoke("/pay/do/pay.q", null, function (re) {
        var result = JSON.parse(re);
        result['timeStamp'] = result['timeStamp'] + "";
        function onBridgeReady(){
            WeixinJSBridge.invoke(
                    'getBrandWCPayRequest', result, function(res){
                        alert(JSON.stringify(res));
                        if(res.err_msg == "get_brand_wcpay_request:ok" ) {
                            //doit 这里处理支付成功后的逻辑，通常为页面跳转
                        }
                    }
            );
        }
        if (typeof WeixinJSBridge == "undefined"){
            if( document.addEventListener ){
                document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
            }else if (document.attachEvent){
                document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
                document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
            }
        }else{
            onBridgeReady();
        }
    });


</script>

</body>
</html>
