<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/1/9
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>请先实名认真</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>

<div class="weui-msg">
    <div class="weui-msg__icon-area">
        <%
            String msg=(String)request.getAttribute("msg");
            if(msg.equals("ok")){
                out.print("<i class='weui-icon-success weui-icon_msg'></i>");
            }else{
                out.print("<i class='weui-icon-warn weui-icon_msg'></i>");
            }
        %>
    </div>
    <div class="weui-msg__text-area">
        <h2 class="weui-msg__title">
            <%
                if(msg.equals("notVerify")){
                    out.print("申请服务前，请实名认证");
                }
                if(msg.equals("failVerify")){
                    out.print("实名认证未通过，无法申请服务");
                }
            %>
        </h2>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="${pageContext.request.contextPath}/user/startRealNameAuth" class="weui-btn weui-btn_primary">前往实名认证</a>
        </p>
    </div>
</div>

</body>
</html>

