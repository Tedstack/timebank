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
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>



    <div class="weui-tab__panel">

        <%
            UserEntity userEntity = (UserEntity) request.getAttribute("user");
        %>
        <a class="weui-cell weui-cell_access" href="/user/startModifyPersonalInfo">
            <div class="weui-cell__hd"><img src="../img/我的.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
            <div class="weui-cell__bd">
                <p><%out.print(userEntity.getName());%></p>
            </div>
            <div class="weui-cell__ft">个人信息</div>
        </a>
        <img src="../img/底部.png" width="375" height="15">

        <a class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__hd"><img src="../img/userdetails/新消息通知.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
            <div class="weui-cell__bd">
                <p>新消息通知</p>
            </div>
        </a>

        <img src="../img/底部.png" width="375" height="15">

            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__hd"><img src="../img/userdetails/时间币.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>时间币余额</p>
                </div>
                <div class="weui-cell__ft"><%out.print(userEntity.getTimeCoin());%> C</div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__hd"><img src="../img/userdetails/时间.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>时间</p>
                </div>
                <div class="weui-cell__ft">查看</div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__hd"><img src="../img/userdetails/志愿者.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>志愿者币</p>
                </div>
                <div class="weui-cell__ft"><%out.print(userEntity.getTimeVol());%> V</div>
            </a>
        <img src="../img/底部.png" width="375" height="15">

            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__hd"><img src="../img/userdetails/实名认证.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>实名认证</p>
                </div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__hd"><img src="../img/userdetails/志愿者认证.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>志愿者认证</p>
                </div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__hd"><img src="../img/userdetails/专业服务认证.png" alt="" style="width:20px;margin-right:5px;display:block"></div>
                <div class="weui-cell__bd">
                    <p>专业服务技能认证</p>
                </div>
            </a>

            <div style="padding: 10px; margin-bottom: 20px;">
                <a href="/user/logout" class="weui-btn weui-btn_primary">退出登录</a>
            </div>


    </div>

    <jsp:include page="bottom_tabbar.jsp"/>


<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(2)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>