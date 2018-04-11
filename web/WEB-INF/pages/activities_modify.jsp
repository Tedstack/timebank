<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.ActivityType" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.TeamEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewTeamUserDetailEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动更改</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<%
    ViewActivityPublishDetailEntity activityPublishDetail = (ViewActivityPublishDetailEntity) request.getAttribute("activityPublishDetail");
    List<TeamEntity> teamList=(List<TeamEntity>) request.getAttribute("teamList");
    List<ViewTeamUserDetailEntity> manageTeamList=(List<ViewTeamUserDetailEntity>)request.getAttribute("manageTeamList");
    String beginTime=(String) request.getAttribute("beiginTime");
    String endTime=(String) request.getAttribute("endTime");
    String applyTime=(String) request.getAttribute("applyTime");
    String currentUser=(String)request.getAttribute("currentUser");
%>
<body onload="checkUser();">
<div class="weui-tab">
    <form id="activityDetail" method="post">
    <div class="weui-tab__panel">
        <div class="weui-panel__hd">
            <div class="weui-flex js_category" id="return">
                <p style="margin-right: 240px;">更改活动</p>
                <a id="delete" style="float: right">删除活动</a>
            </div>
        </div>
        <div class="weui-panel__bd">
            <div class="weui-cells_form weui-cells">
                <div class="weui-cell" style="margin-left: 130px;">
                    <div class="weui-cell__bd">
                        <div class="weui-flex">
                            <div class="weui-flex__item weui-flex justify align">
                                <div class="weui-uploader">
                                    <div class="weui-uploader__hd" style="margin-bottom: 0px;">
                                        <p class="weui-uploader__title" style="margin: 0 0 0 0;">点击更改封面</p>
                                    </div>
                                    <div class="weui-uploader__bd">
                                        <ul class="weui-uploader__files" id="files1" style="margin-bottom: 0px;"></ul>
                                        <a id="changeImg" href="javascript:">
                                            <img src="../img/activityImg/<%out.print(activityPublishDetail.getHeadImg());%>" style="width:90px;height:90px;display: block">
                                        </a>
                                        <div class="weui-uploader__input-box" id="addHeadImg" style="display: none;width:90px;height:90px;">
                                            <input id="file1" name="file1" class="weui-uploader__input" type="file" accept="image/*">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__bh">
                    <label class="weui-label">团队选择</label>
                </div>
                <div class="weui-cell__bd">
                    <select id="teamOptions" class="weui-select" name="teamOptions">
                        <%for(int i=0;i<teamList.size();i++){
                        if(activityPublishDetail.getTeamId()==teamList.get(i).getId()){%>
                        <option value=<%out.print(teamList.get(i).getId());%> selected="selected"><%out.print(teamList.get(i).getName());%></option>
                        <%}else{%>
                        <option value=<%out.print(teamList.get(i).getId());%>><%out.print(teamList.get(i).getName());%></option>
                        <%}
                        }
                        for(int j=0;j<manageTeamList.size();j++){
                        if(manageTeamList.get(j).getTeamId()==activityPublishDetail.getTeamId()){%>
                        <option value=<%out.print(manageTeamList.get(j).getTeamId());%> selected="selected"><%out.print(manageTeamList.get(j).getTeamName());%></option>
                        <%}else{%>
                        <option value=<%out.print(manageTeamList.get(j).getTeamId());%> ><%out.print(manageTeamList.get(j).getTeamName());%></option>
                        <%}
                        }%>
                    </select>
                </div>
            </div>

            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__bh">
                    <label class="weui-label">活动类型</label>
                </div>
                <div class="weui-cell__bd">
                    <select id="activityType" class="weui-select" name="activityType">
                        <%if(activityPublishDetail.getType().equalsIgnoreCase(ActivityType.volunteerActivity)){%>
                        <option value="社区" selected="selected">娱乐活动</option>
                        <option value="志愿者" >志愿服务</option>
                        <%}else{%>
                        <option value="社区">娱乐活动</option>
                        <option value="志愿者" selected="selected">志愿服务</option>
                        <%}%>
                    </select>
                </div>
            </div>
            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__bh">
                    <label class="weui-label">活动对象</label>
                </div>
                <div class="weui-cell__bd">
                    <select id="isPublicOptions" class="weui-select" name="isPublic">
                        <%if(activityPublishDetail.isPublic()){%>
                        <option value="true" selected="selected">对外公开</option>
                        <option value="false">团队成员</option>
                        <%}else{%>
                        <option value="true">对外公开</option>
                        <option value="false" selected="selected">团队成员</option>
                        <%}%>
                    </select>
                </div>
            </div>
            <div class="weui-cell" style="display:none;">
                <div class="weui-cell__bd">
                    <input id="activityId" name="activityId" class="weui-input" type="text" value=<%out.print(activityPublishDetail.getId());%>>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bh">
                    <label class="weui-label">活动名称</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="activityName" name="activityName" class="weui-input" type="text" value=<%out.print(activityPublishDetail.getName());%>>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bh">
                    <label class="weui-label">活动描述</label>
                </div>
                <div class="weui-cell__bd">
                    <div class="weui-cell__bd">
                        <textarea id="description" class="weui-textarea" name="description" rows="3"><%out.print(activityPublishDetail.getDescription());%></textarea>
                        <%--<div class="weui-textarea-counter"><span>0</span>/200</div>--%>
                    </div>
                </div>
            </div>

            <%
                Date nowDate = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                String nowTime = formatter.format(nowDate);
            %>

            <div class="weui-cell">
                <div class="weui-cell__bh">
                    <label class="weui-label">活动开始时间</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="beginTime" class="weui-input" name="beginTime" type="datetime-local" value="<%out.print(beginTime);%>" min="<%out.print(nowTime);%>"/>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bh">
                    <label class="weui-label">活动结束时间</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="endTime" class="weui-input" name="endTime" type="datetime-local" value="<%out.print(endTime);%>" min="<%out.print(nowTime);%>" />
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bh">
                    <label class="weui-label">申请截止时间</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="applyEndTime" name="applyEndTime" class="weui-input" type="datetime-local" value="<%out.print(applyTime);%>"  min="<%out.print(nowTime);%>"/>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bh">
                    <label class="weui-label">参与人数</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="count" class="weui-input" name="count" type="number" pattern="[0-9]*" value=<%out.print(activityPublishDetail.getCount());%>>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bh">
                    <label class="weui-label">活动详细地址</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="address" class="weui-input" name="address" type="text" value=<%out.print(activityPublishDetail.getAddress());%>>
                </div>
            </div>
        </div>
        <div style="padding: 10px; margin-bottom: 20px;">
            <a href="javascript:;" id="submitBtn" class="weui-btn weui-btn_primary">确认修改</a>
        </div>
    </div>
    </form>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script>
    function onBridgeReady() {
        WeixinJSBridge.call('hideOptionMenu');
    }

    if (typeof WeixinJSBridge === "undefined") {
        if (document.addEventListener) {
            document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
        } else if (document.attachEvent) {
            document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
            document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
        }
    } else {
        onBridgeReady();
    }
