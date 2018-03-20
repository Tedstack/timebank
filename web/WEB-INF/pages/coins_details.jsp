<%@ page import="com.blockchain.timebank.entity.Service_request_entity" %>
<%@ page import ="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
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
        <div class="weui-panel">
            <%
                Service_request_entity details = (Service_request_entity)request.getAttribute("coin_entity");
                long userid = (long)request.getAttribute("userid");
            %>
            <div class="weui-cells">
                <% if(userid == details.getServiceUserid() ){ %>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>订单编号：</p>
                    </div>
                    <div class="weui-cell__ft"><%=details.getOrderid()%></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>服务名称：</p>
                    </div>
                    <div class="weui-cell__ft"><%
                        if("service".equals(details.getClarify()))
                        {
                            out.println("互助服务：" + details.getService_name());
                        }
                        if("request".equals(details.getClarify())){
                            out.println("互助需求：" + details.getService_name());
                        }
                    %></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>服务对象：</p>
                    </div>
                    <div class="weui-cell__ft"><%=details.getNeedUsername()%></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>收入：</p>
                    </div>
                    <div class="weui-cell__ft">+<%=details.getPaymoney()%></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>服务开始时间：</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%
                            Timestamp beginTimestamp = details.getActualBeginTime();
                            Date begindate = new Date(beginTimestamp.getTime());
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            out.print(bartDateFormat.format(begindate));
                        %>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">服务结束时间：</div>
                    <div class="weui-cell__ft">
                        <%
                            Timestamp endTimestamp = details.getActualEndTime();
                            Date enddate = new Date(endTimestamp.getTime());
                            out.print(bartDateFormat.format(enddate));
                        %>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd"><p>评价：</p></div>
                    <div class="weui-cell__ft">
                        <%

                            if(details.getComment() == null){
                                out.print("无");
                            }
                            else{
                                out.print(details.getComment());
                            }
                        %></div>
                </div>
                <%}%>
                <% if (userid== details.getNeedUserid()){
                %>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>订单编号：</p>
                    </div>
                    <div class="weui-cell__ft"><%=details.getOrderid()%></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>服务名称：</p>
                    </div>
                    <div class="weui-cell__ft"><%
                        if("service".equals(details.getClarify()))
                        {
                            out.println("互助服务：" + details.getService_name());
                        }
                        if("request".equals(details.getClarify())){
                            out.println("互助需求：" + details.getService_name());
                        }
                    %></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>提供服务者：</p>
                    </div>
                    <div class="weui-cell__ft"><%=details.getServiceUserName()%></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>支出：</p>
                    </div>
                    <div class="weui-cell__ft">-<%=details.getPaymoney()%></div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>服务开始时间：</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%
                            Timestamp beginTimestamp = details.getActualBeginTime();
                            Date begindate = new Date(beginTimestamp.getTime());
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            out.print(bartDateFormat.format(begindate));
                        %>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">结束时间：</div>
                    <div class="weui-cell__ft">
                        <%
                            Timestamp endTimestamp = details.getActualEndTime();
                            Date enddate = new Date(endTimestamp.getTime());
                            out.print(bartDateFormat.format(enddate));
                        %>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd"><p>评价：</p></div>
                    <div class="weui-cell__ft">
                        <%

                            if(details.getComment() == null){
                                out.print("无");
                            }
                            else{
                                out.print(details.getComment());
                            }
                        %></div>
                </div>
                <%}%>
            </div>

        </div>
    </div>
</div>
</body>
</html>
