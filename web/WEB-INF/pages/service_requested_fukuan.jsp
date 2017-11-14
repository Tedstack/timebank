<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待付款</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>

<%
    List<ViewRecordDetailEntity> recordDetailList = (List<ViewRecordDetailEntity>) request.getAttribute("recordDetailList");
%>

<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item"id="navbar1">
                    已预约
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待服务
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar3">
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
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务类型/志愿者服务.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title">金额<%out.print(recordDetailList.get(i).getPayMoney());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"> <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="<%out.print("/user/applyUserStartPay?recordID="+recordDetailList.get(i).getId());%>">支付</a></div>
                            </div>
                            <p class="weui-media-box__desc">订单号：<%out.print(recordDetailList.get(i).getId());%></p>
                            <p class="weui-media-box__desc">服务时间：<%out.print(recordDetailList.get(i).getActualBeginTime());%> - <%out.print(recordDetailList.get(i).getActualEndTime());%></p>
                            <ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta"><%out.print(recordDetailList.get(i).getAddress());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">服务人：<%out.print(recordDetailList.get(i).getServiceUserName());%></li>
                            </ul>
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
    //var recordList=<%=recordDetailList%>;
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

        /*$("#payBtn").on('click',function () {
            //location.href="/user/applyUserPayTimeCoin?recordID="+$("#payBtn").attr("value");
            //alert($("#payBtn").attr("value"));
            $.ajax({
                type: 'POST',
                cache: false,
                url: "http://www.hlb9978.com/user/applyUserPayTimeCoin",
                //dataType:'JSONP',
                data: "recordID=" + $("#payBtn").attr("value"),
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    //alert(data);
                    showAlert("支付成功",function () {
                        goTo("http://www.hlb9978.com/user/queryOrderAlreadyComplete");
                    })
                },
                error: function (xhr, type) {
                    //alert(type);
                    showAlert("支付失败",function () {
                        //goTo("http://www.hlb9978.com/user/queryOrderWaitingPay");
                    })
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });*/
    });
</script>

</body>
</html>