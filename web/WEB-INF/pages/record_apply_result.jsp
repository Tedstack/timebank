<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>申请结果</title>
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
        <h2 class="weui-msg__title">预约成功</h2>
        <p class="weui-msg__desc">等待服务提供者确认<a href="/user/queryOrder">查看我的订单</a></p>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="/index" class="weui-btn weui-btn_primary">返回首页</a>
        </p>
    </div>
</div>

</body>
</html>
