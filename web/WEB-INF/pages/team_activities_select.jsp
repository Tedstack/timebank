<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.ActivityStatus" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>搜素结果</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/utils.js"></script>
</head>
<%
    List<ViewActivityPublishDetailEntity> activityList = (List<ViewActivityPublishDetailEntity>) request.getAttribute("activityList");
%>
<div class="main-container">
    <div class="main-content">
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <span>活动搜索</span>
            </div>
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
                            <li class="weui-media-box__info__meta" style="margin-bottom: 6px;">报名人数：<%out.print(activityList.get(i).getCount());%></li>
                            <li class="weui-media-box__info__meta">活动地点：<%out.print(activityList.get(i).getAddress());%></li>
                        </ul>
                        <ul class="weui-media-box__info">
                            <p style="color: orange;">
                                <%
                                    String status=activityList.get(i).getStatus();
                                    Timestamp applyTime = activityList.get(i).getApplyEndTime();
                                    Timestamp nowTime=new Timestamp(System.currentTimeMillis());
                                    if(status.equalsIgnoreCase(ActivityStatus.waitingForApply) && applyTime.after(nowTime))
                                        out.print("可报名");
                                    else if(status.equalsIgnoreCase(ActivityStatus.waitingForExecute) || status.equalsIgnoreCase(ActivityStatus.alreadyStart))
                                        out.print("进行中");
                                    else
                                        out.print("已结束");
                                %>
                            </p>
                        </ul>
                    </div>
                </a>
                <%}%>

            </div>


        </div>
    </div>
</div>
    </div>
</div>
</body>
<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/team/startPublishActivity");
    });
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(0)').addClass("weui-bar__item_on");
    });
</script>
</html>
