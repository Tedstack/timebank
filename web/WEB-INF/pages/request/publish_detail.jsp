<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 06/01/2018
  Time: 00:02
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link href="../css/dj_base_838a930.css" rel="stylesheet" type="text/css">
    <link href="../css/dj_dc_content_f60f458.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../css/swiper-3.4.0.min.css">
    <style>
        .weui-cell{
            padding-left: 20px;
        }
        .detail-content{
            color:#999
        }
    </style>
    <title>已发布服务详情</title>
</head>
<body>

<%
    ViewRequestDetailEntity detail = (ViewRequestDetailEntity) request.getAttribute("detail");
    String type = null;
    switch (request.getParameter("type")){
        case "volunteer":
            type = "志愿者需求";
            break;
        case "technic":
            type = "专业需求";
            break;
        case "mutualAid":
            type = "互助需求";
            break;
    }

%>

<div class="weui-tab">
    <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-left: 5px">
        <div id="return" onclick="history.go(-1)"><img src="../img/返回.png" style="width:20px; height:15px; display: inline-block" alt="">返回</div>
    </div>
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <%--<div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0; padding-left: 15px">
            <div align="center">
                <img class="weui-media-box__thumb" style="width:25%" src="../img/服务名称/<%=detail.getServiceName()%>.png">
                <h2><%=detail.getServiceName()%></h2>
                <p><%=detail.getDescription()%></p>
            </div>
        </div>--%>

        <div class="weui-cells" style="margin-top: 40px;">
            <div class="weui-cell" style="padding-left:15px">
                <h2 style="color:#76b852">需求详情</h2>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <span class="detail-title">需求类型 ：</span><span class="detail-content"><%=type%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <span class="detail-title">需求名称 ：</span><span class="detail-content"><%=detail.getServiceName()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <span class="detail-title">需求地址 ：</span><span class="detail-content"><%=detail.getAddress()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <span class="detail-title">持续时间 ：</span>
                    <span class="detail-content">

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            Timestamp timestampBegin = detail.getBeginTime();
                            Date dateBegin = new Date(timestampBegin.getTime());
                            Timestamp timestampEnd = detail.getEndTime();
                            Date dateEnd = new Date(timestampEnd.getTime());
                            out.print(bartDateFormat.format(dateBegin) + " 至 " + bartDateFormat.format(dateEnd));
                        %>

                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <span class="detail-title">服务单价 ：</span><span class="detail-content"><%=detail.getPrice()%><%
                    if("volunteer".equals(detail.getServiceType())){
                        out.print("志愿者时间");
                    } else if("mutualAid".equals(detail.getServiceType())){
                        out.print("时间币");
                    } else{
                        out.print("元");
                    }
                %>/小时</span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <span class="detail-title">预留电话 ：</span><span class="detail-content"><%=detail.getUserPhone()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <span class="detail-title">服务描述 ：</span><span class="detail-content"><%=detail.getDescription()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd"></div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span style="color:#76b852">接受服务须知</span>
            </div>
            <div class="con_u">
                <p>需要服务者申请您的服务后，您可以选择接受或拒绝<br/><br/>接受服务后不可取消，拒绝服务不会影响您任何信誉或评价<br/><br/>若有任何变动请及时与申请服务者联系</p>
            </div>
        </div>

    </div>

    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">活动</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">我</p>
        </a>
    </div>
</div>
</body>
</html>

