<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>注册验证</title>
    <!-- 引入 WeUI -->
    <link href="css/weui.min.css" rel="stylesheet" />
    <script src="js/zepto/zepto.min.js"></script>
    <script src="js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="js/scan/function.js"></script>
    <script src="js/scan/configs.js"></script>
</head>
<body>
<%
    String openID = (String) request.getAttribute("openID");
    String code = (String) request.getAttribute("code");
%>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell weui-cell_vcode">
        <div class="weui-cell__hd">
            <label class="weui-label">手机号</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" type="tel" id="phone" placeholder="请输入手机号">
        </div>
        <div class="weui-cell__ft">
            <a href="javascript:;" id="msgbtn" class="weui-vcode-btn">获取验证码</a>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">验证码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="msgid"  placeholder="请输入验证码"/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">姓名</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="name" placeholder="请输入真实姓名"/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">密码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input"  id="pwd1" type="password"/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">确认密码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="pwd2" type="password"/>
        </div>
    </div>
    <div style="padding: 10px; margin-bottom: 20px;">
        <a href="javascript:;" class="weui-btn weui-btn_primary" id="create">注册</a>
    </div>
</div>
<script src="http://lib.sinaapp.com/js/jquery/1.12.4/jquery-1.12.4.min.js"></script>
<script src="js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    var openID='<%=openID%>';
    var code='<%=code%>';
    var contextPath="${pageContext.request.contextPath}";
    var codemsg;
    //短信通知
    $("#msgbtn").on('click', function () {
        var targetUrl = "http://"+getDomainName()+contextPath+"/user/register";
        var phoneNumber=document.getElementById("phone").value;
        var re = /^1\d{10}$/
        if(re.test(phoneNumber)){
            buttonCountdown($(this), 1000 * 60 * 3, "ss");
            register(phoneNumber,targetUrl);
        }
        else {
            showAlert("请输入正确的手机号");
        }

    });
    //注册
    $("#create").on('click', function () {
        var targetUrl = "http://"+getDomainName()+contextPath+"/user/register2";
        var targetUrl2 = "http://"+getDomainName()+contextPath+"/login";
        var re = /^1\d{10}$/;
        var passwordReg=/^[a-zA-Z0-9]{6,15}$/;
        var temp1=document.getElementById("pwd1").value;
        var temp2=document.getElementById("pwd2").value;
        var phoneNumber=document.getElementById("phone").value;
        var userName = document.getElementById("name").value;
        //先判断两次输入的密码是否一致
        var code2=document.getElementById("msgid").value;
        var userNameQualified = false;
        var passwordQualified = false;
        var phoneQualified = false;
        var passwordEqual = false;
        var codeEqual=false;

	if(re.test(phoneNumber)){
                phoneQualified = true;
            }else{
                showAlert("手机号格式不正确");
            }
	    
	    
        if(code2===codemsg){
            codeEqual=true;
        }
        else{
            showAlert("验证码输入错误");
        }

            

            if(userName.length>1){
                userNameQualified = true;
            }else{
                showAlert("用户名长度不能低于2位");
            }

            if(passwordReg.test(temp1)){
                passwordQualified = true;
            }else{
                showAlert("密码必须包含字母数字和符号且不低于6位");
            }

            if(temp1===temp2) {
                passwordEqual = true;
            }else{
                showAlert("您输入的两次密码不一致");
            }

        if(userNameQualified&&passwordQualified&&phoneQualified&&passwordEqual&&codeEqual){
            //showAlert(targetUrl);
            register2(userName,phoneNumber,temp1,targetUrl,targetUrl2);
        }
    });

        function register(phone,targetUrl) {
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "phone=" + phone ,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    //发送成功后进行接下来所有的操作
                    codemsg=data;
                    showAlert("短信已发送，请正确输入验证码，有效期3分钟.");
                },
                error: function (xhr, type) {
                    showAlert("发送失败",function () {
                    })
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }

        function register2(name,phone,password,targetUrl,targetUrl2) {
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                //dataType:'JSONP',
                data: "name=" + name + "&phone=" + phone + "&password=" + password +"&openID=" +openID,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    //alert(data);
                    if(data==="phoneIsRegistered"){
                        showAlert("手机号已被注册");
                    }
                    if(data==="userNameIsRegistered"){
                        showAlert("用户名已被注册");
                    }

                    if(data==="success"){
                        showAlert("注册成功",function () {
                            goTo(targetUrl2+"?code="+code);
                        })
                    }
                    if(data==="failure"){
                        showAlert("注册失败");
                    }

                },
                error: function (xhr, type) {
                    //alert(type);
                    showAlert("注册失败",function () {
                        //goTo("http://www.hlb9978.com/user/queryOrderWaitingPay");
                    })
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
        //短信通知的button倒计时
        function buttonCountdown($el, msNum, timeFormat) {
            var text = $el.data("text") || $el.text(),
                timer = 0;
            $el.prop("disabled", true).addClass("disabled")
                .on("bc.clear", function () {
                    clearTime();
                });

            (function countdown() {
                var time = showTime(msNum)[timeFormat];
                $el.text(time + '后失效');
                if (msNum <= 0) {
                    msNum = 0;
                    clearTime();
                } else {
                    msNum -= 1000;
                    timer = setTimeout(arguments.callee, 1000);
                }
            })();

            function clearTime() {
                clearTimeout(timer);
                $el.prop("disabled", false).removeClass("disabled").text(text);
            }

            function showTime(ms) {
                var d = Math.floor(ms / 1000 / 60 / 60 / 24),
                    h = Math.floor(ms / 1000 / 60 / 60 % 24),
                    m = Math.floor(ms / 1000 / 60 % 60),
                    s = Math.floor(ms / 1000 % 60),
                    ss = Math.floor(ms / 1000);

                return {
                    d: d + "天",
                    h: h + "小时",
                    m: m + "分",
                    ss: ss + "秒",
                    "d:h:m:s": d + "天" + h + "小时" + m + "分" + s + "秒",
                    "h:m:s": h + "小时" + m + "分" + s + "秒",
                    "m:s": m + "分" + s + "秒"
                };
            }

            return this;
        }
</script>
</body>
</html>