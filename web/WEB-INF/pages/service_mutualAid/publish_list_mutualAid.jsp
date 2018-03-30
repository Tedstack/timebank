<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: caozihan
  Date: 2017/12/20
  Time: 13:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="${pageContext.request.contextPath}/js/utils.js"></script>
    <script src="${pageContext.request.contextPath}/js/scan/function.js"></script>
    <script src="${pageContext.request.contextPath}/js/scan/configs.js"></script>
    <title>服务柜台</title>
    <style>
        .overtimeFlag{
            float:right;
            font-size:16px;
            color:#848c99;
            margin-top: 28px;
        }
    </style>
</head>
<body>
<div class="main-container">
    <div class="main-content">
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">

            <%--<div class="weui-cells">
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务类型</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceType" id="serviceType">
                            <option value="志愿者服务">志愿者服务</option>
                            <option value="互助服务" selected="selected">互助服务</option>
                            <option value="专业服务">专业服务</option>
                        </select>
                    </div>
                </div>
            </div>--%>
            <div class="weui-navbar" style="position:fixed;">
                <div class="weui-navbar__item"id="navbar1">
                    志愿者服务
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar2">
                    互助服务
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    专业服务
                </div>
            </div>

            <div class="weui-panel__hd">
                <span><%out.print(request.getAttribute("type"));%></span>
                <a href="${pageContext.request.contextPath}/publish/select?type=<%out.print(request.getAttribute("type"));%>" style="float:right">筛选</a>
            </div>
            <div class="weui-panel__bd">

                <%
                    List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>) request.getAttribute("list");
                    for (int i = 0; i < list.size(); i++) {
                        ViewPublishDetailEntity viewPublishEntity = list.get(i);
                %>

                <a href="<%out.print("detail?id="+viewPublishEntity.getId()+"&type=mutualAid");%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="<%out.print(viewPublishEntity.getHeadImgUrl());%>">
                    </div>
                    <div class="weui-media-box__bd">
                        <img class="weui-media-box__thumb" style="width:25px; margin-top: 5px" src="../img/服务名称/<%out.print(viewPublishEntity.getServiceName());%>.png" />
                        <h4 class="weui-media-box__title" style="display:inline-block"><%out.print(viewPublishEntity.getServiceName());%></h4>
                        <%
                            Date currentDate = new Date();
                            SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
                            String currentTime = sdf.format(currentDate);
                            if(viewPublishEntity.getEndDate().getTime() < new Date(currentTime).getTime()){
                                out.print("<span class='overtimeFlag'>已过期</span>");
                            }
                        %>
                        <div style="color: #7ACF41;">
                            <%
                                out.print(viewPublishEntity.getPrice()+"时间币/小时");
                            %></div>
                        <div><p class="weui-media-box__desc">
                            <%out.print(viewPublishEntity.getUserName());%> &nbsp;&nbsp;&nbsp;
                            <%out.print(viewPublishEntity.getAddress());%>
                        </p></div>
                    </div>
                </a>
                <%}%>
            </div>
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/publish/list?type=志愿者服务" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">服务柜台</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyApply" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">预约的服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyPublish" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">发布的服务</p>
        </a>
    </div>
</div>
    </div>
    <button class="float-button" style="font-size: xx-large;" id="create">+
    </button>
</div>
</body>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/publish/add");
    });
    var contextPath="${pageContext.request.contextPath}";
    /*$(document).ready(function () {
        $("#serviceType").change(function () {
            var type = $(this).val();
            if(type === "志愿者服务"){
                var targetUrl = "http://"+getDomainName()+contextPath+"/publish/list?type=志愿者服务";
                goTo(targetUrl);
            } else if(type === "互助服务"){
                var targetUrl = "http://"+getDomainName()+contextPath+"/publish/list?type=互助服务";
                goTo(targetUrl);
            } else if(type === "专业服务"){
                var targetUrl = "http://"+getDomainName()+contextPath+"/publish/list?type=专业服务";
                goTo(targetUrl);
            }
        });
    });*/
    $(function(){
        $("#navbar1").on('click', function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/publish/list?type=志愿者服务";
            goTo(targetUrl);
        });
        $("#navbar2").on('click', function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/publish/list?type=互助服务";
            goTo(targetUrl);

        });
        $("#navbar3").on('click', function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/publish/list?type=专业服务";
            goTo(targetUrl);
        });

    });
</script>
</html>
