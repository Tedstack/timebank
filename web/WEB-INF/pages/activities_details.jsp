<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
</head>
<body>
<%
    ViewActivityPublishDetailEntity activity = (ViewActivityPublishDetailEntity) request.getAttribute("activity");
%>
<!-- 使用 -->

<div class="weui-tab">
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0;">
            <a href="javascript:void(0)">
                <div class="shop-logo">
                    <img src="../img/服务类型/志愿者服务.png" alt="">
                </div>
                <div class="txt"><%out.print(activity.getName());%></div>
                <%--<div class="tags-rz">
                    <span class="tag-sm">志愿者活动</span>
                </div>--%>
            </a>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动名称</p>
                </div>
                <div class="weui-cell__ft"><%out.print(activity.getName());%></div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>组织团队</p>
                </div>
                <div class="weui-cell__ft"><%out.print(activity.getTeamName());%></div>
            </div>

            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>开始时间</p>
                </div>
                <div class="weui-cell__ft">
                    <%
                        Timestamp beginTimestamp = activity.getBeginTime();
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
                        Timestamp endTimestamp = activity.getEndTime();
                        Date date2 = new Date(endTimestamp.getTime());
                        SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                        out.print(bartDateFormat2.format(date2));
                    %>
                </div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>申请结束时间</p>
                </div>
                <div class="weui-cell__ft">
                    <%
                        Timestamp applyEndTimestamp = activity.getApplyEndTime();
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
                <div class="weui-cell__ft"><%out.print(activity.getAddress());%></div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span>详情描述</span>
            </div>
            <div class="con_u"><%out.print(activity.getDescription());%></div>
        </div>



        <div style="padding: 10px; margin-bottom: 20px;">
            <a href=" " class="weui-btn weui-btn_primary">申请参与</a>
        </div>

    </div>

    <div class="weui-tabbar">
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

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>
