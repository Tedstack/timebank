<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>服务种类</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-cell">
            <div class="weui-cell__hd">
                <img src="../img/服务名称/我的.png" alt="" style="width:20px;margin-right:5px;display:block">
            </div>
            <div class="weui-cell__bd">
                <p style="color: #7ACF41;">我的服务</p>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyPublish" class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__hd"><img src="../img/userdetails/我的发布.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
            <div class="weui-cell__bd">
                <p>已发布的服务</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyApply" class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__hd">
                <img src="../img/userdetails/我的申请.png" alt="" style="width:20px;margin-right:5px;display:block">
            </div>
            <div class="weui-cell__bd">
                <p>已申请的服务</p>
            </div>
        </a>
        <img src="../img/底部.png" width="375" height="15">

        <div class="weui-cell">
            <div class="weui-cell__hd"><img src="../img/服务名称/所有服务.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
            <div class="weui-cell__bd">
                <p style="color: #7ACF41;">我的活动</p>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/team/alreadyApplyActivities" class="weui-cell weui-cell_access" >
            <div class="weui-cell__hd"><img src="../img/userdetails/我的申请.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
            <div class="weui-cell__bd">
                <p>已申请的活动</p>
            </div>
        </a>

        <img src="../img/底部.png" width="375" height="15">

        <div style="padding: 10px; margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/publish/add" class="weui-btn weui-btn_primary">发布服务</a>
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

</body>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
    });
</script>

</html>
