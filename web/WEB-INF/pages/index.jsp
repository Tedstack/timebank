<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>首页</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="http://res.wx.qq.com/open/libs/weui/1.1.2/weui.min.css"/>

    <link rel="">
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <div class="weui-grids">
            <a href="javascript:;" class="weui-grid">
                <div class="weui-grid__icon">
                    <img src="../img/志愿者服务.png" alt="">
                </div>
                <p class="weui-grid__label">
                    志愿者服务
                </p>
            </a>
            <a href="javascript:;" class="weui-grid">
                <div class="weui-grid__icon">
                    <img src="../img/专业服务.png" alt="">
                </div>
                <p class="weui-grid__label">
                    专业服务
                </p>
            </a>

        </div>

    </div>
    <jsp:include page="tabbar.jsp"/>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(0)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>


<%--<a href="/user/logout">退出</a>--%>

