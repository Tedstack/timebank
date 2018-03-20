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
<div class="weui-tab__panel" style="color: #7ACF41;">
    <div class="weui-panel__hd">
        <div class="weui-flex__item" id="return" onclick="goBack()" >
            <p> 参加活动人员</p>
        </div>
    </div>
    <div class="weui-cells">
        <!--以下循环参加的人数-->
        <%
            for (int i=0;i<userActivityList.size();i++) {
        %>
        <div class="weui-cell" id="cell1">
            <div class="weui-cell__bd">
                <p style="font-size: 90%"><%out.print(userActivityList.get(i).getUserName());%></p>
            </div>
            <div class="weui-cell__ft">
                <%
                    if(userActivityList.get(i).getManagerRating()==null){
                        out.print("<a href='"+ request.getContextPath() +"/team/managerUserStartEvaluateUser?type=0&userActivityID="+ userActivityList.get(i).getId()+"' class='weui-btn weui-btn_mini weui-btn_primary'>评价</a>");
                    }else{
                        out.print("<a href='"+ request.getContextPath() +"/team/managerUserStartEvaluateUser?type=1&userActivityID="+ userActivityList.get(i).getId()+"' class='weui-btn weui-btn_mini weui-btn_default'>再评</a>");
                    }
                %>
            </div>
        </div>
        <%}%>
        <!--以上-->
    </div>
</div>
<script type="text/javascript">
    function goBack() {
        window.location.href="${pageContext.request.contextPath}/team/alreadyCompleteActivities";
    }
</script>
</body>
</html>
