<%@ page import="com.blockchain.timebank.entity.ActivityPublishEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动详情</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link href="../css/dj_base_838a930.css" rel="stylesheet" type="text/css">
    <link href="../css/dj_dc_content_f60f458.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../css/swiper-3.4.0.min.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    ViewActivityPublishDetailEntity activityPublishDetail = (ViewActivityPublishDetailEntity) request.getAttribute("activityPublishDetail");
    List<ViewUserActivityDetailEntity> userActivityList = (List<ViewUserActivityDetailEntity>) request.getAttribute("userActivityList");
    String isApplied=(String) request.getAttribute("isApplied");
    String type=(String) request.getAttribute("type");
%>
<!-- 使用 -->

<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="goBack()" >
                    <p><img src="../img/back.png" alt="" style="width: 6%;display: inline;">活动详情</p>
                </div>
            </div>
        </div>
        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0;">
            <a href="javascript:void(0)">
                <div class="shop-logo">
                    <img src="../img/服务类型/志愿者服务.png" alt="">
                </div>
                <div class="txt"><%out.print(activityPublishDetail.getName());%></div>
            </a>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动名称</p>
                </div>
                <div class="weui-cell__ft"><%out.print(activityPublishDetail.getName());%></div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>组织团队</p>
                </div>
                <div class="weui-cell__ft"><%out.print(activityPublishDetail.getTeamName());%></div>
            </div>

            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>开始时间</p>
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
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>结束时间</p>
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

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>报名人数</p>
                </div>
                <div class="weui-cell__ft"><%out.print(userActivityList.size());%>/<%out.print(activityPublishDetail.getCount());%></div>
            </div>

            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>申请结束时间</p>
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
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动地点</p>
                </div>
                <div class="weui-cell__ft"><%out.print(activityPublishDetail.getAddress());%></div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span>详情描述</span>
            </div>
            <div class="con_u"><%out.print(activityPublishDetail.getDescription());%></div>
        </div>
        <div style="padding: 10px; margin-bottom: 20px;">
            <%if(isApplied.equalsIgnoreCase("true") && type.equalsIgnoreCase("0")){%>
            <a class="weui-btn weui-btn_primary" style="background-color: coral;">报名成功</a>
            <%}else if(type.equalsIgnoreCase("0")){%>
            <a id="applyBtn" class="weui-btn weui-btn_primary">报名参与</a>
            <%}else{%>
            <a style="display:none;" id="applyBtn" class="weui-btn weui-btn_primary"></a>
            <%}%>
        </div>
        <%--<div class="weui-cells__title" style="color: #7ACF41;text-align:center;font-size: small;font-weight: bold">已报名人员</div>
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
        </div>--%>
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
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    var activityID='<%=activityPublishDetail.getId()%>';
    var contextPath="${pageContext.request.contextPath}";

    function goBack(){
        window.location.href="${pageContext.request.contextPath}/team/teamActivities";
    }

    $(function(){
        $("#applyBtn").on('click',function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/applyToJoinActivity";
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
                        showAlert("申请成功",function () {
                            location.reload();
                        });
                    }else if(data==="upperLimit"){
                        showAlert("活动名额已满，停止报名");
                    }else if(data==="managerError"){
                        showAlert("团队管理员不能参加自己发布的活动");
                    }else if(data==="alreadyApply"){
                        showAlert("您已申请参加此活动");
                    }else{
                        showAlert("申请失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("申请失败");
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
