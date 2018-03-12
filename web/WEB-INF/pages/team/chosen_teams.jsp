<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.blockchain.timebank.entity.TeamUserEntity" %>
<%@ page import="com.blockchain.timebank.entity.TeamEntity" %><%--
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
    <title>已选团队</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>

</head>
<body>
<%
    List<ViewTeamDetailEntity> teamList = (List<ViewTeamDetailEntity>) request.getAttribute("list");
    List<Long> alreadyInTeamList = (List<Long>) request.getAttribute("alreadyInList");
    List<Long> managerTeamList = (List<Long>) request.getAttribute("managerTeamList");
    List<TeamEntity> myTeam=(List<TeamEntity>) request.getAttribute("myTeam");
%>
<div class="main-container">
    <div class="main-content">
<div class="weui-tab">
    <div class="weui-tab__panel" style="height: 100%;padding-top: 0px;">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p> 团队列表</p>
                </div>
            </div>
            <br>
            <div class="weui-cell weui-cell_access" style="margin-bottom: 5px;" id="myTeam" onclick="showList(this);">
                <div class="weui-cell__bd">
                    <span style="vertical-align: middle">创建的团队</span>
                </div>
                <span style="vertical-align: middle;color: #d0d0d0;"><%out.print(myTeam.size());%></span>
                <div class="weui-cell__ft"></div>
            </div>
            <div style="display: none;margin-bottom: 5px;" id="myTeamList">
                <%for (int i=0;i<myTeam.size();i++) {%>
                <div class="weui-panel__bd" onclick="viewTeamPage(this)" id="<%out.print(myTeam.get(i).getId());%>">
                    <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                        <label class="weui-cell weui-check__label" for=<%out.print(myTeam.get(i).getId());%>>
                            <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                                <img src="../img/teamHeadImg/<%out.print(myTeam.get(i).getHeadImg());%>" style="width: 50px;height: 50px;display: block">
                            </div>
                            <div class="weui-cell__bd">
                                <p><%out.print(myTeam.get(i).getName());%></p>
                                <p style="font-size: 13px;color: #888888;"><%out.print(myTeam.get(i).getDescription());%></p>
                            </div>
                        </label>
                    </div>
                </div>
                <%}%>
            </div>
            <div class="weui-cell weui-cell_access" style="margin-bottom: 5px;" id="manageTeam" onclick="showList(this);">
                <div class="weui-cell__bd">
                    <span style="vertical-align: middle">管理的团队</span>
                </div>
                <span style="vertical-align: middle;color: #d0d0d0;"><%out.print(managerTeamList.size());%></span>
                <div class="weui-cell__ft"></div>
            </div>
            <div style="display: none;margin-bottom: 5px;" id="manageTeamList">
            <%for (int i=0;i<teamList.size();i++) {
                    if(managerTeamList.contains(teamList.get(i).getId())){%>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(teamList.get(i).getId());%>>
                        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;"  onclick="viewTeamPage(this)" id="<%out.print(teamList.get(i).getId());%>">
                            <img src="../img/teamHeadImg/<%out.print(teamList.get(i).getHeadImg());%>" style="width: 50px;height: 50px;display: block">
                        </div>
                        <div class="weui-cell__bd"  onclick="viewTeamPage(this)" id="<%out.print(teamList.get(i).getId());%>">
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
            <div class="weui-cell weui-cell_access" style="margin-bottom: 5px;" id="alreadyInTeam" onclick="showList(this);">
                <div class="weui-cell__bd">
                    <span style="vertical-align: middle">参加的团队</span>
                </div>
                <span style="vertical-align: middle;color: #d0d0d0;"><%out.print(alreadyInTeamList.size());%></span>
                <div class="weui-cell__ft"></div>
            </div>
            <div style="display: none;margin-bottom: 5px;" id="alreadyInTeamList">
            <%
                for (int i=0;i<teamList.size();i++) {
                    if(alreadyInTeamList.contains(teamList.get(i).getId())){
            %>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(teamList.get(i).getId());%>>
                        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;"  onclick="viewTeamPage(this)" id="<%out.print(teamList.get(i).getId());%>">
                            <img src="../img/teamHeadImg/<%out.print(teamList.get(i).getHeadImg());%>" style="width: 50px;height: 50px;display: block">
                        </div>
                        <div class="weui-cell__bd"  onclick="viewTeamPage(this)" id="<%out.print(teamList.get(i).getId());%>">
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
    </div>
    <div class="weui-tabbar">
        <a href="${pageContext.request.contextPath}/team/teamList" class="weui-tabbar__item">
            <span style="display: inline-block;position: relative;">
                <img src="../img/white_star.png" alt="" class="weui-tabbar__icon" style="width: 30px;display: block">
            </span>
            <p class="weui-tabbar__label">所有</p>
        </a>
        <a href="${pageContext.request.contextPath}/team/chosenTeam" class="weui-tabbar__item weui-bar__item_on">
            <span style="display: inline-block;position: relative;">
                <img src="../img/Green_star.png" alt="" class="weui-tabbar__icon" style="width: 30px;display: block">
            </span>
            <p class="weui-tabbar__label">已加入</p>
        </a>
        <a href="${pageContext.request.contextPath}/team/myTeams" class="weui-tabbar__item">
            <span style="display: inline-block;">
                <img src="../img/white_star.png" alt="" class="weui-tabbar__icon" style="width: 30px;display: block">
            </span>
            <p class="weui-tabbar__label">我创建的</p>
        </a>
    </div>
</div>
    </div>
    <button class="float-button" style="font-size: xx-large;" id="create">+
    </button>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/team/createPage");
    });
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    function quitFromTeam(t) {
        var contextPath="${pageContext.request.contextPath}";
        var targetUrl = "http://"+getDomainName()+contextPath+"/team/quiteFromTeam";
        var teamId=t.id;//退出团队的Id
        $.ajax({
            type: 'POST',
            cache: false,
            url: targetUrl,
            data: "teamId="+teamId,
            beforeSend: function (XHR) {
                dialogLoading = showLoading();
            },
            success: function (data) {
                if(data==="success"){
                    showAlert("退出成功",function() {
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
    function viewTeamPage(t) {
        var teamId=t.id;
        window.location.href="${pageContext.request.contextPath}/team/teamInfo?teamId="+teamId;
    }
    function showList(t) {
        var id=t.id+"List";
        var display=document.getElementById(id).style.display;
        if(display==="none") {
            document.getElementById(id).style.display = "block";
            document.getElementById(t.id).style.backgroundColor="aliceblue";
        }
        else {
            document.getElementById(id).style.display = "none";
            document.getElementById(t.id).style.backgroundColor="white";
        }
    }
</script>
</html>
