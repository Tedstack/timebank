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
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <input class="weui-input" type="text" id="phone" placeholder="手机号"/>
        </div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <input class="weui-input" type="text" id="name" placeholder="用户名"/>
        </div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <input class="weui-input" type="password" id="pwd1" placeholder="密码"/>
        </div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <input class="weui-input" type="password" id="pwd2" placeholder="确认密码"/>
        </div>
    </div>
</div>
<div style="...">
    <a href="javascript:;" class="weui-btn weui-btn_primary" id="create">创建</a>
</div>
<script src="js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
        var openID='<%=openID%>';
        var code='<%=code%>';
        var contextPath="${pageContext.request.contextPath}";

        $("#create").on('click', function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/user/register";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/login";
            var re = /^1\d{10}$/
            var passwordReg=/^[a-zA-Z0-9]{6,10}$/;
            var temp1=document.getElementById("pwd1").value;
            var temp2=document.getElementById("pwd2").value;
            var phoneNumber=document.getElementById("phone").value;
            var userName = document.getElementById("name").value;
            //先判断两次输入的密码是否一致

            var userNameQualified = false;
            var passwordQualified = false;
            var phoneQualified = false;
            var passwordEqual = false;

            if(re.test(phoneNumber)){
                phoneQualified = true;
            }else{
                showAlert("手机号格式不正确");
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

            if(userNameQualified&&passwordQualified&&phoneQualified&&passwordEqual){
                //showAlert(targetUrl);
                register(userName,phoneNumber,temp1,targetUrl,targetUrl2);
            }

            /*if(temp1==temp2) {
                if (re.test(phoneNumber)) {
                    if(passwordReg.test(temp1)) {
                        //showAlert("注册信息全部正确");
                        register(document.getElementById("name").value,phoneNumber,temp1);
                    } else {
                        showAlert("密码必须包含字母数字和符号且不低于6位");
                    }
                } else {
                    showAlert("手机号格式不正确");
                }
            } else {
                showAlert("您输入的两次密码不一致！");
            }*/
        });
        
        function register(name,phone,password,targetUrl,targetUrl2) {
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
        
</script>
</body>
</html>