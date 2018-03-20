<%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 09/01/2018
  Time: 15:07
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>修改结果</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>

<div class="weui-msg">
    <div class="weui-msg__icon-area">
        <%
            String msg=(String)request.getAttribute("msg");
            if(msg.equals("ok")){
                out.print("<i class='weui-icon-success weui-icon_msg'></i>");
            }else{
                out.print("<i class='weui-icon-warn weui-icon_msg'></i>");
            }
        %>
    </div>
    <div class="weui-msg__text-area">
        <h2 class="weui-msg__title">
            <%
                if(msg.equals("notVerify")){
                    out.print("发布需求前，请实名认证");
                }
                if(msg.equals("failVerify")){
                    out.print("实名认证未通过，无法发布需求");
                }
                if(msg.equals("applierNotVerify")){
                    out.print("申请需求前，请实名认证");
                }
                if(msg.equals("applierFailVerify")){
                    out.print("实名认证未通过，无法申请需求");
                }
                if(msg.equals("applierNotTechVerify")){
                    out.print("申请专业需求前，请认证专业技能");
                }
            %>
        </h2>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <%if(msg.equals("applierNotTechVerify")){%>
            <a href="${pageContext.request.contextPath}/user/techInfo" class="weui-btn weui-btn_primary">前往专业技能认证</a>
            <%}else{%>
            <a href="${pageContext.request.contextPath}/user/startRealNameAuth" class="weui-btn weui-btn_primary">前往实名认证</a>
            <%}%>
        </p>
    </div>
</div>

</body>
</html>

