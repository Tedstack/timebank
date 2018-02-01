<%--
  Created by IntelliJ IDEA.
  User: Oscar
  Date: 2017/11/14
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>发布结果</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
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
                if(msg.equals("ok")){
                    out.print("发布成功");
                }else{
                    out.print("您还未建立任何团队，暂不能发布活动");
                }
            %>
        </h2>
    </div>
    <div class="weui-msg__opr-area">
        <p class="weui-btn-area">
            <a href="${pageContext.request.contextPath}/index" class="weui-btn weui-btn_primary">返回首页</a>
        </p>
    </div>
</div>

</body>
</html>
