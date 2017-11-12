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
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务金额</label>
                                <em class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getPayMoney());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getId());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务地点</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getAddress());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务提供者</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getServiceUserName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务时间</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getActualBeginTime());%> - <%out.print(recordDetailList.get(i).getActualEndTime());%></span>
                            </div>
                            <div class="weui-panel__ft">
                                <a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>
                            </div>
                        </div>
                        <div class="weui-form-preview__ft">
                            <a class="weui-form-preview__btn weui-form-preview__btn_primary" id="payBtn" value=<%out.print(recordDetailList.get(i).getId());%>>支付</a>
                        </div>
                    </div>
                    <br>
                </div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
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
        $("#payBtn").on('click',function () {
            //alert($("#payBtn").attr("value"));
            $.ajax({
                type: 'POST',
                cache: false,
                url: "http://www.hlb9978.com/user/applyUserPayRecord",
                data: "&recordID=" + $("#payBtn").attr("value"),
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    showAlert("扫码成功",function () {
                        goTo("http://www.hlb9978.com/user/queryPublishWaitingService");
                    })
                },
                error: function (xhr, type) {
                    showAlert("扫码失败",function () {
                        goTo("http://www.hlb9978.com/user/queryPublishWaitingService");
                    })
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });
    });
</script>

</body>
</html>