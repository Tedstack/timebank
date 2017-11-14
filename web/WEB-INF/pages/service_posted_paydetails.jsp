<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>支付详情</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    ViewRecordDetailEntity recordDetail = (ViewRecordDetailEntity) request.getAttribute("viewRecordDetailEntity");
    String volunteerService = "志愿者服务";
%>

<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <label class="weui-form-preview__label">付款金额</label>
        <em class="weui-form-preview__value"><%out.print(recordDetail.getPayMoney());%></em>
    </div>
    <div class="weui-form-preview__bd">
        <p>
            <label class="weui-form-preview__label">订单编号</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getId());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务类型</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getServiceType());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务名称</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getServiceName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务人</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getServiceUserName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务时长</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getActualBeginTime());%> - <%out.print(recordDetail.getActualEndTime());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务地点</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getAddress());%></span>
        </p>
    </div>
    <div class="weui-form-preview__ft">
        <a class="weui-form-preview__btn weui-form-preview__btn_default" href="/user/queryOrderWaitingPay">返回</a>
        <a class="weui-form-preview__btn weui-form-preview__btn_primary" id="payBtn">支付</a>
    </div>
</div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var type='<%=recordDetail.getServiceType()%>';
    var recordID = '<%=recordDetail.getId()%>';
    $(function(){
        $("#payBtn").on('click',function () {
            var volunteerService = '志愿者服务';
            if(type === volunteerService){
                $.ajax({
                    type: 'POST',
                    cache: false,
                    url: "http://www.hlb9978.com/user/applyUserPayTimeVol",
                    //dataType:'JSONP',
                    data: "recordID=" + recordID,
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
            }else{
                showAlert("当前不支持非志愿者服务类型的订单支付")
            }

        });
    });
</script>

</body>
</html>