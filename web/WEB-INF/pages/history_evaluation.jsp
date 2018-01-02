<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/1/2
  Time: 16:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>历史评价</title>
    <link rel="stylesheet" href="css/weui.css">
    <link rel="stylesheet" href="css/weui-example.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap-touch-slider.css" media="all">
</head>
<body>
    <div class="weui-panel">
        <div class="weui-panel__hd">
            <span>历史评价信息</span>
        </div>
        <%
            List<ViewRecordDetailEntity> list = (List<ViewRecordDetailEntity>)request.getAttribute("recordlist");
            if(list.isEmpty()) {
                out.print("暂无任何记录");
            }
            else{
                for(ViewRecordDetailEntity recordlist:list){
        %>
        <div class="weui-panel__bd">
            <a href="javascript:" class="weui-media-box weui-media-box_appmsg">
            <div class="weui-media-box__bd">
                   <span><%out.print(recordlist.getServiceName());%></span>
                    <span style="float: right">
                        <%
                            Timestamp endTimestamp =recordlist .getActualEndTime();
                            Date enddate = new Date(endTimestamp.getTime());
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            out.print(bartDateFormat.format(enddate));
                        %></span>
            </div>
            <div class="weui-media-box__info">
                <span>服务评分:<%out.print(recordlist.getRating());%>分</span><br>

                <span>评价:
                <%
                    if(recordlist.getComment()!=null){
                        out.print(recordlist.getComment());
                    }
                %></span>
                </div>
            </a>
        </div>
        <% } }%>
    </div>
    </div>
</body>
</html>
