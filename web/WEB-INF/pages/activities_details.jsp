<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/7
  Time: 20:03
  To change this template use File | Settings | File Templates.
--%>
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
<!-- 使用 -->

<div class="weui-tab">
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0;">
            <a href="javascript:void(0)">
                <div class="shop-logo">
                    <img src="../img/服务名称/代购.png" alt="">
                </div>
                <div class="txt">团体活动1</div>
                <div class="tags-rz">
                    <span class="tag-sm">志愿者活动</span>
                </div>
            </a>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动名称</p>
                </div>
                <div class="weui-cell__ft">XXX</div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>开始日期</p>
                </div>
                <div class="weui-cell__ft">...</div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>结束日期</p>
                </div>
                <div class="weui-cell__ft">
                    ...
                </div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动回报</p>
                </div>
                <div class="weui-cell__ft">x时间币</div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>活动地点</p>
                </div>
                <div class="weui-cell__ft">...</div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span>详情描述</span>
            </div>
            <div class="con_u">由...发起的面向...的活动</div>
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
