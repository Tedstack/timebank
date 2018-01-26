<%@ page import="com.blockchain.timebank.entity.TeamEntity" %>
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
<body>
<%
    TeamEntity team=(TeamEntity)request.getAttribute("teamEntity");
%>
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
                <input class="weui-input" name="team_id" value=<%out.print(team.getId());%>>
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
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">地点</label></div>
        <div class="weui-cell__bd">
            <textarea id="team_location" class="weui-textarea" name="team_location" placeholder="请输入活动地点..." rows="2" onkeyup="checkLenLoc(this)"><%out.print(team.getAddress());%></textarea>
            <div style="float:right; color:#999"><span id="team_location-count"><%out.print(team.getAddress().length());%></span>/20</div>
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
                <textarea id="teamDescription" class="weui-textarea" name="describe" rows="3" onkeyup="checkLen(this)"><%out.print(team.getDescription());%></textarea>
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
<script type="text/javascript">
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
            }else if(document.getElementById("team_name").length>12){
                showAlert("团队名称建议不超过11个字");
                return;
            }else if(!isPoneAvailable(document.getElementById("team_phone").value) && !isTelAvailable(document.getElementById("team_phone").value)){
                showAlert("请输入正确的手机号");
                return;
            }else if(document.getElementById("team_location").value==="") {
                showAlert("请填写团队主要活动地点");
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
    function checkLen(obj)
    {
        var maxChars = 200;//最多字符数
        if (obj.value.length > maxChars)
            obj.value = obj.value.substring(0,maxChars);
        var curr = obj.value.length;
        document.getElementById("description-count").innerHTML = curr.toString();
    }
    function checkLenLoc(obj)
    {
        var maxChars = 20;//最多字符数
        if (obj.value.length > maxChars)
            obj.value = obj.value.substring(0,maxChars);
        var curr = obj.value.length;
        document.getElementById("team_location-count").innerHTML = curr.toString();
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