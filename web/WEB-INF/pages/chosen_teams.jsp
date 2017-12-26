<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.blockchain.timebank.entity.TeamUserEntity" %><%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/7
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已选团体</title>
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
    List<ViewTeamDetailEntity> teamList = (List<ViewTeamDetailEntity>) request.getAttribute("list");
    List<Long> alreadyInTeamList = (List<Long>) request.getAttribute("alreadyInList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/return.png" width="20" height="15"alt="">团体列表</p>
                </div>
            </div>
            <br>
            <%
                for (int i=0;i<alreadyInTeamList.size();i++) {
                    if(alreadyInTeamList.contains(teamList.get(i).getId())){
            %>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(teamList.get(i).getId());%>>
                        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                            <img src="../img/ECNU.png" style="width: 50px;display: block">
                        </div>
                            <div class="weui-cell__bd">
                              <p><%out.print(teamList.get(i).getName());%></p>
                              <p style="font-size: 13px;color: #888888;"><%out.print(teamList.get(i).getDescription());%></p>
                            </div>
                        <a class="weui-btn weui-btn_mini weui-btn_primary" onclick="quitFromTeam(this)" id=<%out.print(teamList.get(i).getId());%>>退出</a>
                    </label>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
        <div class="weui-tabbar">
                <a href="${pageContext.request.contextPath}/team/teamList" class="weui-tabbar__item">
                    <span style="display: inline-block;position: relative;">
                        <img src="../img/Green_star.png" alt="" class="weui-tabbar__icon" style="width: 30px;display: block">
                    </span>
                    <p class="weui-tabbar__label">所有团队</p>
                </a>
                <a href="javascript:;" class="weui-tabbar__item weui-bar__item_on">
                    <span style="display: inline-block;position: relative;">
                        <img src="../img/white_star.png" alt="" class="weui-tabbar__icon" style="width: 30px;display: block">
                    </span>
                    <p class="weui-tabbar__label">已加入团队</p>
                </a>
        </div>
    </div>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
         function quitFromTeam(t) {
            var contextPath="${pageContext.request.contextPath}"
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/quiteFromTeam";
            var teamId=t.id;//退出团队的Id
             var check_val = [];
             check_val.push(teamId);
            if(check_val.length!==0){
                $.ajax({
                    type: 'POST',
                    cache: false,
                    url: targetUrl,
                    dataType:'json',
                    traditional:true,
                    data: {"teamIDList":check_val},
                    beforeSend: function (XHR) {
                        dialogLoading = showLoading();
                    },
                    success: function (data) {
                        var value = JSON.stringify(data);
                        var dataJson = JSON.parse(value);

                        if(dataJson.msg==="ok"){
                            showAlert("退出成功",function () {
                                location.reload();
                            });
                        }
                    },
                    error: function (xhr, type) {
                        showAlert("退出失败");
                    },
                    complete: function (xhr, type) {
                        dialogLoading.hide();
                    }
                });
            }
        }
</script>
</html>
