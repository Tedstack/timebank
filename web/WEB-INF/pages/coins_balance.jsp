
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的互助时间</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<div class="weui-tab">
    <div class="weui-panel">
        <div class="weui-panel__hd">
            <span>互助时间</span>
            <a href="${pageContext.request.contextPath}/user/coins_list" style="float:right;text-decoration: none">互助时间明细</a>
        </div>
        <div class="weui-cell__bd">
            <div class="weui-msg">
                <div class="weui-msg__icon-area">
                    <img src="../img/coin.jpg" width="100" height="100">
                </div>

                <div class="weui-msg__text-area">
                    <h1 class="weui-msg__title" style="font-size: x-large">我的互助时间</h1>
                    <h2 class="weui-msg__title" style="font-size: xx-large">${TimeCoin}</h2>
                </div>

                <div class="weui-msg__opr-area">
                    <p class="weui-btn-area">
                        <a href="javascript:;" class="weui-btn weui-btn_primary" id="recharge">充值</a>
                    </p>
                    <%--<p class="weui-btn-area">
                        <a href="" class="weui-btn weui-btn_default">提现</a>
                    </p>--%>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $(document).on("click", "#recharge", function() {
        var r=confirm("您正在进行充值业务，￥1=1互助时间，确认是否继续");
        if(r===true){
            goTo(url+"/recharge/coins_recharge");
        }
    });
</script>
</body>
</html>
