<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/23
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加服务</title>
    <link rel="stylesheet" href="../css/weui.css"/>
    <link rel="stylesheet" href="../css/weui-example.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css" >
</head>
<body>

<form action="/service/add/submit" method="post">
    <div>
        <input type="text" name="type" placeholder="服务类型" value="专业服务">
    </div>

    <div>
        <input type="text" name="name" placeholder="服务名称" value="陪聊">
    </div>

    <div>
        <input type="text" name="price" placeholder="价格" value="30">
    </div>

    <div>
        <input type="date" name="updateTime" placeholder="更新时间" value="2017/10/23">
    </div>

    <div>
        <button type="submit">提交</button>
    </div>

</form>


</body>
</html>
