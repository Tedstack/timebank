<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %><%--
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
    <title>服务申请</title>
    <link rel="stylesheet" href="http://res.wx.qq.com/open/libs/weui/1.1.2/weui.min.css"/>
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <%
            ViewPublishDetailEntity detailEntity = (ViewPublishDetailEntity) request.getAttribute("detail");
        %>

        <div class="page">
            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p><%out.print(request.getAttribute("name"));%></p>
                    </div>
                    <div class="weui-cell__ft"><%out.print(request.getAttribute("phone"));%></div>
                </div>
            </div>
            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__hd">
                    <label for="" class="weui-label">服务地址选择</label>
                </div>
                <div class="weui-cell__bd">
                    <select class="weui-select" name="select2">
                        <option value="1">华东师范大学地理馆</option>
                        <option value="2">华东师范大学数学馆</option>
                        <option value="3">华东师范大学理科楼</option>
                    </select>
                </div>
            </div>
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="javascript:;">
                    <div class="weui-cell__bd">
                        <p>添加新的服务地址</p>
                    </div>
                    <div class="weui-cell__ft">
                    </div>
                </a>
            </div>
            <div class="weui-cells__title"></div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="" class="weui-label">开始时间</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="beginTime" type="datetime-local" value="" placeholder=""/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><label for="" class="weui-label">结束时间</label></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="endTime" type="datetime-local" value="" placeholder=""/>
                </div>
            </div>
            <div class="weui-cells">
                <a class="weui-cell weui-cell_access" href="javascript:;">
                    <div class="weui-cell__bd">
                        <p>支付方式</p>
                    </div>
                    <div class="weui-cell__ft">时间币支付</div>
                </a>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd"><img src="../img/志愿者服务.png" alt=""
                                                style="width:20px;margin-right:5px;display:block"></div>
                <div class="weui-cell__bd">
                    <p><%out.print(detailEntity.getServiceName());%>服务</p>
                </div>
                <div class="weui-cell__ft"><%out.print(detailEntity.getServiceType());%></div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>陪聊服务单价</p>
                </div>
                <div class="weui-cell__ft"><%out.print(detailEntity.getPrice());%>&nbsp;时间币/h</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>实付</p>
                </div>
                <div class="weui-cell__ft">时间币</div>
            </div>
            <a href="javascript:;" class="weui-btn weui-btn_plain-primary">提交订单</a>
            <!--actionsheet测试-->

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
