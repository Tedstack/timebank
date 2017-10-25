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
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <%
            UserEntity userEntity = (UserEntity) request.getAttribute("user");
        %>

        <div class="weui-cells">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p><%out.print(userEntity.getName());%></p>
                </div>
                <div class="weui-cell__ft"><%out.print(userEntity.getPhone());%></div>
            </div>
        </div>
        <div class="weui-cells">
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>新消息通知</p>
                </div>
                <div class="weui-cell__ft"></div>
            </a>
        </div>
        <div class="weui-cells__title">钱包</div>
        <div class="weui-cells">
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>时间币余额</p>
                </div>
                <div class="weui-cell__ft"><%out.print(userEntity.getTimeCoin());%> C</div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>时间</p>
                </div>
                <div class="weui-cell__ft">查看</div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>志愿者币</p>
                </div>
                <div class="weui-cell__ft"><%out.print(userEntity.getTimeVol());%> V</div>
            </a>
        </div>
        <div class="weui-cells__title">服务</div>
        <div class="weui-cells">
            <a href="/user/queryPublish" class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>已发布的服务</p>
                </div>
                <div class="weui-cell__ft"></div>
            </a>
            <a href="/user/queryOrder" class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>已申请的服务</p>
                </div>
                <div class="weui-cell__ft"></div>
            </a>
        </div>
        <div class="weui-cells__title">  </div>
        <div class="weui-cells__title">信息完善</div>
        <div class="weui-cells">
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>实名认证</p>
                </div>
                <div class="weui-cell__ft"></div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>志愿者认证</p>
                </div>
                <div class="weui-cell__ft"></div>
            </a>
            <a class="weui-cell weui-cell_access" href="javascript:;">
                <div class="weui-cell__bd">
                    <p>专业服务技能认证</p>
                </div>
                <div class="weui-cell__ft"></div>
            </a>
            <a href="/user/logout" class="weui-btn weui-btn_plain-primary">退出登录</a>
        </div>
    </div>

    <jsp:include page="bottom_tabbar.jsp"/>
</div>


<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(2)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>