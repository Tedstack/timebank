<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/22
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>管理活动</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link href="../css/mobile-main.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    ViewActivityPublishDetailEntity activityPublishDetail = (ViewActivityPublishDetailEntity) request.getAttribute("activityPublishDetail");
    List<ViewUserActivityDetailEntity> userActivityList = (List<ViewUserActivityDetailEntity>) request.getAttribute("userActivityList");
%>
<div class="weui-tab__panel">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p style="font-size: large">活动名称：<%out.print(activityPublishDetail.getName());%></p>
        </div>
        <div class="weui-cell__ft" style="color: #0D0D0D">发起团队：<%out.print(activityPublishDetail.getTeamName());%></div>
    </div>
    <img src="../img/底部.png" width="375" height="10">
    <div class="weui-cells__title" style="color: #0D0D0D">活动详情</div>
    <div class="weui-cells weui-cells_form">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <textarea class="weui-textarea" rows="3" readonly="true"><%out.print(activityPublishDetail.getDescription());%></textarea>
            </div>
        </div>
    </div>
    <img src="../img/底部.png" width="375" height="10">
    <div class="weui-cell " href="javascript:;">
        <div class="weui-cell__bd">
            <p>活动开始时间</p>
        </div>
        <div class="weui-cell__ft">
            <%
                Timestamp beginTimestamp = activityPublishDetail.getBeginTime();
                Date date = new Date(beginTimestamp.getTime());
                SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                out.print(bartDateFormat.format(date));
            %>
        </div>
    </div>
    <div class="weui-cell " href="javascript:;">
        <div class="weui-cell__bd">
            <p>活动结束时间</p>
        </div>
        <div class="weui-cell__ft">
            <%
                Timestamp endTimestamp = activityPublishDetail.getEndTime();
                Date date2 = new Date(endTimestamp.getTime());
                SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                out.print(bartDateFormat2.format(date2));
            %>
        </div>
    </div>
    <div class="weui-cell " href="javascript:;">
        <div class="weui-cell__bd">
            <p>报名截止时间</p>
        </div>
        <div class="weui-cell__ft">
            <%
                Timestamp applyEndTimestamp = activityPublishDetail.getApplyEndTime();
                Date date3 = new Date(applyEndTimestamp.getTime());
                SimpleDateFormat bartDateFormat3 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                out.print(bartDateFormat3.format(date3));
            %>
        </div>
    </div>
    <img src="../img/底部.png" width="375" height="10">
    <div id="terminateActivityBtn" class=" weui-btn weui-btn_primary" style="padding-right: 1px;padding-left: 1px;margin-left: 10px;margin-right: 10px">结束活动</div>
    <img src="../img/底部.png" width="375" height="10">
    <div class="weui-cells__title" style="color: #7ACF41;text-align:center;font-size: small;font-weight: bold">实际参与人员</div>
    <div class="weui-cells">
        <!--以下循环参加的人数-->
        <%
            for (int i=0;i<userActivityList.size();i++) {
        %>
        <div class="weui-cell" id="cell1">
            <div class="weui-cell__bd">
                <p style="font-size: 90%"><%out.print(userActivityList.get(i).getUserName());%></p>
            </div>
        </div>
        <%}%>
        <!--以上-->
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

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var activityID='<%=activityPublishDetail.getId()%>';
    var contextPath="${pageContext.request.contextPath}";

    var wConfirm = window.confirm;
    window.confirm = function (message) {
        try {
            var iframe = document.createElement("IFRAME");
            iframe.style.display = "none";
            iframe.setAttribute("src", 'data:text/plain,');
            document.documentElement.appendChild(iframe);
            var alertFrame = window.frames[0];
            var iwindow = alertFrame.window;
            if (iwindow == undefined) {
                iwindow = alertFrame.contentWindow;
            }
            var result=iwindow.confirm(message);
            iframe.parentNode.removeChild(iframe);
            return result;
        }
        catch (exc) {
            return wConfirm(message);
        }
    }

    $(function(){
        var check = document.getElementsByName("checkbox1");

        $("#terminateActivityBtn").on('click', function () {
            var r=confirm("确认结束活动");
            if(r==false){
                return;
            }

            var targetUrl = "http://"+getDomainName()+contextPath+"/team/terminateActivity";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/team/alreadyStartedActivities";

            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                //dataType:'JSONP',
                data: "activityID=" + activityID,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="ok"){
                        showAlert("结束成功",function () {
                            goTo(targetUrl2);
                        });
                    }else if(data==="ok_vol"){
                        showAlert("结束成功，已计算对应时间",function () {
                            goTo(targetUrl2);
                        });
                    }
                    else{
                        showAlert("操作失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("操作失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });
    });
</script>

</body>
</html>
