<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动评价</title>
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
    <div class="weui-cells__title" style="color: #7ACF41;text-align:center;font-size: small;font-weight: bold">参加活动人员</div>
    <div class="weui-cells">
        <!--以下循环参加的人数-->
        <%
            for (int i=0;i<userActivityList.size();i++) {
        %>
        <div class="weui-cell" id="cell1">
            <div class="weui-cell__bd">
                <p style="font-size: 90%;margin-left: 5px;"><%out.print(userActivityList.get(i).getUserName());%></p>
            </div>
            <div class="weui-cell__ft">
                <p style="font-size: 90%">
                    <%if(userActivityList.get(i).getUserComment()!=null){
                        out.print(userActivityList.get(i).getUserComment());
                    }else
                        out.print("暂未评价");%>
                </p>
            </div>
        </div>
        <%}%>
        <!--以上-->
    </div>
</div>
</body>
</html>
