<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待服务</title>
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
                    已预约
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar2">
                    待服务
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    待付款
                </div>
                <div class="weui-navbar__item"id="navbar4">
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
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"><%out.print(recordDetailList.get(i).getServiceName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">订单号：<%out.print(recordDetailList.get(i).getId());%></p>
                            <p class="weui-media-box__desc">时间：<%out.print(recordDetailList.get(i).getBeginTime());%> - <%out.print(recordDetailList.get(i).getEndTime());%></p>
                            <p class="weui-media-box__desc">预计付费：
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
                            </p>
                            <ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta">服务人：<%out.print(recordDetailList.get(i).getServiceUserName());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">服务提供者：<%out.print(recordDetailList.get(i).getServiceUserName());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">其他信息</li>
                            </ul>
                        </div>
                    </div>
                </div>
                        <div class="weui-form-preview__ft">
                            <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:">扫码开始</a>
                        </div>
                <img src="../img/底部.png" width="375" height="15">
                    </div>
                    <br>
                </div>
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
            location.href="/user/queryOrderAlreadyApply";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryOrderWaitingService";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryOrderWaitingPay";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="/user/queryOrderAlreadyComplete";
        });
    });
</script>

</body>
</html>