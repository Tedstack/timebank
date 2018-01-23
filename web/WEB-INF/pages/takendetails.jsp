<%@ page import="com.blockchain.timebank.entity.PublishOrderEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="com.blockchain.timebank.entity.PublishEntity" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.weixin.util.FormatOrderIdUtil" %>
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
    PublishOrderEntity publishOrderEntity = (PublishOrderEntity) request.getAttribute("publishOrderEntity");
    UserEntity userEntity = (UserEntity) request.getAttribute("userEntity");
    PublishEntity publishEntity = (PublishEntity) request.getAttribute("publishEntity");
%>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>订单编号</p>
        </div>
        <div class="weui-cell__ft"><%FormatOrderIdUtil.getPublishOrderFormatId(publishOrderEntity);%></div>
    </div>
</div>
<br>
<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <label class="weui-form-preview__label">服务状态</label>
        <em class="weui-form-preview__value"><%out.print(publishOrderEntity.getStatus());%></em>
    </div>
    <div class="weui-form-preview__bd">
        <p>
            <label class="weui-form-preview__label">申请人</label>
            <span class="weui-form-preview__value"><%out.print(userEntity.getName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">开始时间</label>
            <span class="weui-form-preview__value">
                <%
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    out.print(df.format(publishOrderEntity.getBeginTime()));
                %>
            </span>
        </p>
        <p>
            <label class="weui-form-preview__label">结束时间</label>
            <span class="weui-form-preview__value">
                <%
                    out.print(df.format(publishOrderEntity.getEndTime()));
                %>
            </span>
        </p>
        <p>
            <label class="weui-form-preview__label">地理位置</label>
            <span class="weui-form-preview__value"><%out.print(publishOrderEntity.getApplyAddress());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">支付方式</label>
            <span class="weui-form-preview__value">
                <%
                    if(publishOrderEntity.getPayWay() == 1)
                        out.print("志愿者时间");
                    else if(publishOrderEntity.getPayWay() == 2)
                        out.print("时间币");
                    else
                        out.print("元");
                %>
            </span>
        </p>
        <p>
            <label class="weui-form-preview__label">预计收入</label>
            <span class="weui-form-preview__value"><%out.print(publishEntity.getPrice());%></span>
        </p>
    </div>
    <div class="weui-form-preview__ft">
        <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/user/queryPublishWaitingConfirm">返回</a>
    </div>
</div>
</body>
</html>