<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %><%--
  Created by IntelliJ IDEA.
  User: Ted
  Date: 2018/1/11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已报名成员</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    List<UserEntity> userList = (List<UserEntity>) request.getAttribute("userList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/back.png" width="20" height="15"alt="">已报名成员</p>
                </div>
            </div>
            <br>
            <%
                for (int i=0;i<userList.size();i++) {
            %>
            <div class="weui-panel__bd" onclick="viewTeamPage(this)" id="<%out.print(userList.get(i).getId());%>">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(userList.get(i).getId());%>>
                        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                            <img src="../img/teamHeadImg/<%out.print(userList.get(i).getHeadImgUrl());%>" style="width: 50px;display: block">
                        </div>
                        <div class="weui-cell__bd">
                            <p><%out.print(userList.get(i).getName());%></p>
                        </div>
                    </label>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
</script>
</html>
