<%@ page import="com.blockchain.timebank.entity.Service_request_entity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2017/12/25
  Time: 19:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>志愿者时间详情</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="weui-tab">
    <div class="weui-tab__panel">
    <div class="weui-panel weui-panel_access">

        <div class="weui-panel__hd">
            <span>志愿者时间明细</span>
        </div>

        <div class="weui-panel__bd">
            <%
                List<Service_request_entity> list = (List<Service_request_entity>)request.getAttribute("recordDetailList");
                long userid = (long)request.getAttribute("userid");
                if(list.isEmpty()) {
                    out.print("暂无任何记录");
                }
                else{
                    for(Service_request_entity viewPublishOrderDetailEntity :list){
            %>
            <a href="<%out.print("vol_detail?id="+viewPublishOrderDetailEntity.getId()+"&clarify="+viewPublishOrderDetailEntity.getClarify());%>" class="weui-media-box weui-media-box_appmsg">
                <div class="weui-media-box__hd">
                    <img class="weui-media-box__thumb" src="../img/服务名称/<%out.print(viewPublishOrderDetailEntity.getService_name());%>.png" width="5%" >
                </div>
                <div class="weui-media-box__bd">
                    <div class="weui-media-box__title">
                        <span><%
                            if("service".equals(viewPublishOrderDetailEntity.getClarify()))
                            {
                                out.println("志愿者服务—" + viewPublishOrderDetailEntity.getService_name());
                            }
                            if("request".equals(viewPublishOrderDetailEntity.getClarify())) {
                                out.println("志愿者需求—" + viewPublishOrderDetailEntity.getService_name());
                            }
                        %></span>
                        <%
                            if(userid == viewPublishOrderDetailEntity.getServiceUserid()){
                        %>
                        <span style="float: right">+<%out.print(viewPublishOrderDetailEntity.getPaymoney());%></span>
                        <%}%>
                        <%
                            if(userid == viewPublishOrderDetailEntity.getNeedUserid()){
                        %>
                        <span style="float: right">-<%out.print(viewPublishOrderDetailEntity.getPaymoney());%></span>
                        <%}%>
                    </div>
                    <div class="weui-media-box__info">
                        <%
                            Timestamp endTimestamp = viewPublishOrderDetailEntity.getActualEndTime();
                            Date enddate = new Date(endTimestamp.getTime());
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            out.print(bartDateFormat.format(enddate));
                        %>
                    </div>
                </div>
            </a>
            <% } }%>
        </div>
    </div>
    </div>
</div>
</body>
</html>
