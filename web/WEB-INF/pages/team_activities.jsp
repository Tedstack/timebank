<%@ page import="com.blockchain.timebank.entity.ActivityPublishEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>团队活动</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body>
<%
    List<ActivityPublishEntity> apply_activityList = (List<ActivityPublishEntity>) request.getAttribute("apply_activityList");
    List<ActivityPublishEntity> process_activityList=(List<ActivityPublishEntity>) request.getAttribute("process_activityList");
    List<ActivityPublishEntity> terminate_activityList = (List<ActivityPublishEntity>) request.getAttribute("terminate_activityList");
%>
<div class="main-container">
    <div class="main-content">
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <span>团队活动</span>
                <a href="${pageContext.request.contextPath}/team/teamAvitivitySelect" style="float:right">筛选</a>
            </div>
            <div class="weui-panel__bd" id="waitingForApply">
                <%
                    for (int i=0;i<apply_activityList.size();i++) {
                %>
                <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=0&activityID=<%out.print(apply_activityList.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/activityImg/<%out.print(apply_activityList.get(i).getHeadImg());%>" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title"><%
                            out.print(apply_activityList.get(i).getName());
                            if(!apply_activityList.get(i).isPublic())
                                out.print("(私有)");
                        %>
                        </h4>
                        <h class="weui-media-box__desc">开始时间:
                            <%
                                Timestamp beginTimestamp = apply_activityList.get(i).getBeginTime();
                                Date date = new Date(beginTimestamp.getTime());
                                SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                out.print(bartDateFormat.format(date));
                            %></h>
                        <h class="weui-media-box__desc">结束时间:
                            <%
                                Timestamp endTimestamp = apply_activityList.get(i).getEndTime();
                                Date date2 = new Date(endTimestamp.getTime());
                                SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                out.print(bartDateFormat2.format(date2));
                            %></h>
                        <ul class="weui-media-box__info">
                            <li class="weui-media-box__info__meta" style="margin-bottom: 6px;">报名人数：<%out.print(apply_activityList.get(i).getCount());%></li>
                            <li class="weui-media-box__info__meta">活动地点：<%out.print(apply_activityList.get(i).getAddress());%></li>
                        </ul>
                        <ul class="weui-media-box__info">
                            <h style="color: #00DB00;font-size: 10px;">
                                <%
                                    out.print(apply_activityList.get(i).getStatus());
                                %>
                            </h>
                        </ul>
                    </div>
                </a>
                <%}%>
            </div>
            <div class="weui-panel__bd" id="alreadyInProcess">
                <%
                    for (int i=0;i<process_activityList.size();i++) {
                %>
                <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=0&activityID=<%out.print(process_activityList.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/activityImg/<%out.print(process_activityList.get(i).getHeadImg());%>" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title"><%
                            out.print(process_activityList.get(i).getName());
                            if(!process_activityList.get(i).isPublic())
                                out.print("(私有)");
                        %>
                        </h4>
                        <h class="weui-media-box__desc">开始时间:
                            <%
                                Timestamp beginTimestamp = process_activityList.get(i).getBeginTime();
                                Date date = new Date(beginTimestamp.getTime());
                                SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                out.print(bartDateFormat.format(date));
                            %></h>
                        <h class="weui-media-box__desc">结束时间:
                            <%
                                Timestamp endTimestamp = process_activityList.get(i).getEndTime();
                                Date date2 = new Date(endTimestamp.getTime());
                                SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                out.print(bartDateFormat2.format(date2));
                            %></h>
                        <ul class="weui-media-box__info">
                            <li class="weui-media-box__info__meta" style="margin-bottom: 6px;">报名人数：<%out.print(process_activityList.get(i).getCount());%></li>
                            <li class="weui-media-box__info__meta">活动地点：<%out.print(process_activityList.get(i).getAddress());%></li>
                        </ul>
                        <ul class="weui-media-box__info">
                            <h style="color: orange;font-size: 10px;,">
                                <%
                                    out.print("正在进行中");
                                %>
                            </h>
                        </ul>
                    </div>
                </a>
                <%}%>
            </div>
            <div class="weui-panel__bd" id="alreadyFinished">
                <%
                    for (int i=0;i<terminate_activityList.size();i++) {
                %>
                <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=0&activityID=<%out.print(terminate_activityList.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/activityImg/<%out.print(terminate_activityList.get(i).getHeadImg());%>" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title"><%
                            out.print(terminate_activityList.get(i).getName());
                            if(!terminate_activityList.get(i).isPublic())
                                out.print("(私有)");
                        %>
                        </h4>
                        <h class="weui-media-box__desc">开始时间:
                            <%
                                Timestamp beginTimestamp = terminate_activityList.get(i).getBeginTime();
                                Date date = new Date(beginTimestamp.getTime());
                                SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                out.print(bartDateFormat.format(date));
                            %></h>
                        <h class="weui-media-box__desc">结束时间:
                            <%
                                Timestamp endTimestamp = terminate_activityList.get(i).getEndTime();
                                Date date2 = new Date(endTimestamp.getTime());
                                SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                out.print(bartDateFormat2.format(date2));
                            %></h>
                        <ul class="weui-media-box__info">
                            <li class="weui-media-box__info__meta" style="margin-bottom: 6px;">报名人数：<%out.print(terminate_activityList.get(i).getCount());%></li>
                            <li class="weui-media-box__info__meta">活动地点：<%out.print(terminate_activityList.get(i).getAddress());%></li>
                        </ul>
                        <ul class="weui-media-box__info">
                            <h style="color: #6C6C6C;font-size: 10px;">
                                <%
                                    out.print("已结束");
                                %>
                            </h>
                        </ul>
                    </div>
                </a>
                <%}%>
            </div>
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/team/teamActivities" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">所有</p>
        </a>
        <a href="${pageContext.request.contextPath}/team/alreadyApplyActivities" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">已申请的</p>
        </a>
        <a href="${pageContext.request.contextPath}/team/activitiesWaitingForApply" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我创建的</p>
        </a>
    </div>
</div>
    </div>
    <button class="float-button" style="font-size: xx-large;" id="create">+
    </button>
</div>
</body>
<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/team/startPublishActivity?timestamp="+(new Date()).valueOf());
    });
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(0)').addClass("weui-bar__item_on");
    });
</script>
</html>
