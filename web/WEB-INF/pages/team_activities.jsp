<%@ page import="com.blockchain.timebank.entity.ActivityPublishEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/7
  Time: 18:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>团队活动</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    List<ActivityPublishEntity> activityList = (List<ActivityPublishEntity>) request.getAttribute("activityList");
%>

<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">团队活动</div>
            <div class="weui-panel__bd">

                <%
                    for (int i=0;i<activityList.size();i++) {
                %>
                <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=0&activityID=<%out.print(activityList.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
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
                            <li class="weui-media-box__info__meta">报名人数：<%out.print(activityList.get(i).getCount());%></li>
                            <li class="weui-media-box__info__meta">活动地点<%out.print(activityList.get(i).getAddress());%></li>
                        </ul>
                    </div>
                </a>
                <%}%>

            </div>


        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">活动</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(2)').addClass("weui-bar__item_on");
    });
</script>
<script src="../js/utils.js"></script>
<script type="text/javascript">
    back_to("${pageContext.request.contextPath}/index");
</script>
</body>
</html>
