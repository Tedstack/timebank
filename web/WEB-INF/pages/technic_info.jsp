<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.blockchain.timebank.entity.TechnicAuthEntity" %>
<%@ page import="java.util.List" %><%--
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
            <%
                int i = 1, j = 1;
                if(request.getAttribute("authsInfo") != null && ((List<TechnicAuthEntity>)request.getAttribute("authsInfo")).size()==0){
                    out.println("<div class=\"weui-msg\"><div class=\"weui-msg__text-area\"><p class=\"weui-msg__desc\">暂时还没有认证专业技能，点击下方按钮快去认证吧\n</p></div></div>");
                }
            %>
            <c:forEach var="authEntity" items="${authsInfo}">
                <c:if test="${authEntity.verified}">
                    <div class="weui-cells__title">
                        <p>已认证专业技能<%out.print(i++);%></p>
                    </div>
                    <div class="weui-cells">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>技能名称</p>
                            </div>
                            <div class="weui-cell__ft">
                                <p>${authEntity.techName}</p>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>证书等级</p>
                            </div>
                            <div class="weui-cell__ft">
                                <p>${authEntity.techLevel}</p>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>证书编号</p>
                            </div>
                            <div class="weui-cell__ft">
                                <p>${authEntity.techId}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <c:forEach var="authEntity" items="${authsInfo}">
                <c:if test="${!authEntity.verified}">
                    <div class="weui-cells__title">
                        <p>待审核专业技能<%out.print(j++);%></p>
                    </div>
                    <div class="weui-cells">
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>技能名称</p>
                            </div>
                            <div class="weui-cell__ft">
                                <p>${authEntity.techName}</p>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>证书等级</p>
                            </div>
                            <div class="weui-cell__ft">
                                <p>${authEntity.techLevel}</p>
                            </div>
                        </div>
                        <div class="weui-cell">
                            <div class="weui-cell__bd">
                                <p>证书编号</p>
                            </div>
                            <div class="weui-cell__ft">
                                <p>${authEntity.techId}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

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