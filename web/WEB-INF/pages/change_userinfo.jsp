<%@ page import="com.blockchain.timebank.scan.util.TokenThread" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>更改个人信息</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link href="../css/mobile-main.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/refundRobot.js"></script>
</head>
<body>

<form action="/user/modifyPersonalInfo" method="post">

<div class="weui-cells__title">个人信息</div>
<div class="weui-cells weui-cells_form">

    <div class="weui-cell weui-cell_vcode">
        <div class="weui-cell__hd"><label class="weui-label">二维码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="curqrcode" name="qrcode" placeholder="当前二维码"/>
        </div>
        <div class="weui-cell__ft">
            <a href="javascript:;" class="weui-vcode-btn" id="addBtn">添加二维码</a>
        </div>
    </div>
</div>


<div class="button-sp-area">
    <div style="padding: 10px;">
        <button type="submit" class="weui-btn weui-btn_primary">确认修改</button>
    </div>
</div>
</form>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        $("#addBtn").on('click',function () {
            <%
                TokenThread.appId = "wxb0f6b07f01978a2a"; //获取servlet初始参数appid和appsecret
                TokenThread.appSecret = "386ef712d87480fa1dc27a93995936eb";
                System.out.println("appid:"+TokenThread.appId);
                System.out.println("appSecret:"+TokenThread.appSecret);
                Thread thread = new Thread(new TokenThread());
                thread.start(); //启动进程
            %>
            var qrcode = '';
            wx.scanQRCode(
                {
                    needResult:1,
                    success:function(res){
                        //alert(JSON.stringify(res.resultStr));
                        //alert(res.resultStr);
                        $('#curqrcode').val(res.resultStr);
                        //qrcode = res.resultStr;
                    }
                }
            );
        });
    });
</script>
</body>
</html>