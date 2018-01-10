<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.TeamEntity" %><%--
  Created by IntelliJ IDEA.
  User: weiyi
  Date: 2017/12/24
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>团队主页</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    TeamEntity team=(TeamEntity) request.getAttribute("teamEntity");
    String managerName=(String) request.getAttribute("managerName");
%>
<div class="page">
    <div class="weui-panel__hd">
        <div class="weui-flex__item" id="return" onclick="goBack()" >
            <p><img src="../img/back.png" width="20" height="15"alt="">团队主页</p>
        </div>
    </div>
    <div class="weui-navbar" style="top: 0px;margin : 35px 0px 10px 0px;">
        <div class="weui-navbar__item" style="background-color: #0076FF;">
            <a class="weui-btn weui-btn_plain-default" style="background-color:#0076FF;border: none;color:#ffffff;height: 25px;font-size: 14px;">简介</a>
        </div>
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/teamMember?teamId=<%out.print(team.getId());%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">成员</a>
        </div>
        <div class="weui-navbar__item" style="border:1px solid #0076FF">
            <a href="${pageContext.request.contextPath}/team/historyActivity?teamId=<%out.print(team.getId());%>" class="weui-btn weui-btn_plain-default" style="border: none;height: 25px;font-size: 14px;">历史活动</a>
        </div>
    </div>
    <div style="margin-top:100px;text-align:center;">
            <br>
            <table align="center" cellpadding="0" style="margin:auto">
                <tr>
                    <td align="right" width="80">
                        <img src="../img/teamHeadImg/<%out.print(team.getHeadImg());%>" style="width: 80px;display: block">
                    </td>
                    <td width="5"></td>
                    <td align="center" width="100">
                        <p style="font-size: 20px;"><%out.print(team.getName());%></p>
                    </td>
                </tr>
            </table>
        </div>
        <div class="page__bd" style="height: 100%;margin-top: 15px;">
            <div class="weui-panel weui-panel_access">
                <div class="weui-panel__bd">
                    <div class="weui-form-preview__hd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><li style="font-size: 15px;">创始时间</li></label>
                            <em class="weui-form-preview__value" style="font-size: 15px;"><%out.print(team.getCreateDate().toString());%></em>
                        </div>
                    </div>
                </div>
                <div class="weui-panel__bd">
                    <div class="weui-form-preview__hd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><li style="font-size: 15px;">创始人</li></label>
                            <em class="weui-form-preview__value" style="font-size: 15px;"><%out.print(managerName);%></em>
                        </div>
                    </div>
                </div>
                <div class="weui-panel__bd">
                    <div class="weui-form-preview__hd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><li style="font-size: 15px;">活动地点</li></label>
                            <em class="weui-form-preview__value" style="font-size: 15px;"><%out.print(team.getAddress());%></em>
                        </div>
                    </div>
                </div>
                <div class="weui-panel__bd">
                    <div class="weui-form-preview__hd">
                        <div class="weui-form-preview__item">
                            <label class="weui-form-preview__label"><li style="font-size: 15px;">简介</li></label>
                            <em class="weui-form-preview__value" style="font-size: 15px;"><%out.print(team.getDescription());%></em>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    function goBack() {
        window.location.href="${pageContext.request.contextPath}/team/teamList";
    }
</script>
</html>
