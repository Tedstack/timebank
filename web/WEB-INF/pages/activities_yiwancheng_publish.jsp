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
</head>
<body>
<%
    List<ViewActivityPublishDetailEntity> activityDetailList = (List<ViewActivityPublishDetailEntity>) request.getAttribute("activityDetailList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">已完成</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>
            <div class="weui-navbar">
                <div class="weui-navbar__item "id="navbar1">
                    待申请
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待执行
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
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动状态</label>
                                <em class="weui-form-preview__value"><%out.print(activityDetailList.get(i).getStatus());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动名称</label>
                                <span class="weui-form-preview__value"><%out.print(activityDetailList.get(i).getName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动团队</label>
                                <span class="weui-form-preview__value">
                                    <%out.print(activityDetailList.get(i).getTeamName());%>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动地点</label>
                                <span class="weui-form-preview__value">
                                    <%out.print(activityDetailList.get(i).getAddress());%>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">活动开始时间</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        Timestamp beginTimestamp = activityDetailList.get(i).getBeginTime();
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
                                        Timestamp endTimestamp = activityDetailList.get(i).getEndTime();
                                        Date date2 = new Date(endTimestamp.getTime());
                                        SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                        out.print(bartDateFormat2.format(date2));
                                    %>
                                </span>
                            </div>
                            <div class="weui-panel__ft">
                                <a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>
                            </div>
                        </div>

                    </div>
                    <img src="../img/底部.png" width="375" height="15">
                </div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
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
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/activitiesWaitingForApply";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/team/activitiesWaitingToExecute";

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
