<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动详情</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
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
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <div class="weui-cells__title" style="color: #7ACF41;text-align:center;font-size: small;font-weight: bold">请勾选实际参加人员</div>
    <div class="weui-cells weui-cells_checkbox">

        <%
            for (int i=0;i<userActivityList.size();i++) {
        %>
        <label class="weui-cell weui-check__label" for=<%out.print(userActivityList.get(i).getId());%>>
            <div class="weui-cell__hd">
                <input type="checkbox" class="weui-check" name="checkbox1" value=<%out.print(userActivityList.get(i).getUserName());%> id=<%out.print(userActivityList.get(i).getId());%>>
                <i class="weui-icon-checked"></i>
            </div>
            <div class="weui-cell__bd" style="font-size: small;font-weight: normal">
                <%out.print(userActivityList.get(i).getUserName());%>
            </div>
        </label>
        <%}%>

    </div>
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <div id="startActivityBtn" class=" weui-btn weui-btn_primary" style="padding-right: 1px;padding-left: 1px;margin-left: 10px;margin-right: 10px">开始活动</div>
</div>

<%--<div class="weui-tabbar" style="height: 50px">--%>
    <%--<a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">--%>
        <%--<img src="../img/首页.png" alt="" class="weui-tabbar__icon">--%>
        <%--<p class="weui-tabbar__label">首页</p>--%>
    <%--</a>--%>
    <%--<a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">--%>
        <%--<img src="../img/服务.png" alt="" class="weui-tabbar__icon">--%>
        <%--<p class="weui-tabbar__label">服务</p>--%>
    <%--</a>--%>
    <%--<a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">--%>
        <%--<img src="../img/活动.png" alt="" class="weui-tabbar__icon">--%>
        <%--<p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">活动</p>--%>
    <%--</a>--%>
    <%--<a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">--%>
        <%--<img src="../img/我的.png" alt="" class="weui-tabbar__icon">--%>
        <%--<p class="weui-tabbar__label">我</p>--%>
    <%--</a>--%>
<%--</div>--%>

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
    var contextPath="${pageContext.request.contextPath}";

    $(function(){
        var check = document.getElementsByName("checkbox1");

        $("#startActivityBtn").on('click', function () {

            var targetUrl = "http://"+getDomainName()+contextPath+"/team/startActivity";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/team/alreadyStartedActivities";
            var obj = document.getElementsByName("checkbox1");
            var check_val = [];
            for(var k in obj){
                if(obj[k].checked){
                    check_val.push(obj[k].id);
                }
            }

            if(check_val.length!==0){
                $.ajax({
                    type: 'POST',
                    cache: false,
                    url: targetUrl,
                    dataType:'json',
                    traditional:true,
                    data: {"userActivityIDList":check_val},
                    beforeSend: function (XHR) {
                        dialogLoading = showLoading();
                    },
                    success: function (data) {
                        var value = JSON.stringify(data);
                        var dataJson = JSON.parse(value);

                        if(dataJson.msg==="ok"){
                            showAlert("活动已开始",function () {
                                goTo(targetUrl2);
                            });
                        }
                    },
                    error: function (xhr, type) {
                        showAlert("操作失败");
                    },
                    complete: function (xhr, type) {
                        dialogLoading.hide();
                    }
                });
            }else{
                showAlert("请选择参加人员");
            }
        });
    });
</script>

</body>
</html>
