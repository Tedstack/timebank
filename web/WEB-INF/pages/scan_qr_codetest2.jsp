<%@ page import="com.blockchain.timebank.entity.RecordEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>扫描二维码</title>
</head>
<body>
<%
    String status = (String) request.getAttribute("status");
%>
"status:"<%out.print(status);%>
<a href="/user/queryPublishWaitingService" class="weui-btn weui-btn_plain-default">返回</a>


</body>
</html>