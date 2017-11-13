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
</head>
<body>
<%
    long recordID = (long) request.getAttribute("recordID");
%>
<div class="page">
    <div class="weui-msg">
        <div class="weui-msg__icon-area"><i class="weui-icon-waiting weui-icon_msg"></i></div>
        <div class="weui-msg__text-area">
            <h2 class="weui-msg__title">扫码服务</h2>
            <p class="weui-msg__desc">点击按钮开始扫码</p>
        </div>
        <div class="weui-msg__opr-area">
            <p class="weui-btn-area">
                <a class="weui-btn weui-btn_primary" id="button1">扫码</a>
            </p>
        </div>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function() {
            $("#button1").on('click', function () {
                wx.scanQRCode(
                    {
                        needResult:1,
                        success:function(res){

                            //alert(JSON.stringify(res.resultStr));

                            var recordID = getQueryString("recordID");
                            //alert(JSON.stringify(recordID));
                            //setTimeout("window.location.href(/"http://www.baidu.com/")",500);
                            //window.location.href = "http://www.baidu.com?t="+new Date().getTime();
                            //return View("register");

                            $.ajax({
                                type: 'POST',
                                cache: false,
                                url: "http://www.hlb9978.com/user/serviceUserCompleteScan",
                                data: "qrcode=" + res.resultStr + "&recordID=" + recordID,
                                beforeSend: function (XHR) {
                                    dialogLoading = showLoading();
                                },
                                success: function (data) {
                                    if(data=="failure"){
                                        showAlert("二维码与申请者不相符",function () {
                                            goTo("http://www.hlb9978.com/user/queryPublishWaitingService");
                                        })
                                    }
                                    if(data=="success"){
                                        showAlert("扫码成功",function () {
                                            goTo("http://www.hlb9978.com/user/queryPublishWaitingService");
                                        })
                                    }

                                },
                                error: function (xhr, type) {
                                    showAlert("扫码失败",function () {
                                        goTo("http://www.hlb9978.com/user/queryPublishWaitingService");
                                    })
                                },
                                complete: function (xhr, type) {
                                    dialogLoading.hide();
                                }
                            });
                        }
                    }
                );
                //window.location.href = "http://www.baidu.com?t="+new Date().getTime();
            });
        });
    </script>
</body>
</html>
