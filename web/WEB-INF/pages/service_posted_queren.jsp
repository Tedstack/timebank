<%@ page import="com.blockchain.timebank.entity.RecordEntity" %>
<%@ page import="com.blockchain.timebank.entity.PublishEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待确认</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<%
    List<ViewRecordDetailEntity> recordDetailList = (List<ViewRecordDetailEntity>) request.getAttribute("recordDetailList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item "id="navbar1">
                    已发布
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar2">
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
                    for (int i=0;i<recordDetailList.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务名称/<%out.print(recordDetailList.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title">订单号<%out.print(recordDetailList.get(i).getId());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>

                            </div>
                            <p class="weui-media-box__desc"><%out.print(recordDetailList.get(i).getBeginTime());%></p>
                            <p class="weui-media-box__desc"><%out.print(recordDetailList.get(i).getEndTime());%></p>
                            <ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta"><%out.print(recordDetailList.get(i).getAddress());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra"><%out.print(recordDetailList.get(i).getApplyUserName());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra"><%out.print(recordDetailList.get(i).getApplyUserPhone());%></li>
                            </ul>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"><a href="<%out.print("/record/handleApplicantRecord?handle=refuse&recordID="+recordDetailList.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_default">拒绝</a></div>
                                <div class="weui-flex__item"><a href="<%out.print("/record/handleApplicantRecord?handle=confirm&recordID="+recordDetailList.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_primary">接受</a></div>
                            </div>
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