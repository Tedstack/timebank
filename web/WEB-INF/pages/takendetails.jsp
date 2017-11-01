<%@ page import="com.blockchain.timebank.entity.RecordEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="com.blockchain.timebank.entity.PublishEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>WeUI</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<%
    RecordEntity recordEntity = (RecordEntity) request.getAttribute("recordEntity");
    UserEntity userEntity = (UserEntity) request.getAttribute("userEntity");
    PublishEntity publishEntity = (PublishEntity) request.getAttribute("publishEntity");
%>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>订单编号</p>
        </div>
        <div class="weui-cell__ft"><%out.print(recordEntity.getId());%></div>
    </div>
</div>
<br>
<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <label class="weui-form-preview__label">服务状态</label>
        <em class="weui-form-preview__value"><%out.print(recordEntity.getStatus());%></em>
    </div>
    <div class="weui-form-preview__bd">
        <p>
            <label class="weui-form-preview__label">申请人</label>
            <span class="weui-form-preview__value"><%out.print(userEntity.getName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">开始时间</label>
            <span class="weui-form-preview__value"><%out.print(recordEntity.getBeginTime());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">结束时间</label>
            <span class="weui-form-preview__value"><%out.print(recordEntity.getEndTime());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">地理位置</label>
            <span class="weui-form-preview__value"><%out.print(recordEntity.getApplyAddress());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">支付方式</label>
            <span class="weui-form-preview__value"><%out.print(recordEntity.getPayWay());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">预计收入</label>
            <span class="weui-form-preview__value">C <%out.print(publishEntity.getPrice());%></span>
        </p>
    </div>
    <div class="weui-form-preview__ft">
        <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="/user/queryPublishWaitingConfirm">返回</a>
    </div>
</div>
</body>
</html>