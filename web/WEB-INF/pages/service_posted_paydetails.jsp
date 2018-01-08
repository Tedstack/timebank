<%@ page import="com.blockchain.timebank.entity.ViewPublishOrderDetailEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <script src="../js/scan/configs.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/refundRobot.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>
<%
    ViewPublishOrderDetailEntity recordDetail = (ViewPublishOrderDetailEntity) request.getAttribute("viewPublishOrderDetailEntity");
    String volunteerService = "志愿者服务";
%>

<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <label class="weui-form-preview__label">付款金额:</label>
        <em class="weui-form-preview__value" style="color: #7ACF41"><%out.print(recordDetail.getPayMoney());%></em>
    </div>
    <div class="weui-form-preview__bd">
        <p>
            <label class="weui-form-preview__label">订单编号:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getId());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务类型:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getServiceType());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">付款方式:</label>
            <span class="weui-form-preview__value" style="color:#76b852">
                <%
                    String unit = "";
                    if(recordDetail.getServiceId() / 100 == 1)
                        unit="志愿者时间";
                    else if(recordDetail.getServiceId() / 100 == 2)
                        unit="元";
                    else
                        unit="时间币";
                    out.print(unit);
                %>
            </span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务名称:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getServiceName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务人:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getServiceUserName());%></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务时长:</label>
            <span class="weui-form-preview__value">
                <%
                    Timestamp beginTimestamp = recordDetail.getActualBeginTime();
                    Date date = new Date(beginTimestamp.getTime());
                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                    Timestamp endTimestamp = recordDetail.getActualEndTime();
                    Date date2 = new Date(endTimestamp.getTime());
                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                    out.print(bartDateFormat.format(date)+" -- "+bartDateFormat2.format(date2));
                %></span>
        </p>
        <p>
            <label class="weui-form-preview__label">服务地点:</label>
            <span class="weui-form-preview__value"><%out.print(recordDetail.getAddress());%></span>
        </p>
    </div>
    <div class="weui-form-preview__ft">
        <a class="weui-form-preview__btn weui-form-preview__btn_default" href="${pageContext.request.contextPath}/user/queryOrderWaitingPay">返回</a>
        <a class="weui-form-preview__btn weui-form-preview__btn_primary" id="payBtn">支付</a>
    </div>
</div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    var contextPath="${pageContext.request.contextPath}";
    var type='<%=recordDetail.getServiceType()%>';
    var recordID = '<%=recordDetail.getId()%>';
    $(function(){
        $("#payBtn").on('click',function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/user/applyUserPayTimeVol";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/user/queryOrderAlreadyComplete";
            var volunteerService = '志愿者服务';
            var mutualHelpService = '互助服务';
            var professionService = '专业服务';
            if(type === volunteerService || type === mutualHelpService){
                $.ajax({
                    type: 'POST',
                    cache: false,
                    url: targetUrl,
                    //dataType:'JSONP',
                    data: "recordID=" + recordID,
                    beforeSend: function (XHR) {
                        dialogLoading = showLoading();
                    },
                    success: function (data) {
                        //alert(data);
                        showAlert("支付成功",function () {
                            goTo(targetUrl2);
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
            }else if(type === professionService){
                wx.scanQRCode(
                    {
                        needResult: 0,
                        success: function (res) {

                            //alert(JSON.stringify(res.resultStr));

                        }
                    }
                );
            }
        });
    });
</script>

</body>
</html>