</script>
<script type="text/javascript">
    function checkUser() {
        var currentUser='<%=currentUser%>';
        var creator='<%=activityPublishDetail.getCreatorId()%>';
        var publisherId='<%=activityPublishDetail.getPublishUserId()%>';
        var actStatus='<%=activityPublishDetail.isDeleted()%>';
        if(currentUser!==creator && currentUser!==publisherId){
            showAlert("无权限修改页面信息");
            $('a').removeAttr('href').removeAttr('id');
        }
        if(actStatus!=='false'){
            showAlert("该活动已经被删除");
            $('a').removeAttr('href').removeAttr('id');
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
    var contextPath="${pageContext.request.contextPath}";

    $(function(){
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#);width: 100px;height: 110px;"></li>',
            $uploaderInput1 = $("#file1"),
            $uploaderFiles1 = $("#files1");
        $uploaderInput1.on("change", function(e){
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }

                $uploaderFiles1.append(tmpl.replace("#url#", src));
                $uploaderInput1.parent().hide();
            }
        });
        $uploaderFiles1.on("click", "li", function(){
            $uploaderFiles1.empty();
            $uploaderInput1.parent().show();
            $uploaderInput1[0].value='';
        });
        $("#changeImg").on('click', function (){
            var pre_Img=document.getElementById("changeImg");
            var add_Img=document.getElementById("addHeadImg");
            pre_Img.style.display="none";
            add_Img.style.display="inline";
        });
        $("#submitBtn").on('click',function () {
            var activityType=$("#activityType ").val();
            var activityName = $('#activityName').val();
            var description = $('#description').val();
            var beginTime = $('#beginTime').val();
            var endTime = $('#endTime').val();
            var applyEndTime = $('#applyEndTime').val();
            var count = $('#count').val();
            var address = $('#address').val();
            var activityId= $('#activityId').val();
            var formData = new FormData($("#activityDetail")[0]);
            if(activityName===""){
                showAlert("请填写活动名称");
                return;
            }

            if(description===""){
                showAlert("请填写活动描述");
                return;
            }

            if(beginTime===""){
                showAlert("请选择活动开始时间");
                return;
            }

            if(endTime===""){
                showAlert("请选择活动结束时间");
                return;
            }
            
            if(applyEndTime===""){
                showAlert("请选择申请加入活动结束时间");
                return;
            }

            if(count===""){
                showAlert("请填写参与人数");
                return;
            }else if(count==="0"){
                showAlert("参与人数不能为0");
                return;
            }

            if(address===""){
                showAlert("请填写活动地址");
                return;
            }

            if(activityType===""){
                showAlert("请循着活动类型");
                return;
            }

            if(beginTime>endTime){
                showAlert("活动结束时间不能早于活动开始时间");
                return;
            }

            if(applyEndTime>endTime){
                showAlert("申请加入活动时间不能晚于活动结束时间");
                return;
            }
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/modifyActivity";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/team/activitiesWaitingForApply";
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: formData,
                async: false,
                contentType: false,// 告诉jQuery不要去设置Content-Type请求头
                processData: false,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="success"){
                        showAlert("修改成功",function () {
                            goTo(targetUrl2);
                        });
                    }else if(data==="hugeImg"){
                        showAlert("请上传一张不大于521k的图片");
                    }else{
                        showAlert("修改失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });
    });

    $(function(){
        $("#delete").on('click', function () {
            var r=confirm("确认删除该活动?");
            if(r==true){
                var contextPath="${pageContext.request.contextPath}";
                var targetUrl = "http://"+getDomainName()+contextPath+"/team/deleteActivity";
                var activityId=<%=activityPublishDetail.getId()%>;
                $.ajax({
                    type: 'POST',
                    cache: false,
                    url: targetUrl,
                    data: "activityId="+activityId,
                    beforeSend: function (XHR) {
                        dialogLoading = showLoading();
                    },
                    success: function (data) {
                        if(data==="success"){
                            showAlert("删除成功",function () {
                                window.location.href="${pageContext.request.contextPath}/team/activitiesWaitingForApply"
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
</body>
</html>
