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
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/utils.js"></script>
    <style>
        .float-button {
            position: fixed; //关键
        padding: 10px 10px;
            height: 60px;
            width: 60px;
            bottom: 60px;
            left:47%;
            line-height: 100%;
            align-content: center;
            background: #b4d145;
            border-radius: 50%;
            text-align: center;
            margin-left: -20px;
            padding: 10px 10px;
        }
    </style>
</head>
<body onpageshow="normal_back();">
<%
    List<ViewUserActivityDetailEntity> userActivityList_applied = (List<ViewUserActivityDetailEntity>) request.getAttribute("userActivityList_applied");
    List<ViewUserActivityDetailEntity> userActivityList_finished = (List<ViewUserActivityDetailEntity>) request.getAttribute("userActivityList_finished");
%>
<div class="main-container">
    <div class="main-content">
<div class="weui-tab">
    <div class="weui-tab__panel">
    <div class="weui-panel weui-panel_access" style="height: 100%;">
        <div class="weui-navbar">
            <div class="weui-navbar__item weui-bar__item_on"id="navbar1">
                已申请
            </div>
            <div class="weui-navbar__item "id="navbar3">
                已完成
            </div>
        </div>
        <div class="weui-tab" style="margin-top: 50px;">
            <!--已申请的活动-->
            <div class="weui-tab__panel" id="applied">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<userActivityList_applied.size();i++) {
                %>
                <div class="weui-panel__bd" id="<%out.print(userActivityList_applied.get(i).getActivityId());%>" onclick="viewActivityDetail(this)">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/activityImg/<%out.print(userActivityList_applied.get(i).getActivityHeadImg());%>" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #7ACF41"><%out.print(userActivityList_applied.get(i).getName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">活动团队：<%out.print(userActivityList_applied.get(i).getTeamName());%></p>
                            <p class="weui-media-box__desc">活动开始时间：
                                <%
                                    Timestamp beginTimestamp = userActivityList_applied.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %>
                            </p>
                            <p class="weui-media-box__desc">活动结束时间：
                                <%
                                    Timestamp endTimestamp = userActivityList_applied.get(i).getEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %>
                            </p>
                            <p class="weui-media-box__desc">活动地点：<%out.print(userActivityList_applied.get(i).getAddress());%></p>
                        </div>
                    </div>
                </div>

                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <div class="weui-tab__panel" id="finished" style="display: none;">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<userActivityList_finished.size();i++) {
                %>
                <div class="page__bd" id="<%out.print(userActivityList_finished.get(i).getActivityId());%>" onclick="goToActivityDetail(this)">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动状态</label>
                                <em class="weui-form-preview__value">已结束</em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动名称</label>
                                <span class="weui-form-preview__value"><%out.print(userActivityList_finished.get(i).getName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动团队</label>
                                <span class="weui-form-preview__value">
                                    <%out.print(userActivityList_finished.get(i).getTeamName());%>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动地点</label>
                                <span class="weui-form-preview__value"><%out.print(userActivityList_finished.get(i).getAddress());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动开始时间</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        Timestamp beginTimestamp = userActivityList_finished.get(i).getBeginTime();
                                        Date date = new Date(beginTimestamp.getTime());
                                        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                        out.print(bartDateFormat.format(date));
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动结束时间</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        Timestamp endTimestamp = userActivityList_finished.get(i).getEndTime();
                                        Date date2 = new Date(endTimestamp.getTime());
                                        SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                        out.print(bartDateFormat2.format(date2));
                                    %>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item">
                                    <%
                                        if(userActivityList_finished.get(i).getUserComment()==null)
                                            out.print("<a href='"+ request.getContextPath() +"/record/pingjia_activities?num=0&activityId="+userActivityList_finished.get(i).getActivityId()+"' class='weui-btn weui-btn_mini weui-btn_primary'>评价</a>");
                                        else
                                            out.print("<a href='"+ request.getContextPath() +"/record/pingjia_activities?num=1&activityId="+userActivityList_finished.get(i).getActivityId()+"'class='weui-btn weui-btn_mini weui-btn_primary'  style='background-color: coral'>再评价</a>");
                                    %>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div style="background-color: #f8f8f8; height:10px;"></div>
                </div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
        </div>
    </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/team/teamActivities" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">所有</p>
        </a>
        <a href="${pageContext.request.contextPath}/team/alreadyApplyActivities" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">已申请的</p>
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
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/team/startPublishActivity");
    });
    function viewActivityDetail(t){
        var id=t.id;
        location.href="${pageContext.request.contextPath}/team/teamActivityDetails?type=2&activityID="+id;
    }
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            document.getElementById("applied").style.display="inline";
            document.getElementById("finished").style.display="none";
        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            document.getElementById("applied").style.display="none";
            document.getElementById("finished").style.display="inline";
        });
    });
</script>
</html>