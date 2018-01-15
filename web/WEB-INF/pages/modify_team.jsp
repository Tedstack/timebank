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
        <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
            <p><img src="../img/back.png" width="20" height="15"alt="">修改团队信息</p>
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
                                <a id="changeImg" href="javascript:">
                                    <img src="../img/teamHeadImg/<%out.print(team.getHeadImg());%>" style="width:100px;display: block">
                                </a>
                                <div class="weui-uploader__input-box" id="addHeadImg" style="display: none;">
                                    <input id="file1" name="file1" class="weui-uploader__input" type="file" accept="image/*">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="weui-cell" style="display:none;">
        <div class="weui-cell__hd">
            <label class="weui-label">团队编号</label>
        </div>
        <div class="weui-cell__bd">
            <input readonly class="weui-input" name="team_id" value=<%out.print(team.getId());%>>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队名称</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" name="team_name" value=<%out.print(team.getName());%>>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">地点</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="team_location" name="team_location" value=<%out.print(team.getAddress());%>>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">团队介绍</label></div>
    </div>
    <div style="text-align:center;">
        <textarea name="describe" rows="10" cols="30" maxlength=200 style="width:250px; height:180px; border:solid 1px #4d4d4d;resize:none; font-size: 16px; padding:3px;border-radius: 1px;"><%out.print(team.getDescription());%></textarea>
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
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
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
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $("#modifyTeam").on('click', function (){
            var contextPath="${pageContext.request.contextPath}";
            var targetUrl = "http://"+location.host+"/timebank/team/modifyTeam";
            var formData = new FormData($("#teamDetail")[0]);
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
                            window.location.href="${pageContext.request.contextPath}/team/myTeams"
                        });
                    }
                    if(data==="nameExist"){
                        showAlert("该名已被使用");
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
</script>
</html>