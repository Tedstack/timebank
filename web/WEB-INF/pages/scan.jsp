<%--
  Created by IntelliJ IDEA.
  User: xu
  Date: 2017/7/12
  Time: 下午2:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="full-screen" content="yes">
    <meta name="x5-fullscreen" content="true">
    <title>扫码服务</title>
    <link href="../css/weui.min.css" rel="stylesheet" />
    <link href="../css/mobile-main.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/refundRobot.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<div class="page">
    <div class="weui-msg">
        <!--以上~~-->
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a class="weui-btn weui-btn_primary" id="button1">扫码</a>
            </p>
        </div>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var contextPath="${pageContext.request.contextPath}";
    $(function() {
        $("#button1").on('click', function () {
            wx.scanQRCode(
                {
                    needResult:0,
                    success:function(res){

                        //alert(JSON.stringify(res.resultStr));

                    }
                }
            );
            //window.location.href = "http://www.baidu.com?t="+new Date().getTime();
        });
    });
</script>
</body>
</html>
