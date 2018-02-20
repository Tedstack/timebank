<%@ page import="com.blockchain.timebank.entity.ActivityPublishEntity" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2017/12/21
  Time: 15:20
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
    <link rel="stylesheet" href="../css/jquery.range.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
    <style>
        .slider-container{
            margin-top: 30px;
        }
        table{
            width: 100%;
            margin:auto;
        }
        td{
            width:25%;
        }
        .select-button {
            display: inline-block;
            width: 85%;
            margin:auto;
            height: 30px;
            margin-top: 20px;
            border: 1px solid #515151;
            border-radius: 8px;
            text-align: center;
            padding-top: 2px;
            background-color:#ffffff ;
            color: #515151;
        }
        .active{
            background-color:#76b852 ;
            color: #ffffff;
        }
    </style>
    <title>筛选活动</title>
</head>
<body>

<%

%>

<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel__hd">
            <span>筛选</span>
        </div>
        <%--<form action="${pageContext.request.contextPath}/publish/list_select" method="post" onsubmit="return check();">--%>
            <div class="weui-panel__bd">
                <div class="weui-media-box weui-media-box_text">
                    <div style="margin-left: 15px">
                        <span style="color:#76b852;margin-right: 10px;">活动名称</span>
                        <input id='select-activityName' class="weui-input" style="height: 50px;line-height: 34px;display: inline-block;width:40%;" placeholder="活动名称">
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text">
                    <div style="margin-left: 15px">
                        <span style="color:#76b852">活动时间</span>
                        <div style="margin: 10px;margin-bottom: 30px">
                            <input id='select-begintime' class="weui-input" type="date" style="height: 50px;line-height: 34px;display: inline-block;width:40%;float: left" placeholder="开始时间">
                            <span style="margin:0 auto; vertical-align:middle">--</span>
                            <input id='select-endtime' class="weui-input" type="date" style="height: 50px;line-height: 34px;display: inline-block;width:40%;float: right" placeholder="结束时间">
                        </div>
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text" style="padding-bottom: 25px">
                    <div style="margin-left: 15px; margin-top: 20px;margin-bottom: 30px; float:right">
                        <a class="weui-btn weui-btn_mini weui-btn_default" href="${pageContext.request.contextPath}/team/teamActivities">取消</a>
                        <a class="weui-btn weui-btn_mini weui-btn_primary" id="select-confirm" >完成</a>
                    </div>
                </div>
            </div>
        <%--</form>--%>
        <div class="weui-tabbar" style="height: 50px">
            <a href="${pageContext.request.contextPath}/team/teamActivities" class="weui-tabbar__item">
                <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">所有</p>
            </a>
            <a href="${pageContext.request.contextPath}/team/alreadyApplyActivities" class="weui-tabbar__item">
                <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label">已申请的</p>
            </a>
            <a href="${pageContext.request.contextPath}/team/activitiesWaitingForApply" class="weui-tabbar__item">
                <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label">我创建的</p>
            </a>
        </div>
    </div>
</div>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/range/jquery.range.js"></script>
    <script>
        $('.range-slider').jRange({
            from: 0,
            to: 200,
            step: 1,
            scale: [0,50,100,150,200],
            format: '%s',
            width: 300,
            showLabels: true,
            isRange : true //theme:'theme-blue'
        });
        $('.select-button').click(function(){
            $(this).toggleClass('active');
        });
        $('#select-confirm').click(function(){
            var activityName=$('#select-activityName').val();
            var beginTime=$('#select-begintime').val();
            var endTime=$('#select-endtime').val();
            if(beginTime==="")
                beginTime="2000-01-01";
            if(endTime==="")
                endTime="2100-01-01";
            location.href="${pageContext.request.contextPath}/team/activitySearch?activityName="+ activityName +"&beginTime="+ beginTime + "&endTime=" + endTime;
        });
    </script>
</body>
</html>
