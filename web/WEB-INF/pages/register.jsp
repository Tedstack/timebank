<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>注册验证</title>
    <!-- 引入 WeUI -->
    <link href="../css/weui.min.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
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
            <input class="weui-input" type="text" id="name" placeholder="姓名"/>
        </div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <input class="weui-input" type="text" id="pwd1" placeholder="密码"/>
        </div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <input class="weui-input" type="text" id="pwd2" placeholder="确认密码"/>
        </div>
    </div>
</div>
<div style="...">
    <a href="javascript:;" class="weui-btn weui-btn_primary" id="create">创建</a>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
        $("#create").on('click', function () {
            var re = /^1\d{10}$/
            var passwordReg=/^[a-zA-Z0-9]{6,10}$/;
            var temp1=document.getElementById("pwd1").value;
            var temp2=document.getElementById("pwd2").value;
            var phoneNumber=document.getElementById("phone").value;
            //先判断两次输入的密码是否一致
            if(temp1==temp2)
            {
                if (re.test(phoneNumber)) {
                    if(passwordReg.test(temp1))
                    {
                        showAlert("注册信息全部正确");
                    }
                    else
                    {
                        showAlert("密码必须包含字母数字和符号且不低于6位");
                    }
                } else {
                    showAlert("手机号格式不正确");
                }
            }
            else
            {
                showAlert("您输入的两次密码不一致！");
            }
        });
</script>
</body>
</html>