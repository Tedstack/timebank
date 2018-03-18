<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已完成</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/utils.js"></script>
</head>
<%--<body onpageshow="back_to('${pageContext.request.contextPath}/publish/activities_category');">--%>
<%
    List<ViewActivityPublishDetailEntity> activityDetailList = (List<ViewActivityPublishDetailEntity>) request.getAttribute("activityDetailList");
%>
<div class="main-container">
    <div class="main-content">
<div class="weui-tab">
    <div class="weui-tab__panel" style="height: 100%;padding-top:0px;">
        <div class="weui-panel weui-panel_access">
            <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">已完成</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>
            <div class="weui-navbar">
                <div class="weui-navbar__item "id="navbar1">
                    报名中
                </div>
                <div class="weui-navbar__item"id="navbar4">
                    已开始
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar3">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<activityDetailList.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/activityImg/<%out.print(activityDetailList.get(i).getHeadImg());%>" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #7ACF41"><%out.print(activityDetailList.get(i).getName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">活动团队：<%out.print(activityDetailList.get(i).getTeamName());%></p>
                            <p class="weui-media-box__desc">活动开始时间：
                                <%
                                    Timestamp beginTimestamp = activityDetailList.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %>
                            </p>
                            <p class="weui-media-box__desc">活动结束时间：
                                <%
                                    Timestamp endTimestamp = activityDetailList.get(i).getEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %>
                            </p>
                            <p class="weui-media-box__desc">活动地点：<%out.print(activityDetailList.get(i).getAddress());%></p>
                        </div>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div class="weui-flex">
                            <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/team/managerGetEvaluateList?activityID=<%out.print(activityDetailList.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_primary">查看</a></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"diaplay="none"></div>
                            <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/team/managerUserGetEvaluateList?activityID=<%out.print(activityDetailList.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_primary">评价</a></div>
                        </div>
                    </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/team/teamActivities" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">所有</p>
        </a>
        <a href="${pageContext.request.contextPath}/team/alreadyApplyActivities" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">已申请的</p>
        </a>
        <a href="${pageContext.request.contextPath}/team/activitiesWaitingForApply" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">我创建的</p>
        </a>
    </div>
</div>
    </div>
    <button class="float-button" style="font-size: xx-large;" id="create">+
    </button>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/team/startPublishActivity");
    });
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/activitiesWaitingForApply";
        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/alreadyCompleteActivities";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/alreadyStartedActivities";
        });
    });
</script>
</body>
</html>
