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
    <title>服务种类</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>

<div class="weui-cell">
    <div class="weui-cell__hd"><img src="../img/服务名称/所有服务.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
    <div class="weui-cell__bd">
        <p>所有服务</p>
    </div>
</div>
<a class="weui-cell weui-cell_access" href="/publish/list?type=志愿者服务">
    <div class="weui-cell__hd"><img src="../img/服务类型/志愿者服务.png" alt="" style="width:30px;margin-right:5px;display:block"></div>
    <div class="weui-cell__bd weui-cell_primary">
        <p>志愿者服务</p>
    </div>
    <span class="weui-cell__ft"></span>
</a>


                        <a class="weui-cell weui-cell_access" href="/publish/list?type=互助服务">
                            <div class="weui-cell__hd"><img src="../img/服务类型/互助服务.png" alt="" style="width:30px;margin-right:5px;display:block"></div>
                            <div class="weui-cell__bd weui-cell_primary">
                                <p>互助服务</p>
                            </div>
                            <span class="weui-cell__ft"></span>
                        </a>

                        <a class="weui-cell weui-cell_access" href="/publish/list?type=专业服务">
                            <div class="weui-cell__hd"><img src="../img/服务类型/专业服务.png" alt="" style="width:30px;margin-right:5px;display:block"></div>
                            <div class="weui-cell__bd weui-cell_primary">
                                <p>专业服务</p>
                            </div>
                            <span class="weui-cell__ft"></span>
                        </a>
                        <a class="weui-cell weui-cell_access" href="/publish/list?type=社区O2O服务">
                            <div class="weui-cell__hd"><img src="../img/服务类型/社区O2O服务.png" alt="" style="width:30px;margin-right:5px;display:block"></div>
                            <div class="weui-cell__bd weui-cell_primary">
                                <p>社区O2O服务</p>
                            </div>
                            <span class="weui-cell__ft"></span>
                        </a>

                    <img src="../img/底部.png" width="375" height="15">

<div class="weui-cell">
    <div class="weui-cell__hd"><img src="../img/服务名称/我的服务.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
    <div class="weui-cell__bd">
        <p>我的服务</p>
    </div>
</div>
<a href="/user/queryPublishAlreadyPublish" class="weui-cell weui-cell_access" href="javascript:;">
    <div class="weui-cell__hd"><img src="../img/userdetails/发布的服务.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
    <div class="weui-cell__bd">
        <p>已发布的服务</p>
    </div>
</a>
<a href="/user/queryOrderAlreadyApply" class="weui-cell weui-cell_access" href="javascript:;">
    <div class="weui-cell__hd"><img src="../img/userdetails/发布的需求.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
    <div class="weui-cell__bd">
        <p>已申请的服务</p>
    </div>
</a>
<img src="../img/底部.png" width="375" height="15">
<div class="weui-tab__panel">
<div style="...">
    <a href="/publish/add" class="weui-btn weui-btn_primary">发布服务</a>
</div>
</div>

    </div>
    <jsp:include page="bottom_tabbar.jsp"/>
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


<%--<a href="/user/logout">退出</a>--%>

