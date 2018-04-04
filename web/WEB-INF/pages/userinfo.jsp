<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %><%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/utils.js"></script>
    <script src="../js/scan/function.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link href="http://cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" media="all">
    <link href="http://cdn.bootcss.com/animate.css/3.5.2/animate.min.css" rel="stylesheet" media="all">
    <link href="../css/bootstrap-touch-slider.css" rel="stylesheet" media="all">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/utils.js"></script>
    <script charset="utf-8" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
        a{
            text-decoration: none;
            color:#333;
        }
    </style>
</head>
<%--<body onload="back_exit();">--%>
<script>get_wx_config();</script>
<div class="weui-tab__panel">
    <%
        UserEntity userEntity = (UserEntity) request.getAttribute("user");
    %>
    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/userdetail">
        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
            <img src="<%out.print(userEntity.getHeadImgUrl());%>" style="width: 50px;display: block">
        </div>
        <div class="weui-cell__bd">
            <p><%out.print(userEntity.getName());%></p>
            <p style="font-size: 13px;color: #888888;">手机号:<%
                if( userEntity.getPhone()==null)
                    out.print("暂无");
                else {
                    out.print(userEntity.getPhone());
                }%></p>
        </div>
        <div class="weui-cell__ft">
            <img src="../img/二维码.png" style="width:20px;margin-right:5px;display:block">
        </div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/history_evaluation">
        <div class="weui-cell__hd"><img src="../img/userdetails/评价.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p>我的历史评价</p>
        </div>
        <div class="weui-cell__ft"style="">查看</div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/<%
        if(userEntity.getIsVerify() != null && userEntity.getIsVerify() == 1){
            out.print("realnameInfo");
        }
        else{
            out.print("startRealNameAuth");
        }
        %>">
        <div class="weui-cell__hd"><img src="../img/userdetails/实名认证.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p style="display: block">实名认证</p>
        </div>
        <div class="weui-cell__ft">
            <%
                if(userEntity.getIsVerify() != null && userEntity.getIsVerify() == 1){
                    out.println("<p style=\"color:#1AAD19;\">✓已认证</p>");
                }
                else{
                    out.println("<p>未认证</p>");
                }
            %>
        </div>
    </a>

    <a class="weui-cell weui-cell_access" href="${pageContext.request.contextPath}/user/techInfo">
        <div class="weui-cell__hd"><img src="../img/userdetails/专业服务认证.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
        <div class="weui-cell__bd">
            <p style="display: block">专业服务技能认证</p>
        </div>
        <div class="weui-cell__ft">
            <c:choose>
                <c:when test="${techNum==0}">
                    <p>未认证</p>
                </c:when>
                <c:otherwise>
                    <p style="color:#1AAD19">✓已认证${techNum}项</p>
                </c:otherwise>
            </c:choose>
        </div>
    </a>
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <a href="../user/queryVolPublishAlComplete">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <p>志愿者服务时间</p>
            </div>
            <div class="weui-cell__ft"><%out.print(userEntity.getTimeVol());%></div>
        </div>
    </a>
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>互助服务时间</p>
        </div>
        <div class="weui-cell__ft">暂无</div>
    </div>
    <a href="../user/coins_list">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <p>互助时间(时)</p>
            </div>
            <div class="weui-cell__ft"><%out.print(userEntity.getTimeCoin());%></div>
        </div>
    </a>
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
    <div style="background-color: #f8f8f8; height:10px;"></div>
    <%--<div style="background-color: #f8f8f8; height:10px;"></div>--%>
    <%--<div class="weui-cell">--%>
        <%--<div class="weui-cell__bd">--%>
            <%--<div class="weui-flex">--%>
                <%--<div class="weui-flex__item" display="none">--%>
                   <%--&lt;%&ndash; <a href="${pageContext.request.contextPath}/user/scan" class="weui-btn weui-btn_mini weui-btn_primary">扫码</a>&ndash;%&gt;--%>
                <%--</div>--%>
                <%--<div class="weui-flex__item" display="none"></div>--%>
                <%--<div class="weui-flex__item" display="none"></div>--%>
                <%--<div class="weui-flex__item" display="none"></div>--%>
                <%--<div class="weui-flex__item"><a href="${pageContext.request.contextPath}/user/logout" class="weui-btn weui-btn_mini weui-btn_primary">退出</a></div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    </div>


<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="http://cdn.bootcss.com/jquery.touchswipe/1.6.18/jquery.touchSwipe.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $(document).on("click", "#recharge", function() {
        var r=confirm("您正在进行充值业务，￥15=1互助时间，确认是否继续");
        if(r==true){
            goTo(url+"/recharge/coins_recharge");
        }
    });
    $("#tixian").click(function(){
        showAlert("提现请至中山北路3671弄500号-师大一村活动中心");
    });
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(3)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>