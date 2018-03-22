<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>管理活动</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
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
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <div class="weui-cells__title" style="color: #0D0D0D">活动详情</div>
    <div class="weui-cells weui-cells_form">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <textarea class="weui-textarea" rows="3" readonly="true"><%out.print(activityPublishDetail.getDescription());%></textarea>
            </div>
        </div>
    </div>
    <div style="background-color: #f8f8f8; height:10px;"></div>
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
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <div id="terminateApplyBtn" class=" weui-btn weui-btn_primary" style="padding-right: 1px;padding-left: 1px;margin-left: 10px;margin-right: 10px">结束报名</div>
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <div class="weui-cells__title" style="color: #7ACF41;text-align:center;font-size: small;font-weight: bold">已报名人员(<%out.print(userActivityList.size());%>/<%out.print(activityPublishDetail.getCount());%>)</div>
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
                <button id="<%=i%>" value="<%=userActivityList.get(i).getId()%>" class="weui-btn weui-btn_mini weui-btn_primary">移除</button>
            </div>
            <div class="weui-cell__ft" style="padding: 10px;">
                <button id="btn<%=i%>" value="<%=userActivityList.get(i).getUserId()%>" class="weui-btn weui-btn_mini weui-btn_primary">查看</button>
            </div>
        </div>
        <%}%>
        <!--以上-->
    </div>
</div>


<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });
    var userActivityList='<%=userActivityList%>';
    var activityId='<%=activityPublishDetail.getId()%>';
    var contextPath="${pageContext.request.contextPath}";

    $(function(){
        for (var i=0; i<=userActivityList.length; i++) {
            (function(i) {
                $("#"+i).on("click", function(){
                    var id = $("#"+i).attr("value");
                    var r=confirm("确认移除该成员？");
                    if(r==true){
                        post(id);
                    }
                });

                $("#btn"+i).on("click", function(){
                    var id = $("#"+i).attr("value");
                    var url = "http://"+getDomainName()+contextPath+"/team/managerUserCheckUser?userID="+id;
                    goTo(url);
                });
            })(i);
        }

        $("#terminateApplyBtn").on('click',function () {
            var userList='<%=userActivityList.size()%>';
            if(userList==='0')
                showAlert("还没有任何人报名该活动！");
            else{
                var targetUrl = "http://"+getDomainName()+contextPath+"/team/terminateApplyActivity";
                $.ajax({
                    type: 'POST',
                    cache: false,
                    url: targetUrl,
                    //dataType:'JSONP',
                    data: "activityID=" + activityId,
                    beforeSend: function (XHR) {
                        dialogLoading = showLoading();
                    },
                    success: function (data) {
                        if(data==="ok"){
                            showAlert("结束报名成功",function () {
                                goTo("http://"+getDomainName()+contextPath+"/team/activitiesWaitingForApply");
                            });
                        }else{
                            showAlert("结束报名失败");
                        }
                    },
                    error: function (xhr, type) {
                        showAlert("结束报名失败");
                    },
                    complete: function (xhr, type) {
                        dialogLoading.hide();
                    }
                });
            }
        });

        function post(userActivityID){
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/removeApplyUser";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/team/manageActivities?activityId="+activityId;
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userActivityID=" + userActivityID,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="ok"){
                        showAlert("移除成员成功",function () {
                            goTo(targetUrl2);
                        });
                    }else{
                        showAlert("移除成员失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("移除成员失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
    });
</script>

</body>
</html>
