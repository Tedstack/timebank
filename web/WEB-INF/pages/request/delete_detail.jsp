<%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 12/01/2018
  Time: 16:11
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>删除结果</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>

<div class="weui-msg">
    <div class="weui-msg__icon-area">
        <%
            String msg=(String)request.getAttribute("deleteMsg");
            if(msg.equals("删除成功")){
                out.print("<i class='weui-icon-success weui-icon_msg'></i>");
            }
            if(msg.equals("无法删除") || msg.equals("请拒绝所有申请后删除")){
                out.print("<i class='weui-icon-warn weui-icon_msg'></i>");
            }
        %>
    </div>
    <div class="weui-msg__text-area">
        <label class="weui-msg__title" id="status"><%out.print(msg);%></label>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="${pageContext.request.contextPath}/request/published?tab=1" class="weui-btn weui-btn_primary">返回我的已发布</a>
        </p>
    </div>
</div>
</body>
</html>