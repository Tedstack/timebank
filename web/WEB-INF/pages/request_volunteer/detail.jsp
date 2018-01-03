<%@ page import="com.blockchain.timebank.entity.ViewVolunteerRequestDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %><%--
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
    <title>服务详情</title>
</head>
<body>

<%
    ViewVolunteerRequestDetailEntity detail = (ViewVolunteerRequestDetailEntity) request.getAttribute("detail");
    List<ViewVolunteerRequestDetailEntity> recordList = (List<ViewVolunteerRequestDetailEntity>) request.getAttribute("recordList");
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

        <div class="weui-cells__title">
            <span style="color:#008487">需求详情</span>
        </div>
        <div class="weui-cells">

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="height:20.5px; display:inline; vertical-align: text-bottom;" src="../img/littleicon/定位.png">
                    <span><%=detail.getAddress()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="height:20.5px; display:inline; vertical-align: text-bottom;" src="../img/littleicon/时间.png">
                    <span>

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            Timestamp timestampBegin = detail.getBeginTime();
                            Date dateBegin = new Date(timestampBegin.getTime());
                            Timestamp timestampEnd = detail.getEndTime();
                            Date dateEnd = new Date(timestampEnd.getTime());
                            out.print(bartDateFormat.format(dateBegin) + " - " + bartDateFormat.format(dateEnd));
                        %>

                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <a class="weui-btn weui-btn_plain-default" href="${pageContext.request.contextPath}/request/volunteerApply?id=<%=detail.getId()%>">
                        <%=detail.getPrice()%>志愿者币/小时 申请需求
                    </a>
                </div>
            </div>
        </div>

        <article class="weui-article">
            <section>
                <h2 class="title" style="color:#008487">申请须知</h2>
                <section>
                    <p>
                        申请前请看清时间及需求地址<br/>
                        提交申请后不可取消，等待提供需求者确认接受后即可服务<br/>
                        若有任何变动请及时与需求者联系<br/>
                    </p>
                </section>
            </section>
        </article>

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
