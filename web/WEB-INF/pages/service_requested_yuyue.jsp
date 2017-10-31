<%@ page import="com.blockchain.timebank.entity.RecordEntity" %>
<%@ page import="com.blockchain.timebank.entity.PublishEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>WeUI</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>

<div class="page">

    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item weui-bar__item_on"id="navbar1">
                    已预约
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待上门
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
                    List<RecordEntity> recordList = (List<RecordEntity>) request.getAttribute("recordList");
                    List<PublishEntity> publishList = (List<PublishEntity>) request.getAttribute("publishList");
                    List<ServiceEntity> serviceList = (List<ServiceEntity>) request.getAttribute("serviceList");
                    List<UserEntity> serviceUserList = (List<UserEntity>) request.getAttribute("serviceUserList");
                %>
                <%
                    for (int i=0;i<recordList.size();i++) {
                %>
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务名称</label>
                                <em class="weui-form-preview__value"><%out.print(serviceList.get(i).getName());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value"><%out.print(recordList.get(i).getId());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务提供者</label>
                                <span class="weui-form-preview__value"><%out.print(serviceUserList.get(i).getName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务地点</label>
                                <span class="weui-form-preview__value"><%out.print(recordList.get(i).getApplyAddress());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务时间</label>
                                <span class="weui-form-preview__value"><%out.print(recordList.get(i).getBeginTime());%> - <%out.print(recordList.get(i).getEndTime());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务收费</label>
                                <span class="weui-form-preview__value"><%out.print(recordList.get(i).getPayMoney());%></span>
                            </div>
                            <div class="weui-panel__ft">
                                <a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>
                            </div>
                        </div>
                        <div class="weui-form-preview__ft">
                            <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:">取消</a>
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
    });
</script>

</body>
</html>