<%@ page import="com.blockchain.timebank.weixin.util.Configs" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>自动跳转</title>
    <script src="${pageContext.request.contextPath}/js/scan/function.js"></script>
</head>
<body>
    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
        var targetUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=<%out.print(Configs.APPID);%>&redirect_uri=http%3A%2F%2F<%out.print(Configs.DOMAINNAME);%>%2Ftimebanktest%2Flogin&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
        $(document).ready(function () {
            goTo(targetUrl);
        });
    </script>
</body>
</html>
