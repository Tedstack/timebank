<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>首页</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>

<div class="weui-tab">
    <div class="weui-tab__panel">

        <%
            double timeCoin=(double)request.getAttribute("timeCoin");

        %>

        <input id="time" value="<%=timeCoin%>" style="display: none">

        <p id=""><%=timeCoin%></p>
        <p><%out.print(timeCoin);%></p>
        <button id="btn_chongzhi"></button>

    </div>
    <jsp:include page="bottom_tabbar.jsp"/>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        var url_prefix="${pageContext.request.contextPath}";

        $('.weui-tabbar:eq(0)').find('a:eq(0)').addClass("weui-bar__item_on");

        $("#btn_chongzhi").click(function(){
            $.ajax({
                url: url_prefix+"/recharge/pay",
                context: $("#time").val(),
                success: function(){
                    $(this).addClass("done");
                }
            });
        });

    });
</script>

</body>
</html>
