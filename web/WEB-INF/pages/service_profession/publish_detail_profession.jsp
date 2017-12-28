<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: caozihan
  Date: 2017/12/20
  Time: 15:43
  To change this template use File | Settings | File Templates.
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
    <title>服务详情</title>
</head>
<body>

<%
    ViewPublishDetailEntity detail = (ViewPublishDetailEntity) request.getAttribute("detail");
    List<ViewRecordDetailEntity> recordList = (List<ViewRecordDetailEntity>) request.getAttribute("recordList");
    int age = (int) request.getAttribute("age");
    double timeVol = (double) request.getAttribute("timeVol");
%>

<div class="weui-tab">
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0; padding-left: 15px">
            <div align="center">
                <img class="weui-media-box__thumb" style="width:25%" src="../img/服务名称/<%=detail.getServiceName()%>.png">
                <h2><%=detail.getServiceName()%></h2>
                <p><%=detail.getDescription()%></p>
            </div>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <span style="color:#008487">服务详情</span>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:32px; display:inline" src="../img/littleicon/定位.png">
                    <span><%=detail.getAddress()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="width:32px; display:inline" src="../img/littleicon/时间.png">
                    <span>

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            Timestamp timestampBegin = detail.getBeginDate();
                            Date dateBegin = new Date(timestampBegin.getTime());
                            Timestamp timestampEnd = detail.getEndDate();
                            Date dateEnd = new Date(timestampEnd.getTime());
                            out.print(bartDateFormat.format(dateBegin) + " - " + bartDateFormat.format(dateEnd));
                        %>

                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd"></div>
                <div class="weui-cell__ft">
                    <a class="weui-btn weui-btn_plain-default" href="${pageContext.request.contextPath}/record/apply?id=<%=detail.getId()%>">
                        <%=detail.getPrice()%>元/小时 申请服务
                    </a>
                </div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span style="color:#008487">申请须知</span>
            </div>
            <div class="con_u">
                <p>申请前请看清时间范围及服务区域<br/><br/>提交申请后不可取消，等待提供服务者确认接受后即可服务<br/><br/>若有任何变动请及时与服务者联系</p>
            </div>
        </div>

    </div>

    <div class="weui-tabbar">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>
</body>
</html>
