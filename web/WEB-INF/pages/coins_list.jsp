<%@ page import="com.blockchain.timebank.entity.RechargeEntity" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: hanyunxia
  Date: 2017/12/26
  Time: 13:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的时间币</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="weui-tab">
    <div class="weui-panel">

        <div class="weui-panel__hd">
            <span>时间币明细</span>
        </div>
        <%
            List<RechargeEntity> list = (List<RechargeEntity>)request.getAttribute("list");
            if(list.isEmpty()) {
                out.print("暂无任何记录");
            }
            else{
                for(RechargeEntity rechargeEntity:list){
        %>
        <div class="weui-panel__bd">
            <a href=<%out.print("coins_details?id="+rechargeEntity.getId()); %> class="weui-media-box weui-media-box_appmsg">
                <div class="weui-media-box__hd">
                    <img class="weui-media-box__thumb" src="../img/支付.png">
                </div>
                <div class="weui-media-box__bd">
                    <div class="weui-media-box__title">
                        <span>充值</span>
                        <span style="float: right">+<%out.print(rechargeEntity.getTotalAmount());%></span>
                    </div>
                    <div class="weui-media-box__info">
                        <span><%out.print(rechargeEntity.getRechargeDate());%></span>
                    </div>
                </div>
            </a>
        </div>
        <% } }%>
    </div>
</div>
</body>
</html>
