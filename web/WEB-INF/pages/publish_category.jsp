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
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="http://res.wx.qq.com/open/libs/weui/1.1.2/weui.min.css"/>
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <div class="weui-panel">
            <div class="weui-panel__hd">上海市 </div>
            <div class="weui-panel__bd">
                <div class="weui-media-box weui-media-box_small-appmsg">
                    <div class="weui-cells">
                        <a class="weui-cell weui-cell_access" href="/publish/list?type=互助服务">
                            <div class="weui-cell__hd"><img src="../img/服务类型/互助服务.png" alt="" style="width:30px;margin-right:5px;display:block"></div>
                            <div class="weui-cell__bd weui-cell_primary">
                                <p>互助服务</p>
                            </div>
                            <span class="weui-cell__ft"></span>
                        </a>
                        <a class="weui-cell weui-cell_access" href="/publish/list?type=志愿者服务">
                            <div class="weui-cell__hd"><img src="../img/服务类型/志愿者服务.png" alt="" style="width:30px;margin-right:5px;display:block"></div>
                            <div class="weui-cell__bd weui-cell_primary">
                                <p>志愿者服务</p>
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
                    </div>
                </div>
            </div>
        </div>

        <div style="padding: 10px;">
            <a href="/publish/add" class="weui-btn weui-btn_primary">发布服务</a>
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

