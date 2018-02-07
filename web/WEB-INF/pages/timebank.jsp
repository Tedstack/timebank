<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>时间银行</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/utils.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link href="http://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" media="all">
    <link href="http://cdn.bootcss.com/animate.css/3.5.2/animate.min.css" rel="stylesheet" media="all">
    <link href="../css/bootstrap-touch-slider.css" rel="stylesheet" media="all">
    <style>
        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }
        .button5 {border-radius: 50%;}
    </style>
</head>
<body>
<%
    UserEntity userEntity = (UserEntity) request.getAttribute("user");
%>
<div class="htmleaf-container">
    <div id="bootstrap-touch-slider" class="carousel bs-slider fade  control-round indicators-line" data-ride="carousel" data-pause="hover" data-interval="5000" >
        <ol class="carousel-indicators">
            <li data-target="#bootstrap-touch-slider" data-slide-to="0" class="active"></li>
        </ol>
        <div class="carousel-inner" role="listbox">
            <div class="item active" style="height: 180px">
                <img src="../img/timebank.jpg" alt="Bootstrap Touch Slider"  class="slide-image"/>
                <div class="bs-slider-overlay"></div>
            </div>
        </div>
    </div>
</div>
<table>
    <tr>
        <td>
            <button class="button button5" style="margin: 20px 35px;float:left;padding:20px 30px" id="recharge">时间币充值</button>
        </td>
        <td>
            <button class="button button5" style="margin: 20px 35px;float:right;padding:20px 30px;background-color: #a2958a" id="tixian">时间币提现</button>
        </td>
    </tr>
</table>
<div class="weui-cell">
    <div class="weui-cell__bd">
        <p>志愿者服务时间</p>
    </div>
    <div class="weui-cell__ft"><%out.print(userEntity.getTimeVol());%></div>
</div>
<div class="weui-cell">
    <div class="weui-cell__bd">
        <p>互助服务时间</p>
    </div>
    <div class="weui-cell__ft">暂无</div>
</div>
<div class="weui-cell">
    <div class="weui-cell__bd">
        <p>时间币(时)</p>
    </div>
    <div class="weui-cell__ft"><%out.print(userEntity.getTimeCoin());%></div>
</div>
<div class="weui-cell">
    <div class="weui-cell__bd">
        <p>我的服务评价分</p>
    </div>
    <div class="weui-cell__ft">暂无</div>
</div>

<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="http://cdn.bootcss.com/jquery.touchswipe/1.6.18/jquery.touchSwipe.min.js"></script>

</body>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $(document).on("click", "#recharge", function() {
        var r=confirm("您正在进行充值业务，￥1=1时间币，确认是否继续");
        if(r===true){
            goTo(url+"/recharge/coins_recharge");
        }
    });
</script>
</html>