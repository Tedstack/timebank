<%@ page import="com.blockchain.timebank.entity.Service_request_entity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
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
    <title>我的互助时间</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="weui-tab">
    <div class="weui-panel">

        <div class="weui-panel__hd">
            <span>互助时间明细</span>
        </div>

        <div class="weui-panel__bd">
            <%
                List<Service_request_entity> list = (List<Service_request_entity>)request.getAttribute("list");
                long userid = (long)request.getAttribute("userid");
                if(list.isEmpty()) {
                    out.print("暂无任何记录");
                }
                else{
                    for(Service_request_entity coins_list :list){
            %>
            <%if("recharge".equals(coins_list.getClarify())){%>
            <a href="<%out.print("recharge_detial?id="+coins_list.getId());%>" class="weui-media-box weui-media-box_appmsg">
                <div class="weui-media-box__hd">
                    <img class="weui-media-box__thumb" src="../img/支付.png" width="5%" >
                </div>
                <div class="weui-media-box__bd">
                    <div class="weui-media-box__title">
                        <span>微信充值</span>
                        <span style="float: right">+<%out.print(coins_list.getPaymoney());%></span>
                    </div>
                    <div class="weui-media-box__info">
                        <%
                            Timestamp endTimestamp = coins_list.getActualEndTime();
                            Date enddate = new Date(endTimestamp.getTime());
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            out.print(bartDateFormat.format(enddate));
                        %>
                    </div>
                </div>
            </a>
            <%}else{%>
            <a href="<%out.print("coins_details?id="+coins_list.getId()+"&clarify="+coins_list.getClarify());%>" class="weui-media-box weui-media-box_appmsg">
                <div class="weui-media-box__hd">
                    <img class="weui-media-box__thumb" src="../img/服务名称/<%out.print(coins_list.getService_name());%>.png" width="5%" >
                </div>
                <div class="weui-media-box__bd">
                    <div class="weui-media-box__title">
                        <span><%
                            if("service".equals(coins_list.getClarify()))
                            {
                                out.println("互助服务—" + coins_list.getService_name());
                            }
                            if("request".equals(coins_list.getClarify())) {
                                out.println("互助需求—" + coins_list.getService_name());
                            }
                        %></span>
                        <%
                            if(userid == coins_list.getServiceUserid()){
                        %>
                        <span style="float: right">+<%out.print(coins_list.getPaymoney());%></span>
                        <%}%>
                        <%
                            if(userid == coins_list.getNeedUserid()){
                        %>
                        <span style="float: right">-<%out.print(coins_list.getPaymoney());%></span>
                        <%}%>
                    </div>
                    <div class="weui-media-box__info">
                        <%
                            Timestamp endTimestamp = coins_list.getActualEndTime();
                            Date enddate = new Date(endTimestamp.getTime());
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            out.print(bartDateFormat.format(enddate));
                        %>
                    </div>
                </div>
            </a>
            <% }} }%>
        </div>
    </div>
</div>
</body>
</html>
