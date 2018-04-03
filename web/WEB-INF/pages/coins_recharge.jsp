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
    <title>我的互助时间</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>

<div class="weui-tab">
    <div class="weui-panel">
        <div class="weui-msg">

            <div class="weui-msg__icon-area">
                <img src="../img/coin.jpg" width="100" height="100">
            </div>

            <div class="weui-msg__text-area">
                <h1 class="weui-msg__title" style="font-size: x-large"><b>充值金额</b></h1>
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label" style="font-size: xx-large">￥</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="number" id="totalAmount" name="totalAmount" style="font-size: xx-large"  placeholder="0.00" step="0.01" min="0.01" required/>

                    </div>
                </div>
            </div>

            <div class="weui-msg__opr-area">
                <p class="weui-btn-area">
                    <button type="submit" id="btn_charge" class="weui-btn weui-btn_primary">支付</button>
                </p>
            </div>

        </div>
        <div class="weui-media-box">
            <div class="weui-media-box__title">
                <span style="color:#76b852">充值互助时间须知</span>
            </div>
            <div class="weui-media-box__info">
               <span>用户您好，您在进行充值业务，暂无提现功能<br><br>￥1 = 1互助时间</span>
            </div>
        </div>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';

    $(document).ready(function(){
        $("#btn_charge").click(function () {
            var reg = new RegExp("^\\d+(\\.\\d{0,2})?$");
            var amount = $("#totalAmount").val();
           // alert(url + "/recharge/coins_recharge_submit" + amount);
            if(amount ===""){
                alert("请输入充值金额");
                return;
            }else if(amount <"0.01") {
                alert("请输入有效金额");
                return;
            }else if(!reg.test(amount)){
                alert("请您输入正确的金额（只包含两位小数）");
                return;
            }
            $.post(
                url + "/recharge/coins_recharge_submit",
                {
                    totalAmount: amount
                },
                function (data, status) {
                    console.log("accept data:" + data);
                    //alert(data);
                    var obj=JSON.parse(data);
                    //alert(obj.packageStr);
                    function onBridgeReady(){
                        WeixinJSBridge.invoke(
                                'getBrandWCPayRequest', {
                                    appId:obj.appId,     //公众号名称，由商户传入
                                    timeStamp:obj.timeStamp,         //时间戳，自1970年以来的秒数
                                    nonceStr:obj.nonceStr, //随机串
                                    package:obj.packageStr,
                                    signType:obj.signType,         //微信签名方式：
                                    paySign: obj.paySign//微信签名
                                },
                                function(res){
                                    if(res.err_msg == "get_brand_wcpay_request:ok" ) {
                                        self.location= url + "/recharge/send_template";
                                    }     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
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

                }
            );
        });
    });




</script>

</body>
</html>
