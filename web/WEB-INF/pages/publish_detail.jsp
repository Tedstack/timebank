<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %><%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>服务详情</title>
    <link rel="stylesheet" href="../css/weui.css"/>
    <link rel="stylesheet" href="../css/weui-example.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css" >
    <link href="../css/dj_base_838a930.css" rel="stylesheet" type="text/css">
    <link href="../css/dj_dc_content_f60f458.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../css/swiper-3.4.0.min.css">
</head>
<body>
<!-- 使用 -->

<%
    ViewPublishDetailEntity detail = (ViewPublishDetailEntity) request.getAttribute("detail");
%>
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="swiper_box sp_con">
            <div class="oneimg" style="background-image: url('../img/陪聊服务示例图.jpg')">
            </div>
        </div>
        <div class="topinfo border_b">
            <div class="tags tags_normal">
                <span><%out.print(detail.getServiceName());%>服务</span>
            </div>
        </div>
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0;">
            <a href="javascript:void(0)">
                <div class="shop-logo">
                    <img src="../img/暂时使用商家.png" alt="">
                </div>
                <div class="txt"><%out.print(detail.getUserName());%></div>
                <div class="tags-rz">
                    <span class="tag-sm">实名认证</span>
                </div>
                <i class="more"></i>
            </a>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span>服务详情</span>
            </div>
            <div class="con_u"><%out.print(detail.getDescription());%></div>
        </div>

        <div style="padding: 10px;">
            <a href="<%out.print("/order/apply?id="+detail.getId());%>" class="weui-btn weui-btn_primary">开始预约</a>
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
