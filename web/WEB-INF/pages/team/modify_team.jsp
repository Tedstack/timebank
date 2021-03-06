<%@ page import="com.blockchain.timebank.entity.TeamEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: weiyi
  Date: 2017/12/24
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <meta charset="UTF-8" />
    <meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>修改信息</title>
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
    List<String> areaList = Arrays.asList("普陀区","黄浦区","徐汇区","长宁区","静安区","虹口区","杨浦区","宝山区","闵行区","嘉定区","浦东新区","松江区","金山区","青浦区","奉贤区","崇明区","不限");
%>
<body onload="checkUser();">
<div class="weui-cells weui-cells_form" style="margin-top: 0px;">
    <form id="teamDetail" method="post">
    <div class="weui-panel__hd weui-cells__title">
        <div class="weui-flex__item">
            <p> 修改团队信息</p>
        </div>
    </div>
    <div class="weui-cells_form weui-cells">
        <div class="weui-cell" style="margin-left: 130px;">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item weui-flex justify align">
                        <div class="weui-uploader">
                            <div class="weui-uploader__hd">
                                <p class="weui-uploader__title">点击更改头像</p>
                            </div>
                            <div class="weui-uploader__bd">
                                <ul class="weui-uploader__files" id="files1"></ul>
                                <a id="changeImg" href="javascript:" style="display:inline;">
                                    <img src="../img/teamHeadImg/<%out.print(team.getHeadImg());%>" style="width:90px;height:90px;display: block">
                                </a>
                                <div class="weui-uploader__input-box" id="addHeadImg" style="width:90px;height:90px;display: none;">
                                    <input id="file1" name="file1" class="weui-uploader__input" type="file" accept="image/*">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <div class="weui-cell" style="display: none">
            <div class="weui-cell__hd">
                <label class="weui-label">团队名称</label>
            </div>
            <div class="weui-cell__bd">
                <input class="weui-input" maxlength="11" name="team_id" value=<%out.print(team.getId());%>>
            </div>
        </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队名称</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="team_name" name="team_name" value=<%out.print(team.getName());%>>
        </div>
    </div>
    <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__bh">
            <label class="weui-label">活动区域</label>
        </div>
        <div class="weui-cell__bd">
            <select id="team_address" class="weui-select" name="team_address">
                <%for(int i=0;i<areaList.size();i++){
                   if(areaList.get(i).equalsIgnoreCase(team.getAddress())){%>
                       <option selected="selected" value="<%out.print(areaList.get(i));%>"><%out.print(areaList.get(i));%></option>
                   <%}else{%>
                       <option value="<%out.print(areaList.get(i));%>"><%out.print(areaList.get(i));%></option>
                  <%}
                }%>
            </select>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">联系方式</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="team_phone" name="team_phone" value=<%out.print(team.getPhone());%>>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队介绍</label></div>
        <div class="weui-cell__bd">
            <div class="weui-cell__bd">
                <textarea id="teamDescription" class="weui-textarea" name="describe" rows="3" maxlength="400" oninput="checkLen(this)"><%out.print(team.getDescription());%></textarea>
                <div style="float:right; color:#999"><span id="description-count"><%out.print(team.getDescription().length());%></span>/200</div>
            </div>
        </div>
    </div>
    <div style="padding: 10px; margin-top: 10px;">
        <a href="javascript:;" class="weui-btn weui-btn_primary" id="modifyTeam" type="button">确认修改</a>
    </div>
    </form>
</div>
</body>
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
        var creator='<%=team.getCreatorId()%>';
        var teamStatus='<%=team.isDeleted()%>';
        if(currentUser!==creator){
            showAlert("非创建者无修改页面信息权限");
            $('a').removeAttr('href').removeAttr('id');
        }
        if(teamStatus!=='false'){
            showAlert("该团队已经被删除");
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
    $(function(){
        var tmpl = '<li class="weui-uploader__file" style="width:90px;height:90px;background-image:url(#url#)"></li>',
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
        $uploaderFiles1.on("click","li",function () {
            $uploaderFiles1.empty();
            $uploaderInput1.parent().show();
            $uploaderInput1[0].value='';
        });
        $("#modifyTeam").on('click', function (){
            var contextPath="${pageContext.request.contextPath}";
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/modifyTeam";
            var formData = new FormData($("#teamDetail")[0]);
            if(document.getElementById("team_name").value===""){
                showAlert("请填写团队名称");
                return;
            }else if(document.getElementById("team_name").value.length>12){
                showAlert("团队名称建议不超过11个字");
                return;
            }else if(!isPoneAvailable(document.getElementById("team_phone").value) && !isTelAvailable(document.getElementById("team_phone").value)){
                showAlert("请输入正确的手机号");
                return;
            }
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: formData,
                async: false,
                contentType: false,
                processData: false,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="success"){
                        showAlert("修改成功",function () {
                            window.location.href="${pageContext.request.contextPath}/team/myTeams"
                        });
                    }
                    if(data==="hugeImg"){
                        showAlert("上传头像图片大小过大");
                    }
                    if(data==="nameExist"){
                        showAlert("该名已被使用");
                    }
                    if(data==="longName"){
                        showAlert("团队名称建议不超过11个字");
                    }
                    if(data==="failure"){
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
        $("#changeImg").on('click', function (){
            var pre_Img=document.getElementById("changeImg");
            var add_Img=document.getElementById("addHeadImg");
            pre_Img.style.display="none";
            add_Img.style.display="inline";
        });
    });
    function getLength(str) {
        return str.replace(/[^ -~]/g, 'AA').length;
    }

    function limitMaxLength(str, maxLength) {
        var result = [];
        for (var i = 0; i < maxLength; i++) {
            var char = str[i]
            if (/[^ -~]/.test(char))
                maxLength--;
            result.push(char);
        }
        return result.join('');
    }
    function checkLen(obj)
    {
        if (getLength(obj.value) > 400)
            obj.value = limitMaxLength(obj.value, 400);
        document.getElementById("description-count").innerHTML = Math.ceil(getLength(obj.value)/2).toString();
    }
    function checkLenLoc(obj)
    {
        if (getLength(obj.value) > 40)
            obj.value = limitMaxLength(obj.value, 40);
        document.getElementById("team_location-count").innerHTML = Math.ceil(getLength(obj.value)/2).toString();
    }
    function isPoneAvailable (pone) {
        var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
        if (!myreg.test(pone)) {
            return false;
        } else {
            return true;
        }
    }
    function isTelAvailable (tel) {
        var myreg = /^0\d{2,3}-?\d{7,8}$/;
        if (!myreg.test(tel)) {
            return false;
        } else {
            return true;
        }
    }
</script>
</html>