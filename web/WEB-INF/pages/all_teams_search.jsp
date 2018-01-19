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
    <title>搜索结果</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    String param=(String) request.getAttribute("param");
    List<ViewTeamDetailEntity> myTeamList = (List<ViewTeamDetailEntity>) request.getAttribute("myList");
    List<ViewTeamDetailEntity> otherTeamList=(List<ViewTeamDetailEntity>) request.getAttribute("otherList");
    List<ViewTeamDetailEntity> alreadyInTeamList = (List<ViewTeamDetailEntity>) request.getAttribute("alreadyInList");
    List<ViewTeamDetailEntity> appliedList=(List<ViewTeamDetailEntity>) request.getAttribute("appliedList");
%>
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="goBack()" >
                    <p> 团队列表</p>
                </div>
            </div>
            <div class="container" id="container">
                <div class="page searchbar js_show">
                    <div class="page__bd">
                        <!--<a href="javascript:;" class="weui-btn weui-btn_primary">点击展现searchBar</a>-->
                        <div class="weui-search-bar" id="searchBar">
                            <form class="weui-search-bar__form" action="${pageContext.request.contextPath}/team/searchTeam" method="get">
                                <div class="weui-search-bar__box" style="height:5%;">
                                    <i class="weui-icon-search"></i>
                                    <input type="search" class="weui-search-bar__input" name="searchInput" id="searchInput" value=<%out.print(param);%> required="">
                                    <a href="javascript:" class="weui-icon-clear" id="searchClear"></a>
                                </div>
                                <label class="weui-search-bar__label" id="searchText">
                                    <i class="weui-icon-search"></i>
                                    <span>搜索</span>
                                </label>
                            </form>
                            <a href="javascript:" class="weui-search-bar__cancel-btn" id="searchCancel">取消</a>
                        </div>
                        <%--<div class="page__ft j_bottom">--%>
                            <%--<a href="javascript:home()"><img src="./images/icon_footer_link.png"></a>--%>
                        <%--</div>--%>
                     </div>
                </div>
            </div>
            <br>
                <%
                    if(myTeamList.size()>0){
                        for(int i=0;i<myTeamList.size();i++){
                %>
                <div class="weui-panel__bd">
                    <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                        <label class="weui-cell weui-check__label" for=<%out.print(myTeamList.get(i).getId());%>>
                            <div class="weui-cell__hd" style="position: relative;margin-right: 10px;" onclick="viewTeamPage(this)" id="<%out.print(myTeamList.get(i).getId());%>">
                                <img src="../img/teamHeadImg/<%out.print(myTeamList.get(i).getHeadImg());%>" style="width: 50px;display: block">
                            </div>
                            <div class="weui-cell__bd" onclick="viewTeamPage(this)" id="<%out.print(myTeamList.get(i).getId());%>">
                                <p><%out.print(myTeamList.get(i).getName());%></p>
                                <p style="font-size: 13px;color: #888888;"><%out.print(myTeamList.get(i).getDescription());%></p>
                            </div>
                            <a class="weui-btn weui-btn_mini weui-btn_primary"  style="background-color: #b3d7ff;">我的</a>
                        </label>
                    </div>
                </div>
                <%}
                    }%>
            <%  if(alreadyInTeamList.size()>0){
                for(int i=0;i<alreadyInTeamList.size();i++)
                {%>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(alreadyInTeamList.get(i).getId());%>>
                        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;" onclick="viewTeamPage(this)" id="<%out.print(alreadyInTeamList.get(i).getId());%>">
                            <img src="../img/teamHeadImg/<%out.print(alreadyInTeamList.get(i).getHeadImg());%>" style="width: 50px;display: block">
                        </div>
                        <div class="weui-cell__bd" onclick="viewTeamPage(this)" id="<%out.print(alreadyInTeamList.get(i).getId());%>">
                            <p><%out.print(alreadyInTeamList.get(i).getName());%></p>
                            <p style="font-size: 13px;color: #888888;"><%out.print(alreadyInTeamList.get(i).getDescription());%></p>
                        </div>
                        <a class="weui-btn weui-btn_mini weui-btn_primary"  style="background-color: #e6a23c;">已加入</a>
                    </label>
                </div>
            </div>
            <%}
            } if(appliedList.size()>0){
                for(int i=0;i<appliedList.size();i++){%>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(appliedList.get(i).getId());%>>
                        <div class="weui-cell__hd" style="position: relative;margin-right: 10px;" onclick="viewTeamPage(this)" id="<%out.print(appliedList.get(i).getId());%>">
                            <img src="../img/teamHeadImg/<%out.print(appliedList.get(i).getHeadImg());%>" style="width: 50px;display: block">
                        </div>
                        <div class="weui-cell__bd" onclick="viewTeamPage(this)" id="<%out.print(appliedList.get(i).getId());%>">
                            <p><%out.print(appliedList.get(i).getName());%></p>
                            <p style="font-size: 13px;color: #888888;"><%out.print(appliedList.get(i).getDescription());%></p>
                        </div>
                        <a class="weui-btn weui-btn_mini weui-btn_primary"  style="background-color: #ce3c39;">已申请</a>
                    </label>
                </div>
            </div>
            <%}
            }
                for (int i=0;i<otherTeamList.size();i++) {
            %>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox" style="margin-top:0px;">
                    <label class="weui-cell weui-check__label" for=<%out.print(otherTeamList.get(i).getId());%>>
                        <a class="weui-cell__hd" style="position: relative;margin-right: 10px;" onclick="viewTeamPage(this)" id="<%out.print(otherTeamList.get(i).getId());%>">
                            <img src="../img/teamHeadImg/<%out.print(otherTeamList.get(i).getHeadImg());%>" style="width: 50px;display: block">
                        </a>
                        <div class="weui-cell__bd" onclick="viewTeamPage(this)" id="<%out.print(otherTeamList.get(i).getId());%>">
                            <p><%out.print(otherTeamList.get(i).getName());%></p>
                            <p style="font-size: 13px;color: #888888;">
                                <%if(otherTeamList.get(i).getDescription().length()<=30)
                                    out.print(otherTeamList.get(i).getDescription());
                                  else
                                    out.print(otherTeamList.get(i).getDescription().substring(0,30)+"...");
                                %>
                            </p>
                        </div>
                        <a class="weui-btn weui-btn_mini weui-btn_primary"  onclick="joinToTeam(this)" id=<%out.print(otherTeamList.get(i).getId());%>>加入</a>
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
                showAlert("请选择要加入的团队");
            }
        }
         function goBack() {
             window.location.href="${pageContext.request.contextPath}/user/";
         }
         var $searchBar = $('#searchBar'),
             $searchResult = $('#searchResult'),
             $searchText = $('#searchText'),
             $searchInput = $('#searchInput'),
             $searchClear = $('#searchClear'),
             $searchCancel = $('#searchCancel');

         function hideSearchResult(){
             $searchResult.hide();
             $searchInput.val('');
         }
         function cancelSearch(){
             hideSearchResult();
             $searchBar.removeClass('weui-search-bar_focusing');
             $searchText.show();
         }

         $searchText.on('click', function(){
             $searchBar.addClass('weui-search-bar_focusing');
             $searchInput.focus();
         });
         $searchInput.on('blur', function () {
             if(!this.value.length) cancelSearch();
         })
             .on('input', function(){
                 if(this.value.length) {
                     $searchResult.show();
                 } else {
                     $searchResult.hide();
                 }
             });
         $searchInput.on("change", function(){
             var param=this.value;
             if(param.length){
                 window.location.href="${pageContext.request.contextPath}/team/searchTeam?param="+param;
             }else{
                 window.location.href="${pageContext.request.contextPath}/team/teamList";
             }
         });
         $searchClear.on('click', function(){
             hideSearchResult();
             $searchInput.focus();
         });
         $searchCancel.on('click', function(){
             cancelSearch();
             $searchInput.blur();
         });
         function viewTeamPage(t) {
             var teamId=t.id;
             window.location.href="${pageContext.request.contextPath}/team/teamInfo?teamId="+teamId;
         }
         function keySearch(event) {
             var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
             if (keyCode == 13) {
                 document.getElementById("goSearch").click();
             }
         }
</script>
</html>
