<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/23
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有的服务</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>

<%
    List<ServiceEntity> list=(List<ServiceEntity>)request.getAttribute("list");
    if(list!=null){
        for(ServiceEntity serviceEntity:list){
%>

            <div>
                <ul>
                    <li>服务编号：<%out.print(serviceEntity.getId());%></li>
                    <li>服务类型：<%out.print(serviceEntity.getType());%></li>
                    <li>服务名称：<%out.print(serviceEntity.getName());%></li>
                    <li>服务价格：<%out.print(serviceEntity.getPrice());%></li>
                    <li>服务更新时间：<%out.print(serviceEntity.getUpdateTime());%></li>
                </ul>
            </div>

<%      }
    }%>

</body>
</html>
