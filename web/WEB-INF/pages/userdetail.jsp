<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="javafx.scene.chart.PieChart" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>
<div class="weui-cells__title">个人信息</div>
<div class="weui-tab__panel">
    <%
        UserEntity userEntity = (UserEntity) request.getAttribute("user");
    %>
    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/headimg">
        <div class="weui-cell__bd">
            <p>头像</p>
        </div>
        <div class="weui-cell__ft"style="">
            <img src="<%out.print(userEntity.getHeadImgUrl());%>" style="width: 50px;display: block">
        </div>
    </a>

    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>姓名</p>
        </div>
        <div class="weui-cell__ft"style="">
            <%out.print(userEntity.getName());%>
        </div>
    </div>

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/startModifyPersonalInfo">
        <div class="weui-cell__bd">
            <p>二维码</p>
        </div>
        <div class="weui-cell__ft"style="">
            <img src="../img/二维码.png" style="width:20px;margin-right:5px;display:block">
        </div>
    </a>


    <a class="weui-cell weui-cell_access" href="">
        <div class="weui-cell__bd">
            <p>个性签名</p>
        </div>
        <div class="weui-cell__ft"style="">
            <%out.print(userEntity.getRemark());%>
        </div>
    </a>

    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>出生日期</p>
        </div>
        <div class="weui-cell__ft"style="">
            <%
                Date birth=userEntity.getBirth();
                if(null==birth)
                {
                    out.print("请先实名认证");
                }
                else
                {
                    out.print(birth);
                }
            %>
        </div>
    </div>

    <a class="weui-cell">
        <div class="weui-cell__bd">
            <p>性别</p>
        </div>
        <div class="weui-cell__ft"style="">
            <%
                String sex=userEntity.getSex();
                if(null==sex)
                {
                    out.print("请先实名认证");
                }
                else
                {
                    out.print(sex);
                }
            %>
        </div>
    </a>

    <a class="weui-cell">
        <div class="weui-cell__bd">
            <p>地区</p>
        </div>
        <div class="weui-cell__ft"style="">
            <%out.print(userEntity.getCountry());%>
            <%out.print(userEntity.getProvince());%>
            <%out.print(userEntity.getCity());%>
        </div>
    </a>
    <img src="../img/底部.png" width="100%" height="15">
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


</body>
</html>
