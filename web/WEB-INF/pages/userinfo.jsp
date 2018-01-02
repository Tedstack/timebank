<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %><%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>
<div class="weui-tab__panel">
    <%
        UserEntity userEntity = (UserEntity) request.getAttribute("user");
    %>
    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/userdetail">
        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
            <img src="<%out.print(userEntity.getHeadImgUrl());%>" style="width: 50px;display: block">
        </div>
        <div class="weui-cell__bd">
            <p><%out.print(userEntity.getName());%></p>
            <p style="font-size: 13px;color: #888888;">我的二维码:<%out.print(userEntity.getQrCode());%></p>
        </div>
        <div class="weui-cell__ft">
            <img src="../img/二维码.png" style="width:20px;margin-right:5px;display:block">
        </div>
    </a>
    <img src="../img/底部.png" width="100%" height="15">

    <a class="weui-cell weui-cell_access" href="javascript:;">
        <div class="weui-cell__hd"><img src="../img/userdetails/消息.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>新消息通知</p>
        </div>
    </a>
    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/team/teamList">
        <div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>所有团体</p>
        </div>
        <div class="weui-cell__ft"style="">选择</div>
    </a>
    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/team/myTeams">
        <div class="weui-cell__hd"><img src="../img/我的团体.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>我的团体</p>
        </div>
        <div class="weui-cell__ft"style="">查看</div>
    </a>

    <img src="../img/底部.png" width="100%" height="15">

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/recharge/coins_balance">
        <div class="weui-cell__hd"><img src="../img/userdetails/时间币.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>时间币</p>
        </div>
        <div class="weui-cell__ft"style="color: #7ACF41"><%out.print(userEntity.getTimeCoin());%> 时间币</div>
    </a>

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/volunteer_coin">
        <div class="weui-cell__hd"><img src="../img/userdetails/志愿者.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>志愿者时间</p>
        </div>
        <div class="weui-cell__ft"style="color: #7ACF41"><%out.print(userEntity.getTimeVol());%> 志愿者时间</div>
    </a>
    <img src="../img/底部.png" width="100%" height="15">

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/<%
        if(userEntity.getIsVerify() != null && userEntity.getIsVerify() == 1){
            out.print("realnameInfo");
        }
        else{
            out.print("startRealNameAuth");
        }
        %>">
        <div class="weui-cell__hd"><img src="../img/userdetails/实名认证.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p style="display: block">实名认证</p>
        </div>
        <div class="weui-cell__ft">
            <%
                if(userEntity.getIsVerify() != null && userEntity.getIsVerify() == 1){
                    out.println("<p style=\"color:#1AAD19;\">✓已认证</p>");
                }
                else{
                    out.println("<p>未认证</p>");
                }
            %>
        </div>
    </a>

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/techInfo">
        <div class="weui-cell__hd"><img src="../img/userdetails/专业服务认证.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p style="display: block">专业服务技能认证</p>
        </div>
        <div class="weui-cell__ft">
            <c:choose>
                <c:when test="${techNum==0}">
                    <p>未认证</p>
                </c:when>
                <c:otherwise>
                    <p style="color:#1AAD19">✓已认证${techNum}项</p>
                </c:otherwise>
            </c:choose>
        </div>
    </a>
    <img src="../img/底部.png" width="100%" height="15">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <div class="weui-flex">
                <div class="weui-flex__item" display="none"></div>
                <div class="weui-flex__item" display="none"></div>
                <div class="weui-flex__item" display="none"></div>
                <div class="weui-flex__item" display="none"></div>
                <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/user/logout" class="weui-btn weui-btn_mini weui-btn_primary">退出</a></div>
            </div>
        </div>
    </div>

    </div>

<div class="weui-tabbar" style="height: 50px">
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


<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(2)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>