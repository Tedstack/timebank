<%@ page import="com.blockchain.timebank.entity.TeamEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>查看团队信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
</head>
<%
    TeamEntity team=(TeamEntity)request.getAttribute("teamEntity");
    String currentUser=(String)request.getAttribute("currentUser");
%>
<body onload="checkUser();">
<div class="weui-cells weui-cells_form" style="margin-top: 0px;">
    <div class="weui-panel__hd weui-cells__title" style="margin-top: 0px;">
        <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
            <p> 查看团队信息</p>
        </div>
    </div>
    <div class="weui-cells_form weui-cells">
        <div class="weui-cell" style="margin-left: 130px;">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item weui-flex justify align">
                        <div class="weui-uploader">
                            <div class="weui-uploader__hd">
                                <p class="weui-uploader__title">团队头像</p>
                            </div>
                            <div class="weui-uploader__bd">
                                <img src="../img/teamHeadImg/<%out.print(team.getHeadImg());%>" style="width:100px;display: block">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队名称</label>
        </div>
        <div class="weui-cell__bd">
            <p class="weui-input"><%out.print(team.getName());%></p>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">活动区域</label></div>
        <div class="weui-cell__bd">
            <textarea readonly id="teamLocation" class="weui-textarea" name="describe" rows="2"><%out.print(team.getAddress());%></textarea>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">联系方式</label></div>
        <div class="weui-cell__bd">
            <p class="weui-input"><%out.print(team.getPhone());%></p>
        </div>
    </div>
    <div class="weui-panel__ft">
        <a href="${pageContext.request.contextPath}/team/myTeamMember?teamId=<%out.print(team.getId());%>" class="weui-cell weui-cell_access weui-cell_link">
            <div class="weui-cell__bd"><label class="weui-label" style="font-size: 17px;color: #1a1a1a;">团队成员</label></div>
            <span class="weui-cell__ft"></span>
        </a>
    </div>
    <div class="weui-panel__ft">
        <a href="${pageContext.request.contextPath}/team/myTeamHistory?teamId=<%out.print(team.getId());%>" class="weui-cell weui-cell_access weui-cell_link">
            <div class="weui-cell__bd"><label class="weui-label" style="font-size: 17px;color: #1a1a1a;">历史活动</label></div>
            <span class="weui-cell__ft"></span>
        </a>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队介绍</label></div>
        <div class="weui-cell__bd">
            <div class="weui-cell__bd">
                <textarea readonly id="teamDescription" class="weui-textarea" name="describe" rows="3"><%out.print(team.getDescription());%></textarea>
            </div>
        </div>
    </div>
    <div style="padding: 10px; margin-top: 10px;">
        <a href="${pageContext.request.contextPath}/team/modifyPage?teamId=<%out.print(team.getId());%>" class="weui-btn weui-btn_primary" id="modifyTeam" type="button">修改</a>
    </div>
    <div style="padding: 10px; margin-bottom: 20px;">
        <a href="javascript:;" class="weui-btn weui-btn_primary" id="deleteTeam" name=<%out.print(team.getId());%> type="button" style="background-color: #ce3c39;">解散</a>
    </div>
</div>

</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    function checkUser() {
        var currentUser='<%=currentUser%>';
        var creator='<%=team.getCreatorId()%>';
        var teamStatus='<%=team.isDeleted()%>';
        if(currentUser!==creator){
            showAlert("非创建者无修改页面信息权限",function () {
                $('a').removeAttr('onclick');
            });
        }else if(teamStatus!=='false'){
            showAlert("该团队已经被删除",function () {
                $('a').removeAttr('onclick');
            });
        }
    }
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    $(function(){
        $("#deleteTeam").on('click', function () {
            var r=confirm("确认解散该团队?");
            if(r==true){
                var contextPath="${pageContext.request.contextPath}";
                var targetUrl = "http://"+getDomainName()+contextPath+"/team/deleteTeam";
                var teamId=document.getElementById("deleteTeam").name;
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
                            showAlert("删除成功",function () {
                                window.location.href="${pageContext.request.contextPath}/team/myTeams"
                            });
                        }
                        if(data==="failure"){
                            showAlert("删除失败");
                        }
                    },
                    error: function (xhr, type) {
                        showAlert("操作失败");
                    },
                    complete: function (xhr, type) {
                        dialogLoading.hide();
                    }
                });
            }
        });
    });
</script>
</html>