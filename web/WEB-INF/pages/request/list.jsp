<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 29/12/2017
  Time: 13:36
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/utils.js"></script>
    <script type="text/javascript">back_to("${pageContext.request.contextPath}/index");</script>
    <style>
        .overtimeFlag{
            float:right;
            font-size:16px;
            color:#848c99;
            line-height:57px;
        }
    </style>
    <title>需求列表</title>
</head>
<body>
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access" style="margin-bottom: 50px">
            <div class="weui-panel__hd">
                <span>
                    <%
                        String type = null;
                        String moneyType = null;
                        switch ((String) request.getAttribute("type")){
                            case "volunteer":
                                type = "志愿者需求";
                                moneyType = "志愿者时间";
                                break;
                            case "technic":
                                type = "专业需求";
                                moneyType = "元";
                                break;
                            case "mutualAid":
                                type = "互助需求";
                                moneyType = "时间币";
                                break;
                        }
                        out.print(type);
                    %>
                </span>
                <a href="javascript:;" onclick="window.location.href='${pageContext.request.contextPath}/request/select?type=<%out.print(request.getAttribute("type"));%>'" style="float:right;color:#337ab7">筛选</a>
            </div>
            <div class="weui-panel__bd">

                <%
                    List<ViewRequestDetailEntity> list = (List<ViewRequestDetailEntity>) request.getAttribute("list");
                    for (ViewRequestDetailEntity viewRequestDetailEntity : list) {
                %>

                <a href="<%out.print("detail?id="+viewRequestDetailEntity.getId()+"&type="+type);%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="<%out.print(viewRequestDetailEntity.getHeadImgUrl());%>">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title" style="display:inline-block">
                            <img style="height:20.5px; vertical-align: text-bottom" src="../img/服务名称/<%out.print(viewRequestDetailEntity.getServiceName());%>.png" />
                            <%out.print(viewRequestDetailEntity.getServiceName());%>
                        </h4>
                        <%
                            Date currentDate = new Date();
                            SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
                            String currentTime = sdf.format(currentDate);
                            if(viewRequestDetailEntity.getIsComplete()==(byte) 1){
                                out.print("<span class='overtimeFlag'>已完成</span>");
                            }
                            else if(viewRequestDetailEntity.getEndTime().getTime() < new Date(currentTime).getTime()){
                                out.print("<span class='overtimeFlag'>已过期</span>");
                            }
                        %>
                        <p class="weui-media-box__desc">
                            <span style="color: #7ACF41;">¥
                                <%
                                    out.print(viewRequestDetailEntity.getPrice()+moneyType);
                                %>
                            </span>
                            <br/>
                            <%out.print(viewRequestDetailEntity.getUserName());%> &nbsp;&nbsp;&nbsp;
                            <%out.print(viewRequestDetailEntity.getAddress());%>
                        </p>
                    </div>
                </a>
                <%}%>
            </div>
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">活动</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>
</body>
</html>
