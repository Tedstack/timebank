<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待评价成员</title>
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
    List<ViewUserActivityDetailEntity> userActivityList = (List<ViewUserActivityDetailEntity>) request.getAttribute("userActivityList");
%>
<div class="weui-tab__panel">
    <div class="weui-cells__title" style="color: #7ACF41;text-align:center;font-size: small;font-weight: bold">个人信息</div>
    <div class="weui-cells">
        <div class="block block_tcxq mt10">
            <div class="title">
                <span>历史评价</span>
            </div>
            <%
                if(userActivityList.size()>0){
                    for (int i=0;i<userActivityList.size();i++) {
            %>
            <div class="con_u">服务评分:<%out.print(userActivityList.get(i).getManagerRating());%></div>
            <div class="con_u"><%out.print(userActivityList.get(i).getManagerComment());%></div>
            <div style="background-color: #f8f8f8; height:10px;"></div>
            <%
                }
             }else{%>
            <div class="con_u">该用户暂未参加任何活动</div>
            <%}%>
        </div>
    </div>
</div>
</body>
</html>
