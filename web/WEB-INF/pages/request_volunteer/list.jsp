<%@ page import="com.blockchain.timebank.entity.ViewVolunteerRequestDetailEntity" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 29/12/2017
  Time: 13:36
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <title>需求列表</title>
</head>
<body>
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access" style="margin-bottom: 50px">
            <div class="weui-panel__hd">
                <span>志愿者需求</span>
                <a href="javascript:;" onclick="window.location.href='${pageContext.request.contextPath}/request/select?type=volunteer'" style="float:right">筛选</a>
            </div>
            <div class="weui-panel__bd">

                <%
                    List<ViewVolunteerRequestDetailEntity> list = (List<ViewVolunteerRequestDetailEntity>) request.getAttribute("list");
                    for (ViewVolunteerRequestDetailEntity viewVolunteerRequestDetailEntity : list) {
                %>

                <a href="<%out.print("detail_volunteer?id="+viewVolunteerRequestDetailEntity.getId());%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="<%out.print(viewVolunteerRequestDetailEntity.getHeadImgUrl());%>">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title" style="display:inline-block">
                            <img style="height:20.5px; vertical-align: text-bottom" src="../img/服务名称/<%out.print(viewVolunteerRequestDetailEntity.getServiceName());%>.png" />
                            <%out.print(viewVolunteerRequestDetailEntity.getServiceName());%>
                        </h4>
                        <p class="weui-media-box__desc">
                            <span style="color: #7ACF41;">¥
                                <%
                                    out.print(viewVolunteerRequestDetailEntity.getPrice()+"志愿者币");
                                %>
                            </span>
                            <br/>
                            <%out.print(viewVolunteerRequestDetailEntity.getUserName());%> &nbsp;&nbsp;&nbsp;
                            <%out.print(viewVolunteerRequestDetailEntity.getAddress());%>
                        </p>
                    </div>
                </a>
                <%}%>
            </div>
        </div>
    </div>
    <div class="weui-tabbar" style="height:50px">
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
</html>
