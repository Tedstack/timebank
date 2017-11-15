<%@ page import="com.blockchain.timebank.entity.PublishEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已发布</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<%
    List<ViewPublishDetailEntity> publishList = (List<ViewPublishDetailEntity>) request.getAttribute("publishList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item weui-bar__item_on"id="navbar1">
                    已发布
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待确认
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    待服务
                </div>
                <div class="weui-navbar__item"id="navbar4">
                    待收款
                </div>
                <div class="weui-navbar__item"id="navbar5">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<publishList.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务名称/<%out.print(publishList.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"><%out.print(publishList.get(i).getServiceName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc"><%out.print(publishList.get(i).getServiceType());%></p>
                            <p class="weui-media-box__desc">开始时间
                                <%
                                    Timestamp timestamp = publishList.get(i).getBeginDate();
                                    Date date = new Date(timestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc">结束时间
                                <%
                                    Timestamp timestamp2 = publishList.get(i).getEndDate();
                                    Date date2 = new Date(timestamp2.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta"><%out.print(publishList.get(i).getAddress());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">等待确认</li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra"><%out.print(publishList.get(i).getUserPhone());%></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="weui-cell">
                <div class="weui-cell__bd">
                    <div class="weui-flex">
                        <div class="weui-flex__item"diaplay="none"></div>
                        <div class="weui-flex__item"display="none"></div>
                        <div class="weui-flex__item"display="none"></div>
                        <div class="weui-flex__item"><a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">查看</a></div>
                        <div class="weui-flex__item"><a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">删除</a></div>
                    </div>
                </div>
                </div>
                <img src="../img/底部.png" width="375" height="15">
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <jsp:include page="bottom_tabbar.jsp"/>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryPublishAlreadyPublish";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryPublishWaitingConfirm";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryPublishWaitingService";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryPublishWaitingCollect";
        });
        $("#navbar5").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryPublishAlreadyComplete";
        });
    });
</script>

</body>
</html>