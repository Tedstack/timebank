<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ActivityPublishEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已申请的活动</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/utils.js"></script>
    <script type="text/javascript">back_to(document.referrer);</script>
</head>
<body>
<%
    List<ViewUserActivityDetailEntity> userActivityList = (List<ViewUserActivityDetailEntity>) request.getAttribute("userActivityList");
    List<ActivityPublishEntity> activityList=(List<ActivityPublishEntity>) request.getAttribute("activityList");
%>
<div class="weui-tab">
    <div class="weui-tab__panel">
    <div class="weui-panel weui-panel_access" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item weui-bar__item_on"id="navbar1">
                    已申请
                </div>
                <%--<div class="weui-navbar__item"id="navbar2">
                    待执行
                </div>--%>
                <div class="weui-navbar__item "id="navbar3">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<userActivityList.size();i++) {
                %>
                <div class="weui-panel__bd" id="<%out.print(userActivityList.get(i).getActivityId());%>" onclick="viewActivityDetail(this)">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/activityImg/<%out.print(activityList.get(i).getHeadImg());%>" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #7ACF41"><%out.print(userActivityList.get(i).getName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">活动团队：<%out.print(userActivityList.get(i).getTeamName());%></p>
                            <p class="weui-media-box__desc">活动开始时间：
                                <%
                                    Timestamp beginTimestamp = userActivityList.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %>
                            </p>
                            <p class="weui-media-box__desc">活动结束时间：
                                <%
                                    Timestamp endTimestamp = userActivityList.get(i).getEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %>
                            </p>
                            <p class="weui-media-box__desc">活动地点：<%out.print(userActivityList.get(i).getAddress());%></p>
                        </div>
                    </div>
                </div>
                <%--<div class="weui-cell">--%>
                    <%--<div class="weui-cell__bd">--%>
                        <%--<div class="weui-flex">--%>
                            <%--<div class="weui-flex__item"diaplay="none"></div>--%>
                            <%--<div class="weui-flex__item"display="none"></div>--%>
                            <%--<div class="weui-flex__item"display="none"></div>--%>
                            <%--<div class="weui-flex__item"display="none"></div>--%>
                            <%--<div class="weui-flex__item"><a class="weui-btn weui-btn_mini weui-btn_primary" href=>查看</a></div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
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
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    function viewActivityDetail(t){
        var id=t.id;
        location.href="${pageContext.request.contextPath}/team/teamActivityDetails?type=2&activityID="+id;
    }
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/alreadyApplyActivities";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/activitiesWaitingToExecute2";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/alreadyCompleteActivities2";

        });
    });
</script>

</body>
</html>