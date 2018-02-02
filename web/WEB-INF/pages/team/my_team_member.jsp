<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%--
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
    <title>团队成员</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    String teamId= (String)request.getAttribute("teamId");
    List<UserEntity> ManagerList=(List<UserEntity>) request.getAttribute("ManagerList");
    List<UserEntity> teamUserList=(List<UserEntity>) request.getAttribute("userList");
    List<UserEntity> lockedUserList=(List<UserEntity>) request.getAttribute("lockedList");
    List<UserEntity> appliedList=(List<UserEntity>) request.getAttribute("appliedList");
%>
<div class="page">
    <div class="weui-panel__hd weui-cells__title" style="margin-top: 0px;">
        <div class="weui-flex__item">
            <p>查看团队成员信息</p>
        </div>
    </div>
</div>
<div  style="margin-top: 10px;">
<%
    if(teamUserList.size()==0 && lockedUserList.size()==0 && ManagerList.size()==0 && appliedList.size()==0){
%>
    <div class="container" style="margin-left: 20px;margin-top: 60px;">
    <div class="page home js_show">
        <div class="page__hd">
            <h1 class="page__title">
                <font face="黑体" style="font-size: 40px;">Sorry</font>
            </h1>
            <p class="page__desc">还没有人加入你的团队</p>
        </div>
    </div>
</div>
<%}
    if(ManagerList.size()>0){
        %>
    <p style="font-size: 13px;color: #888888;margin-left:3px;margin-bottom: 5px;">管理员</p>
    <%for(int i=0;i<ManagerList.size();i++){%>
    <div class="weui-panel__bd">
        <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
            <label class="weui-cell weui-check__label" for=<%out.print(ManagerList.get(i).getId());%>>
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;" onclick="checkUser(this)" id=<%out.print(ManagerList.get(i).getId());%> >
                    <img src="<%out.print(ManagerList.get(i).getHeadImgUrl());%>" style="width: 50px;height: 50px;display: block">
                </div>
                <div class="weui-cell__bd" onclick="checkUser(this)" id=<%out.print(ManagerList.get(i).getId());%>>
                    <p><%out.print(ManagerList.get(i).getName());%></p>
                    <%if(ManagerList.get(i).getBirth()!=null){%>
                    <p style="font-size: 13px;color: #888888;"><%out.print(ManagerList.get(i).getBirth());%></p><%}%>
                </div>
                <a class="weui-btn weui-btn_mini weui-btn_primary" onclick="demoteManager(this)" style="background-color: #ecc30a"  id=<%out.print(ManagerList.get(i).getId());%>>降级</a>
            </label>
        </div>
    </div>
    <%}
    }
    if(appliedList.size()>0){%>
    <p style="font-size: 13px;color: #888888;margin-top: 5px;margin-bottom: 5px;">申请成员</p>
    <%for(int i=0;i<appliedList.size();i++){%>
    <div class="weui-panel__bd">
        <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
            <label class="weui-cell weui-check__label" for=<%out.print(appliedList.get(i).getId());%>>
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;" onclick="checkUser(this) id=<%out.print(appliedList.get(i).getId());%>">
                    <img src="<%out.print(appliedList.get(i).getHeadImgUrl());%>" style="width: 50px;height: 50px;display: block">
                </div>
                <div class="weui-cell__bd" onclick="checkUser(this)" id=<%out.print(appliedList.get(i).getId());%>>
                    <p><%out.print(appliedList.get(i).getName());%></p>
                    <%if(appliedList.get(i).getBirth()!=null){%>
                    <p style="font-size: 13px;color: #888888;"><%out.print(appliedList.get(i).getBirth());%></p><%}%>
                </div>
                <a class="weui-btn weui-btn_mini weui-btn_primary" onclick="approveApply(this)" style="background-color: #ce3c39" onclick="approve(this)" id=<%out.print(appliedList.get(i).getId());%>>同意</a>
            </label>
        </div>
    </div>
    <%}
    }
    if(teamUserList.size()>0)
    {%>
    <p style="font-size: 13px;color: #888888;margin-top: 5px;margin-bottom: 5px;">已有成员</p>
    <%
    for (int i=0;i<teamUserList.size();i++) {
%>
<div class="weui-panel__bd">
    <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
        <label class="weui-cell weui-check__label" for=<%out.print(teamUserList.get(i).getId());%>>
            <div class="weui-cell__hd" style="position: relative;margin-right: 10px;" onclick="checkUser(this)" id=<%out.print(teamUserList.get(i).getId());%>>
                <img src="<%out.print(teamUserList.get(i).getHeadImgUrl());%>" style="width: 50px;height: 50px;display: block">
            </div>
            <div class="weui-cell__bd" onclick="checkUser(this)" id=<%out.print(teamUserList.get(i).getId());%>>
                <p><%out.print(teamUserList.get(i).getName());%></p>
                <%if(teamUserList.get(i).getBirth()!=null){%>
                <p style="font-size: 13px;color: #888888;"><%out.print(teamUserList.get(i).getBirth());%></p><%}%>
            </div>
            <div class="weui-cell__bd" style="text-align: right;">
                <a class="weui-btn weui-btn_mini weui-btn_primary" style="background-color: whitesmoke;color: #1a1a1a;" onclick="lockTeamMember(this)"  id=<%out.print(teamUserList.get(i).getId());%>>锁定</a>
                <a class="weui-btn weui-btn_mini weui-btn_primary" style="background-color: grey" onclick="PromteManager(this)"  id=<%out.print(teamUserList.get(i).getId());%>>提升</a>
            </div>
        </label>
    </div>
</div>
<%     }
    }
    if(lockedUserList.size()>0){%>
    <p style="font-size: 13px;color: #888888;margin-top: 5px;margin-bottom: 5px;">锁定成员</p>
    <%for(int i=0;i<lockedUserList.size();i++){
%>
    <div class="weui-panel__bd">
        <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
            <label class="weui-cell weui-check__label" for=<%out.print(lockedUserList.get(i).getId());%>>
                <a class="weui-cell__hd" style="position: relative;margin-right: 10px;"  onclick="checkUser(this)" id=<%out.print(lockedUserList.get(i).getId());%>>
                    <img src="<%out.print(lockedUserList.get(i).getHeadImgUrl());%>" style="width: 50px;height: 50px;display: block">
                </a>
                <div class="weui-cell__bd" onclick="checkUser(this)" id=<%out.print(lockedUserList.get(i).getId());%>>
                    <p><%out.print(lockedUserList.get(i).getName());%></p>
                    <%if(lockedUserList.get(i).getBirth()!=null){%>
                    <p style="font-size: 13px;color: #888888;"><%out.print(lockedUserList.get(i).getBirth());%></p><%}%>
                </div>
                <a class="weui-btn weui-btn_mini weui-btn_primary" style="background-color: coral" onclick="UnlockTeamMember(this)" id=<%out.print(lockedUserList.get(i).getId());%>>解锁</a>
            </label>
        </div>
    </div>
    <%}
    }%>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var xmlHttpRequest;
    var teamId=<%=teamId%>;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });
    function lockTeamMember(t) {
        var contextPath="${pageContext.request.contextPath}";
        var targetUrl = "http://"+getDomainName()+contextPath+"/team/lockMember";
        var userId=t.id;
        if(userId!=null){
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userId="+userId+"&teamId="+teamId,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="success"){
                        showAlert("锁定成功",function () {
                            location.reload();
                        });
                    }
                    if(data==="failure"){
                        showAlert("锁定失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
    }
    function UnlockTeamMember(t) {
        var contextPath="${pageContext.request.contextPath}";
        var targetUrl = "http://"+getDomainName()+contextPath+"/team/UnlockMember";
        var userId=t.id;
        if(userId!=null){
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userId="+userId+"&teamId="+teamId,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="success"){
                        showAlert("解锁成功",function () {
                            location.reload();
                        });
                    }
                    if(data==="failure"){
                        showAlert("解锁失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
    }
    function approveApply(t) {
        var contextPath="${pageContext.request.contextPath}";
        var targetUrl = "http://"+getDomainName()+contextPath+"/team/approveUser";
        var userId=t.id;
        if(userId!=null){
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userId="+userId+"&teamId="+teamId,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="success"){
                        showAlert("已同意",function () {
                            location.reload();
                        });
                    }else if(data==="messageFail"){
                        showAlert("已同意但发送信息失败");
                    }else if(data==="failure"){
                        showAlert("同意失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
    }
    function demoteManager(t) {
        var contextPath="${pageContext.request.contextPath}";
        var targetUrl = "http://"+getDomainName()+contextPath+"/team/demoteManager";
        var userId=t.id;
        if(userId!=null){
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userId="+userId+"&teamId="+teamId,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="success"){
                        showAlert("降级同意",function () {
                            location.reload();
                        });
                    }
                    if(data==="failure"){
                        showAlert("降级失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
    }
    function PromteManager(t) {
        var contextPath="${pageContext.request.contextPath}"
        var targetUrl = "http://"+getDomainName()+contextPath+"/team/promoteManager";
        var userId=t.id;
        if(userId!=null){
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userId="+userId+"&teamId="+teamId,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="success"){
                        showAlert("升级同意",function () {
                            location.reload();
                        });
                    }
                    if(data==="message send fail"){
                        showAlert("消息发送失败");
                    }
                    if(data==="failure"){
                        showAlert("升级失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
    }
    function checkUser(User) {
        var userId=User.id;
        window.location.href="${pageContext.request.contextPath}/team/managerUserCheckUser?userID="+userId;
        goTo(url);
    }
</script>
</html>
