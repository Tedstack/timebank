<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %>
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
    <title>历史评价</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="weui-tab">
    <div class="weui-panel">

        <div class="weui-panel__hd">
            <span>我的历史评价信息</span>
        </div>
        <%
            List<ViewRecordDetailEntity> list = (List<ViewRecordDetailEntity>)request.getAttribute("recordlist");
            if(list.isEmpty()) {
                out.print("暂无任何记录");
            }
            else{
                for(ViewRecordDetailEntity viewRecordDetailEntity:list){
        %>
        <div class="weui-panel__bd">
            <a href=<%out.print("vol_detail?id="+viewRecordDetailEntity.getId()); %> class="weui-media-box weui-media-box_appmsg">
            <div class="weui-media-box__bd">
                <div class="weui-media-box__title">
                    <span><%out.print(viewRecordDetailEntity.getServiceName());%></span>
                    <span style="float: right"><%
                        Timestamp endTimestamp =viewRecordDetailEntity .getActualEndTime();
                        Date enddate = new Date(endTimestamp.getTime());
                        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        out.print(bartDateFormat.format(enddate));
                    %></span><br>
                    <span>服务评分：<%
                        if(viewRecordDetailEntity.getRating() != null){
                            double rate = viewRecordDetailEntity.getRating();
                            int myrate = (int)(rate);
                            for(int i=0;i<myrate;i++){%>
                            <img  src="../img/黄色星.png" width="5%" height="5%">
                            <%}%>
                        <%}%></span><br>
                    <span>评价：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%
                            if(viewRecordDetailEntity.getComment()!=null){
                                out.print(viewRecordDetailEntity.getComment());
                            }
                        %></span><br>
                </div>
            </div>
            </a>
        </div>
        <% } }%>
    </div>
</div>
</body>
</html>
