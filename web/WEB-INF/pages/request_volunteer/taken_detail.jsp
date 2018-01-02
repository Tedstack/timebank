<%@ page import="com.blockchain.timebank.entity.VolunteerRequestMatchEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="com.blockchain.timebank.entity.VolunteerRequestEntity" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 02/01/2018
  Time: 16:31
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>订单详情</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<%
    VolunteerRequestMatchEntity matchEntity = (VolunteerRequestMatchEntity) request.getAttribute("matchEntity");
    UserEntity userEntity = (UserEntity) request.getAttribute("userEntity");
    VolunteerRequestEntity requestEntity = (VolunteerRequestEntity) request.getAttribute("requestEntity");
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>订单编号</p>
        </div>
        <div class="weui-cell__ft"><%out.print(matchEntity.getId());%></div>
    </div>
</div>
<br>
<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <label class="weui-form-preview__label">需求状态</label>
        <em class="weui-form-preview__value"><%out.print(matchEntity.getStatus());%></em>
    </div>
    <div class="weui-form-preview__bd">
        <p>
            <label class="weui-form-preview__label">申请人</label>
            <span class="weui-form-preview__value"><%out.print(userEntity.getName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">开始时间</label>
            <span class="weui-form-preview__value"><%out.print(formatter.format(matchEntity.getBeginTime()));%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">结束时间</label>
            <span class="weui-form-preview__value"><%out.print(formatter.format(matchEntity.getEndTime()));%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">地理位置</label>
            <span class="weui-form-preview__value"><%out.print(requestEntity.getAddress());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">支付方式</label>
            <span class="weui-form-preview__value">志愿者时间</span>
        </p>
        <p>
            <label class="weui-form-preview__label">预计收入</label>
            <span class="weui-form-preview__value"><%out.print(requestEntity.getPrice());%></span>
        </p>
    </div>
    <div class="weui-form-preview__ft">
        <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/user/queryRequestWaitingConfirm">返回</a>
    </div>
</div>
</body>
</html>
