<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishOrderDetailEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.blockchain.timebank.weixin.util.FormatOrderIdUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待确认</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body>
<%
    List<ViewPublishOrderDetailEntity> recordDetailList = (List<ViewPublishOrderDetailEntity>) request.getAttribute("recordDetailList");
%>
<div class="main-container">
    <div class="main-content">
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <%--<div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">待确认</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>--%>
            <div class="weui-navbar" style="position:fixed;">
                <div class="weui-navbar__item "id="navbar1">
                    已发布
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar2" style="color: #7ACF41">
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
            <div class="weui-tab__panel" style="padding-bottom: 50px; padding-top: 70px">
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
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title">订单号<%out.print(FormatOrderIdUtil.getServiceOrderFormatId(recordDetailList.get(i)));%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>

                            </div>
                            <p class="weui-media-box__desc">服务项目: <%out.print(recordDetailList.get(i).getServiceName());%></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">开始时间:
                                <%
                                    Timestamp beginTimestamp = recordDetailList.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc"style="color: #7ACF41">结束时间:
                                <%
                                    Timestamp endTimestamp = recordDetailList.get(i).getEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <p class="weui-media-box__desc">服务地点: <%out.print(recordDetailList.get(i).getAddress());%></p>
                            <p class="weui-media-box__desc">服务对象: <%out.print(recordDetailList.get(i).getApplyUserName());%></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">申请者联系方式: <%out.print(recordDetailList.get(i).getApplyUserPhone());%></p>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd" >
                            <%
                                if(recordDetailList.get(i).getEndTime().getTime() < new Date().getTime()){
                            %>
                        </div>
                        <div class="weui-cell__ft">
                            <a id="applyOverDate-button" class="weui-btn weui-btn_mini weui-btn-default" style="background-color: #999; color:#fff; border:0px;text-decoration:none;" onclick="return false;">
                                申请已过期
                            </a>
                        </div>
                        <%} else {%>
                        <div class="weui-flex">
                            <div class="weui-flex__item"><p>预估价:</p></div>
                            <div class="weui-flex__item"><p>
                                <%
                                    Timestamp beginStamp = recordDetailList.get(i).getBeginTime();
                                    Timestamp endStamp = recordDetailList.get(i).getEndTime();
                                    long begin = beginStamp.getTime();
                                    long end = endStamp.getTime();

                                    long l = end - begin;
                                    String s = String.valueOf(l);
                                    double d = Double.parseDouble(s);
                                    double price = recordDetailList.get(i).getPublishPrice();
                                    double money = price * (d/(3600*1000));
                                    BigDecimal bg = new BigDecimal(money);
                                    double convertedMoney = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                                    out.print(convertedMoney);
                                %>
                            </p></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/record/handleApplicantRecord?handle=refuse&recordID=<%out.print(recordDetailList.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_default">拒绝</a></div>
                            <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/record/handleApplicantRecord?handle=confirm&recordID=<%out.print(recordDetailList.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_primary">接受</a></div>
                        </div>
                    </div>
                    <div class="weui-cell__ft">
                    </div>
                    <%}%>
                    </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>

        <div class="weui-tabbar" style="height: 50px">
            <a href="${pageContext.request.contextPath}/publish/list?type=志愿者服务" class="weui-tabbar__item">
                <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label" >服务柜台</p>
            </a>
            <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyApply" class="weui-tabbar__item">
                <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label" style="margin:0px">预约的服务</p>
            </a>
            <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyPublish" class="weui-tabbar__item">
                <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
                <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">发布的服务</p>
            </a>
        </div>

</div>
</div>
<button class="float-button" style="font-size: xx-large;" id="create">+
</button>
</div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/publish/add");
    });
    $(function(){
        var isPageHide = false;
        window.addEventListener('pageshow', function () {
            if (isPageHide) {
                window.location.reload();
            }
        });
        window.addEventListener('pagehide', function () {
            isPageHide = true;
        });

        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishAlreadyPublish";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingConfirm";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingService";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingCollect";
        });
        $("#navbar5").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishAlreadyComplete";
        });
    });
</script>

</body>
</html>