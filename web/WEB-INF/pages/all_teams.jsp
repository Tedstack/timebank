<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: weiyi
  Date: 2017/12/24
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>团体列表</title>
    <!-- 引入样式 -->
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
    List<Long> lockedInList=(List<Long>) request.getAttribute("lockedList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/return.png" width="20" height="15"alt="">团体列表</p>
                </div>
            </div>
            <br>
            <%
                for (int i=0;i<teamList.size();i++) {
            %>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(teamList.get(i).getId());%>>
                        <a class="weui-cell__hd" style="position: relative;margin-right: 10px;" href="${pageContext.request.contextPath}/team/teamIndex?teamId=<%out.print(teamList.get(i).getId());%>">
                            <img src="../img/ECNU.png" style="width: 50px;display: block">
                        </a>
                        <div class="weui-cell__bd">
                            <p><%out.print(teamList.get(i).getName());%></p>
                            <p style="font-size: 13px;color: #888888;"><%out.print(teamList.get(i).getDescription());%></p>
                        </div>
                        <% if(alreadyInTeamList.contains(teamList.get(i).getId())){%>
                        <a class="weui-btn weui-btn_mini weui-btn_primary"  style="background-color: #e6a23c;" id=<%out.print(teamList.get(i).getId());%>>已加入</a>
                        <%}else if(lockedInList.contains(teamList.get(i).getId()))
                            {%>
                        <a class="weui-btn weui-btn_mini weui-btn_primary"  style="background-color: #ecc30a;" id=<%out.print(teamList.get(i).getId());%>>待审核</a>
                        <%}else{%>
                        <a class="weui-btn weui-btn_mini weui-btn_primary"  onclick="joinToTeam(this)" id=<%out.print(teamList.get(i).getId());%>>加入</a>
                        <%}%>
                    </label>
                </div>
            </div>
            <%
                }
            %>
        </div>
            <div class="weui-tabbar">
                <a class="weui-tabbar__item weui-bar__item_on">
                    <span style="display: inline-block;">
                        <img src="../img/Green_star.png" alt="" class="weui-tabbar__icon" style="width: 30px;display: block">
                    </span>
                    <p class="weui-tabbar__label">所有团体</p>
                </a>
                <a href="${pageContext.request.contextPath}/team/chosenTeam" class="weui-tabbar__item">
                    <span style="display: inline-block;">
                        <img src="../img/white_star.png" alt="" class="weui-tabbar__icon" style="width: 30px;display: block">
                    </span>
                    <p class="weui-tabbar__label">已加入团体</p>
                </a>
        </div>
        </div>
    </div>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
         function joinToTeam(t) {
            var contextPath="${pageContext.request.contextPath}"
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/addUserToTeam";
            var teamId=t.id;//取要加入团队的Id
             var check_val = [];
             check_val.push(teamId);
            if(check_val.length!==0){
                $.ajax({
                    type: 'POST',
                    cache: false,
                    url: targetUrl,
                    dataType:'json',
                    traditional:true,
                    data: {"teamIDList":teamId},
                    beforeSend: function (XHR) {
                        dialogLoading = showLoading();
                    },
                    success: function (data) {
                        var value = JSON.stringify(data);
                        var dataJson = JSON.parse(value);

                        if(dataJson.msg==="ok"){
                            showAlert("申请成功",function () {
                                location.reload();
                            });
                        }
                    },
                    error: function (xhr, type) {
                        showAlert("加入失败");
                    },
                    complete: function (xhr, type) {
                        dialogLoading.hide();
                    }
                });
            }else{
                showAlert("请选择要加入的团体");
            }
        }
</script>
</html>
