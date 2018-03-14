<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.*" %>
<%@ page import="com.blockchain.timebank.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    <title>团队信息</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body onpageshow="normal_back();">
<%
    TeamEntity team=(TeamEntity) request.getAttribute("teamEntity");
    String managerName=(String) request.getAttribute("managerName");
    List<ViewTeamUserDetailEntity> userList=(List<ViewTeamUserDetailEntity>) request.getAttribute("userList");
    List<ViewTeamUserDetailEntity> managerList=(List<ViewTeamUserDetailEntity>) request.getAttribute("managerList");
    UserEntity creator=(UserEntity) request.getAttribute("creator");
    List<ActivityPublishEntity> publicActivity=(List<ActivityPublishEntity>) request.getAttribute("publicActivity");
    List<ActivityPublishEntity> privateActivity=(List<ActivityPublishEntity>) request.getAttribute("privateActivity");
    String isMember=(String) request.getAttribute("isMember");
%>
<div class="page">
    <div class="weui-navbar">
        <div class="weui-navbar__item weui-bar__item_on"id="navbar1">
            团队信息
        </div>
        <div class="weui-navbar__item"id="navbar2">
            团队成员
        </div>
        <div class="weui-navbar__item"id="navbar3">
            历史活动
        </div>
    </div>
    <div id="index" tyle="display: block;">
    <div style="margin-top:60px;text-align:center;">
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
    <div class="page__bd" style="margin-top: 15px;">
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
                           <label class="weui-form-preview__label"><li style="font-size: 15px;">联系方式</li></label>
                           <em class="weui-form-preview__value" style="font-size: 15px;"><%out.print(team.getPhone());%></em>
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
            <div class="weui-panel__bd">
                <div class="weui-form-preview__hd">
                    <a href="${pageContext.request.contextPath}/team/teamComment?teamId=<%out.print(team.getId());%>" class="weui-form-preview__item">
                        <label class="weui-form-preview__label"><li style="font-size: 15px;">历史评价</li></label>
                        <img src="../img/more.png" width="20" height="20" style="width: 6%;">
                    </a>
                </div>
            </div>
            <%if(isMember.equalsIgnoreCase("Out")){%>
            <div class="weui-panel__bd">
                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <a id="addUser" onclick="joinToTeam()" class="weui-btn weui-btn_plain-default" style="width: 200px;">加入</a>
                    </div>
                </div>
            </div>
            <%}else if(request.getAttribute("isCreator").equals("true")){%>
            <div class="weui-panel__bd">
                <div class="weui-form-preview__hd">
                    <div class="weui-form-preview__item">
                        <a href="${pageContext.request.contextPath}/team/viewTeamInfoPage?teamId=<%out.print(team.getId());%>" class="weui-btn weui-btn_plain-default" style="width: 200px;">查看</a>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
    </div>
    <div id="member" style="display: none;">
        <div class="weui-panel__bd" style="margin : 80px 0px 10px 0px;">
            <div class="weui-cells weui-cells_checkbox">
                <label class="weui-cell weui-check__label">
                    <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                        <img src="<%out.print(creator.getHeadImgUrl());%>" style="width: 50px;height: 50px;display: block">
                    </div>
                    <div class="weui-cell__bd">
                        <p><%out.print(creator.getName());%></p>
                        <p style="font-size: 13px;color: #888888;">创建者</p>
                    </div>
                </label>
            </div>
        </div>
        <%
            if(managerList.size()>0){
                for(int i=0;i<managerList.size();i++){%>
        <div class="weui-panel__bd" style="margin : 0px 0px 10px 0px;">
            <div class="weui-cells weui-cells_checkbox">
                <label class="weui-cell weui-check__label">
                    <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                        <img src="<%out.print(managerList.get(i).getUserHeadImg());%>" style="width: 50px;height: 50px;display: block">
                    </div>
                    <div class="weui-cell__bd">
                        <p><%out.print(managerList.get(i).getUserName());%></p>
                        <p style="font-size: 13px;color: #888888;">管理员</p>
                    </div>
                </label>
            </div>
        </div>
        <%}
        }
        %>
        <%
            for(int i=0;i<userList.size();i++){
        %>
        <div class="weui-panel__bd" style="margin : 0px 0px 10px 0px;">
            <div class="weui-cells weui-cells_checkbox">
                <label class="weui-cell weui-check__label">
                    <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                        <img src="<%out.print(userList.get(i).getUserHeadImg());%>" style="width: 50px;height: 50px;display: block">
                    </div>
                    <div class="weui-cell__bd">
                        <p><%out.print(userList.get(i).getUserName());%></p>
                        <p style="font-size: 13px;color: #888888;">成员</p>
                    </div>
                </label>
            </div>
        </div>
        <%}%>
    </div>
    <div id="activity" style="margin : 80px 0px 10px 0px;display: none;">
        <%for(int i=0;i<publicActivity.size();i++){%>
        <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=1&activityID=<%out.print(publicActivity.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
            <div class="weui-media-box__hd">
                <img class="weui-media-box__thumb" src="../img/activityImg/<%out.print(publicActivity.get(i).getHeadImg());%>" alt="">
            </div>
            <div class="weui-media-box__bd">
                <h4 class="weui-media-box__title"><%out.print(publicActivity.get(i).getName());%></h4>
                <p class="weui-media-box__desc">开始时间:
                    <%
                        Timestamp beginTimestamp = publicActivity.get(i).getBeginTime();
                        Date date = new Date(beginTimestamp.getTime());
                        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                        out.print(bartDateFormat.format(date));
                    %></p>
                <p class="weui-media-box__desc">结束时间:
                    <%
                        Timestamp endTimestamp = publicActivity.get(i).getEndTime();
                        Date date2 = new Date(endTimestamp.getTime());
                        SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                        out.print(bartDateFormat2.format(date2));
                    %></p>
                <ul class="weui-media-box__info">
                    <li class="weui-media-box__info__meta" style="margin-bottom: 2px;"><%out.print(publicActivity.get(i).getCount());%>人</li>
                    <li class="weui-media-box__info__meta"><%out.print(publicActivity.get(i).getAddress());%></li>
                </ul>
            </div>
        </a>
        <div style="background-color: #f8f8f8; height:10px;"></div>
        <%}%>
        <%
            if(isMember.equalsIgnoreCase("alreadyIn")){
            for(int i=0;i<privateActivity.size();i++){
        %>
        <a href="${pageContext.request.contextPath}/team/teamActivityDetails?type=1&activityID=<%out.print(privateActivity.get(i).getId());%>" class="weui-media-box weui-media-box_appmsg">
            <div class="weui-media-box__hd">
                <img class="weui-media-box__thumb" src="../img/activityImg/<%out.print(privateActivity.get(i).getHeadImg());%>" alt="">
            </div>
            <div class="weui-media-box__bd">
                <h4 class="weui-media-box__title"><%out.print(privateActivity.get(i).getName());%></h4>
                <p class="weui-media-box__desc">开始时间:
                    <%
                        Timestamp beginTimestamp = privateActivity.get(i).getBeginTime();
                        Date date = new Date(beginTimestamp.getTime());
                        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                        out.print(bartDateFormat.format(date));
                    %></p>
                <p class="weui-media-box__desc">结束时间:
                    <%
                        Timestamp endTimestamp = privateActivity.get(i).getEndTime();
                        Date date2 = new Date(endTimestamp.getTime());
                        SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                        out.print(bartDateFormat2.format(date2));
                    %></p>
                <ul class="weui-media-box__info">
                    <li class="weui-media-box__info__meta" style="margin-bottom: 2px;"><%out.print(privateActivity.get(i).getCount());%>人</li>
                    <li class="weui-media-box__info__meta"><%out.print(privateActivity.get(i).getAddress());%></li>
                </ul>
            </div>
        </a>
        <%}}%>
    </div>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var index=document.getElementById("index");
    var member=document.getElementById("member");
    var activity=document.getElementById("activity");
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            showIndex();
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            showMember();
        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            showActivity();
        });
    });
    function showIndex() {
        index.style.display="block";
        member.style.display="none";
        activity.style.display="none";
    }
    function showMember() {
        index.style.display="none";
        member.style.display="block";
        activity.style.display="none";
    }
    function showActivity() {
        index.style.display="none";
        member.style.display="none";
        activity.style.display="block";
    }
    function joinToTeam() {
        var contextPath="${pageContext.request.contextPath}";
        var targetUrl = "http://"+getDomainName()+contextPath+"/team/addUserToTeam";
        var teamId='<%=team.getId()%>';//取要加入团队的Id
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
    }
</script>
<script type="text/javascript">
</script>
</html>
