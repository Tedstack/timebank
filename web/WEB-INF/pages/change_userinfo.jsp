<%@ page import="com.blockchain.timebank.weixin.util.TokenThread" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="com.blockchain.timebank.weixin.util.Configs" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>个人信息</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link href="../css/mobile-main.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/refundRobot.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    UserEntity user = (UserEntity) request.getAttribute("user");
%>

<div class="weui-cells__title">我的二维码</div>
<div class="weui-cells weui-cells_form">

    <div class="weui-cell weui-cell_vcode">
        <div class="weui-cell__hd"><label class="weui-label">二维码</label></div>
        <div class="weui-cell__bd">
            <label class="weui-form-preview__label" id="curqrcode" name="qrcode">当前二维码</label>
        </div>
        <div class="weui-cell__ft">
            <a href="javascript:;" class="weui-vcode-btn" id="addBtn">添加二维码</a>
        </div>
    </div>
</div>
<div id="qrcode" style="padding-left: 23%; padding-top: 30px">
</div>

<div class="button-sp-area">
    <div style="padding: 10px;">
        <button type="submit" class="weui-btn weui-btn_primary" id="commitBtn">确认修改</button>
    </div>
</div>


<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="../js/qrcode.js" type="text/javascript"></script>
<script type="text/javascript">
    var qrcode2='<%=user.getQrCode()%>';
    var contextPath="${pageContext.request.contextPath}";
    $(function(){
        if((qrcode2!=='null')&&(qrcode2!=="")){
            $('#curqrcode').text(qrcode2);
            $("#addBtn").text('无需添加');
            $("#commitBtn").hide();

                var qrcode1 = new QRCode(document.getElementById("qrcode"), {
                    width : 200,//设置宽高
                    height : 200
                });
                qrcode1.makeCode(qrcode2);
                document.getElementById("send").onclick =function(){
                    qrcode1.makeCode(document.getElementById("getval").value);
                }

        }else{
            $("#addBtn").on('click',function () {
                <%
                    TokenThread.appId = Configs.APPID; //获取servlet初始参数appid和appsecret
                    TokenThread.appSecret = Configs.APPSECRET;

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
                            $('#curqrcode').text(res.resultStr);
                            //qrcode = res.resultStr;
                        }
                    }
                );
            });

            $("#commitBtn").on('click',function () {
                var targetUrl = "http://"+getDomainName()+contextPath+"/user/modifyPersonalInfo";
                var targetUrl2 = "http://"+getDomainName()+contextPath+"/user/startModifyPersonalInfo";
                var curqrcode = $('#curqrcode').text();
                var re = /^[a-zA-Z]\d{9}$/;
                if(!re.test(curqrcode)) {
                    showAlert("此二维码非邻里智助官方二维码！");
                    return;
                }
                if(curqrcode!==""){
                    $.ajax({
                        type: 'POST',
                        cache: false,
                        url: targetUrl,
                        //dataType:'JSONP',
                        data: "qrcode=" + curqrcode,
                        beforeSend: function (XHR) {
                            dialogLoading = showLoading();
                        },
                        success: function (data) {
                            if(data==="ok"){
                                showAlert("更改成功",function () {
                                    goTo(targetUrl2);
                                });
                            }else if(data==="error"){
                                showAlert("更改失败");
                            }else{
                                showAlert("该二维码已被他人注册");
                            }
                        },
                        error: function (xhr, type) {
                            showAlert("更改失败");
                        },
                        complete: function (xhr, type) {
                            dialogLoading.hide();
                        }
                    });
                }else{
                    showAlert("二维码不得为空");
                }

            });
        }

    });
</script>
</body>
</html>