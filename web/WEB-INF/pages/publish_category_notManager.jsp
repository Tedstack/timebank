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
    <title>服务</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body onload="back_exit();">
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
        <div style="background-color: #f8f8f8; height:10px;"></div>
        <div style="padding: 10px; margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/publish/add" class="weui-btn weui-btn_primary">发布服务</a>
        </div>
        <div style="background-color: #f8f8f8; height:10px;"></div>

        <div class="weui-cell">
            <div class="weui-cell__hd">
                <img src="../img/服务名称/我的.png" alt="" style="width:20px;margin-right:5px;display:block">
            </div>
            <div class="weui-cell__bd">
                <p style="color: #7ACF41;">我的需求</p>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/request/published?tab=1" class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__hd"><img src="../img/userdetails/我的发布.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
            <div class="weui-cell__bd">
                <p>已发布的需求</p>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/request/applied?tab=1" class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__hd">
                <img src="../img/userdetails/我的申请.png" alt="" style="width:20px;margin-right:5px;display:block">
            </div>
            <div class="weui-cell__bd">
                <p>已申请的需求</p>
            </div>
        </a>
        <div style="background-color: #f8f8f8; height:10px;"></div>

        <div style="padding: 10px; margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/request/add" class="weui-btn weui-btn_primary">发布需求</a>
        </div>

    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px">活动</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px">我</p>
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
