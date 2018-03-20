<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: weiyi
  Date: 2018/03/06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>团队公告</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%

%>
<div class="page">
    <div class="weui-panel__hd">
        <div class="weui-flex__item" id="return" onclick="goBack()" >
            <p> 团队公告</p>
        </div>
    </div>

</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    function goBack() {
        window.location.href="${pageContext.request.contextPath}/team/teamList";
    }
</script>
</html>
