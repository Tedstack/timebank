<%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 26/12/2017
  Time: 15:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>专业认证信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>
<div class="container">
    <div class="page input js_show">
        <div class="page__bd">
            <div class="weui-cells__title">
                <p>已认证专业技能1</p>
            </div>
            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>技能名称</p>
                    </div>
                    <div class="weui-cell__ft">
                        <p>计算机</p>
                    </div>
                </div><div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>证书类型</p>
                </div>
                <div class="weui-cell__ft">
                    <p>国家认证</p>
                </div>
            </div><div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>证书编号</p>
                </div>
                <div class="weui-cell__ft">
                    <p>xxxxxxxx</p>
                </div>
            </div>
            </div>
            <div class="weui-cells__title">
                <p>已认证专业技能2</p>
            </div>
            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>技能名称</p>
                    </div>
                    <div class="weui-cell__ft">
                        <p>水电工</p>
                    </div>
                </div><div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>证书类型</p>
                </div>
                <div class="weui-cell__ft">
                    <p>国家认证</p>
                </div>
            </div><div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>证书编号</p>
                </div>
                <div class="weui-cell__ft">
                    <p>xxxxxxxx</p>
                </div>
            </div>
            </div>
            <div class="weui-btn-area">
                <a href="${pageContext.request.contextPath}/user/startTechAuth" class="weui-btn weui-btn_primary">添加专业技能</a>
            </div>
            <div class="weui-btn-area">
                <a href="${pageContext.request.contextPath}/user/" class="weui-btn weui-btn_default">返回我的页面</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>