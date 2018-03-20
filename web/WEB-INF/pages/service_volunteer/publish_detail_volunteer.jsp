<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishOrderDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: caozihan
  Date: 2017/12/20
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link href="../css/dj_base_838a930.css" rel="stylesheet" type="text/css">
    <link href="../css/dj_dc_content_f60f458.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../css/swiper-3.4.0.min.css">
    <script src="../js/utils.js"></script>
    <title>服务详情</title>
</head>
<body>

<%
    ViewPublishDetailEntity detail = (ViewPublishDetailEntity) request.getAttribute("detail");
    UserEntity currentUser = (UserEntity) request.getAttribute("currentUser");
%>

<div class="weui-tab">
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0; padding-left: 15px">
            <div align="center">
                <img class="weui-media-box__thumb" style="width:25%" src="../img/服务名称/<%=detail.getServiceName()%>.png">
                <h2><%=detail.getServiceName()%></h2>
                <p><%=detail.getDescription()%></p>
            </div>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <span style="color:#76b852">服务详情</span>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:32px; display:inline" src="../img/littleicon/定位.png">
                    <span><%=detail.getAddress()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:32px; display:inline" src="../img/littleicon/时间.png">
                    <span>

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Timestamp timestampBegin = detail.getBeginDate();
                            Date dateBegin = new Date(timestampBegin.getTime());
                            Timestamp timestampEnd = detail.getEndDate();
                            Date dateEnd = new Date(timestampEnd.getTime());
                            out.print(bartDateFormat.format(dateBegin) + " 至 " + bartDateFormat.format(dateEnd));
                        %>

                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd"></div>
                <div class="weui-cell__ft">
                    <a id="serviceApply-button" class="weui-btn weui-btn_primary" href="${pageContext.request.contextPath}/record/apply?id=<%=detail.getId()%>" style="color:#fff; border:0px;display: none;text-decoration:none;">
                        <%=detail.getPrice()%>志愿者时间/小时 申请服务
                    </a>
                    <a id="serviceOverDate-button" class="weui-btn weui-btn_plain-default" style="background-color: #999; color:#fff; border:0px;display: none;text-decoration:none;" onclick="return false;">
                        服务已过期，不可申请
                    </a>
                </div>
            </div>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <a style="color:#76b852" href="${pageContext.request.contextPath}/publish/evaluation_service?userId=<%=detail.getUserId()%>">查看历史评价</a>
                </div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span style="color:#76b852">申请须知</span>
            </div>
            <div class="con_u">
                <p>申请前请看清时间范围及服务区域<br/><br/>提交申请后不可取消，等待提供服务者确认接受后即可服务<br/><br/>若有任何变动请及时与服务者联系</p>
            </div>
        </div>

    </div>

    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/publish/list?type=志愿者服务" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">服务柜台</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyApply" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">我预约的服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/request/published?tab=1" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">我发布的需求</p>
        </a>
    </div>
</div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script language="javascript">
    $(document).ready(function () {
        var detailEndDate = "<%out.print(detail.getEndDate().toString().substring(0,10));%>";
        detailEndDate =detailEndDate.replace(/\-/gi,"/");
        var detailEndTime = new Date(detailEndDate).getTime();
        var nowDate = new Date(new Date().Format("yyyy/MM/dd"))
        var nowTime = nowDate.getTime();
        if(detailEndTime < nowTime){
            $("#serviceApply-button").hide();
            $("#serviceOverDate-button").show();
        } else{
            $("#serviceApply-button").show();
            $("#serviceOverDate-button").hide();
        }
        var currentUserId = "";
        if(<%out.print(currentUser != null);%>) {
            currentUserId = <%out.print(currentUser.getId());%>;
        }
        var publishUserId = <%out.print(detail.getUserId());%>;
        if(currentUserId != "" && currentUserId == publishUserId){
            $("#serviceApply-button").hide();
            $("#serviceOverDate-button").show();
            $("#serviceOverDate-button").html("不可申请自己的服务");
        }
    });
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
</body>
</html>
