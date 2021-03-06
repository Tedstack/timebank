<%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 26/12/2017
  Time: 15:19
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>提交审核</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/utils.js"></script>
</head>
<body>
<div class="weui-msg" style="padding-top: 50%">
    <div class="weui-msg__icon-area"><i class="weui-icon-success weui-icon_msg"></i></div>
    <div class="weui-msg__text-area">
        <h2 class="weui-msg__title">信息上传成功</h2>
        <p class="weui-msg__desc">专业技能信息已提交，工作人员将在1-3工作日内完成审核，审核通过后可发布服务</p>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="${pageContext.request.contextPath}/user/techInfo" class="weui-btn weui-btn_primary">返回专业信息页面</a>
        </p>
    </div>
    <div class="weui-msg__extra-area">
        <div class="weui-footer">
            <p class="weui-footer__links">
                <a href="javascript:void(0);" class="weui-footer__link"></a>
            </p>
        </div>
    </div>
</div>
</body>
</html>
