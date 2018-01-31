<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2018/1/22
  Time: 13:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>修改密码</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    UserEntity user = (UserEntity) request.getAttribute("user");
%>
<div class="weui-cells weui-cells_form">
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">新密码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" placeholder="请输入新密码" type="password" id="newpwd1">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">确认密码</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" placeholder="请输入新密码" type="password" id="newpwd2">
        </div>
    </div>
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
    <div class="weui-btn-area">
        <button class="weui-btn weui-btn_primary" id="update">发布</button>
    </div>
</div>
</body>
<script>
    var contextPath="${pageContext.request.contextPath}";
    var targetUrl3="http://" + getDomainName() + contextPath +"/user/logout";
    var realPhone = <%=user.getPhone()%>
    var codemsg;
    $("#msgbtn").on('click', function () {
        var targetUrl = "http://" + getDomainName() + contextPath + "/user/register";//复用了register的发送短信代码
        var phoneNumber = document.getElementById("phone").value;
        var re = /^1\d{10}$/
        if(re.test(phoneNumber))
        {
            buttonCountdown($(this), 1000 * 60 * 3, "ss");
            change(phoneNumber, targetUrl);
        }
        else {
            showAlert("请输入正确的手机号");
        }
    });
    $("#update").on('click', function () {
        var targetUrl = "http://"+getDomainName()+contextPath+"/user/password_change";
       var pwd1=document.getElementById("newpwd1").value;
       var pwd2=document.getElementById("newpwd2").value;
       var code=document.getElementById("msgid").value;
       var pwdequal=false;
       var codeequal=false;
       var pwdright=false;
        var passwordReg=/^[a-zA-Z0-9]{6,15}$/;
        if(passwordReg.test(pwd1)){
            pwdright = true;
        }else{
            showAlert("密码必须只包含字母或数字且不低于6位");
        }
      if(pwd1===pwd2)
      {
          pwdequal=true;
      }
      else{
          showAlert("两次输入的密码不一致");
      }
      if(code===codemsg)
      {
          codeequal=true;
      }
      else{
          showAlert("验证码输入错误")
      }
        if(passwordReg.test(pwd1)){
            pwdright = true;
        }else{
            showAlert("密码必须包含字母数字和符号且不低于6位");
        }
      if(pwdequal&&codeequal&&pwdright)
      {
          update(realPhone,pwd1,targetUrl);
      }
      else{
          showAlert("请重新输入");
      }
    });
    function change(phone,targetUrl) {
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
    function update(phone,password,targetUrl){
        $.ajax({
            type: 'POST',
            cache: false,
            url: targetUrl,
            //dataType:'JSONP',
            data: "phone=" + phone + "&password=" + password ,
            beforeSend: function (XHR) {
                dialogLoading = showLoading();
            },
            success: function (data) {
                //alert(data);
                if(data==="success"){
                    showAlert("修改成功,请重新登录",function(){
                        goTo(targetUrl3);
                    });
                }
                if(data==="fail"){
                    showAlert("修改失败！");
                }
                else{
                    showAlert("test");
                }
            },
            error: function (xhr, type) {
                //alert(type);
                showAlert("修改失败",function () {
                    //goTo("http://www.hlb9978.com/user/queryOrderWaitingPay");
                })
            },
            complete: function (xhr, type) {
                dialogLoading.hide();
            }
        });
    }
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
</html>
