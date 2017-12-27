<%@ page import="com.blockchain.timebank.entity.RechargeEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: hanyunxia
  Date: 2017/12/26
  Time: 13:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>时间币详情</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="weui-tab">
    <div class="weui-panel">
        <%
            RechargeEntity details = (RechargeEntity) request.getAttribute("rechargeEntity");
        %>
        <div class="weui-cells">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>订单编号</p>
                </div>
                <div class="weui-cell__ft"><%=details.getId()%></div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>充值金额</p>
                </div>
                <div class="weui-cell__ft">+<%=details.getTotalAmount()%></div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>充值时间</p>
                </div>
                <div class="weui-cell__ft"><%=details.getRechargeDate()%></div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>充值状态</p>
                </div>
                <div class="weui-cell__ft">
                    <%=details.getRechargeStatus()%>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">备注</div>
                <div class="weui-cell__ft">
                   <%
                       if(details.getExtra()==null){
                           out.print("无");
                       }
                       else {
                           details.getExtra();
                       }
                   %>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
