<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: weiyi
  Date: 2017/12/24
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>历史活动</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    List<ActivityPublishEntity> activityList=(List<ActivityPublishEntity>) request.getAttribute("activityList");
%>
<div class="page">
    <div class="weui-panel__hd">
        <div class="weui-flex__item" id="return" onclick="goBack()" >
            <p><img src="../img/back.png" width="20" height="15"alt="">团队历史活动</p>
        </div>
    </div>
    <%
        for(int i=0;i<activityList.size();i++){
    %>
    <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=1&activityID=<%out.print(activityList.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
        <div class="weui-media-box__hd">
            <img class="weui-media-box__thumb" src="../img/activityImg/<%out.print(activityList.get(i).getHeadImg());%>" alt="">
        </div>
        <div class="weui-media-box__bd">
            <h4 class="weui-media-box__title"><%out.print(activityList.get(i).getName());%></h4>
            <p class="weui-media-box__desc">开始时间:
                <%
                    Timestamp beginTimestamp = activityList.get(i).getBeginTime();
                    Date date = new Date(beginTimestamp.getTime());
                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    out.print(bartDateFormat.format(date));
                %></p>
            <p class="weui-media-box__desc">结束时间:
                <%
                    Timestamp endTimestamp = activityList.get(i).getEndTime();
                    Date date2 = new Date(endTimestamp.getTime());
                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    out.print(bartDateFormat2.format(date2));
                %></p>
            <ul class="weui-media-box__info">
                <li class="weui-media-box__info__meta" style="margin-bottom: 2px;"><%out.print(activityList.get(i).getCount());%>人</li>
                <li class="weui-media-box__info__meta"><%out.print(activityList.get(i).getAddress());%></li>
            </ul>
        </div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <%}%>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    function goBack() {
        window.location.href="${pageContext.request.contextPath}/team/teamList";
    }
</script>
</html>
