<%@ page import="com.blockchain.timebank.entity.RecordEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>扫描二维码</title>
</head>
<body>
<%
    long recordID = (long) request.getAttribute("recordID");
%>
"recordID:"<%out.print(recordID);%>
<form action="${pageContext.request.contextPath}/user/serviceUserCompleteScan" method="post">
    二维码: <input type="text" name="qrcode">
    <br />

    recordID:<input type="text" name="recordID" />

    <input type="submit" value="提交" />
</form>

</body>
</html>