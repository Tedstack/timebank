<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2018/1/2
  Time: 15:58
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="javax.xml.crypto.Data" %>
<%@ page import="javafx.scene.chart.PieChart" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>头像</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>
    <%
        UserEntity userEntity = (UserEntity) request.getAttribute("user");
    %>
<div class="weui-cells__title">我的头像</div>
    <div>
        <img src="<%out.print(userEntity.getHeadImgUrl());%>"  width="100%" style="display: block">
    </div>
<body>
