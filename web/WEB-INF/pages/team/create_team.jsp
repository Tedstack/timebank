<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>创建团队</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
</head>
<body>
<div class="weui-cells weui-cells_form" style="margin-top: 0px;">
    <form id="teamDetail" method="post">
    <div class="weui-panel__hd weui-cells__title">
        <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
            <p> 创建团队</p>
        </div>
    </div>
    <div class="weui-cells_form weui-cells">
        <div class="weui-cell" style="margin-left: 130px;">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item weui-flex justify align">
                        <div class="weui-uploader">
                            <div class="weui-uploader__hd">
                                <p class="weui-uploader__title">上传头像</p>
                            </div>
                            <div class="weui-uploader__bd">
                                <ul class="weui-uploader__files" id="files1"></ul>
                                <div class="weui-uploader__input-box">
                                    <input id="file1" name="file1" class="weui-uploader__input" type="file" accept="image/*">
                                </div>
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
            <input class="weui-input" id="team_name" name="team_name" placeholder="输入团队名称" maxlength="10">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">地 点</label></div>
        <div class="weui-cell__bd">
            <div class="weui-cell__bd">
                <textarea id="team_location" class="weui-textarea" name="team_location" placeholder="请输入活动地点..." rows="2" oninput="checkLenLoc(this)"></textarea>
                <div style="float:right; color:#999"><span id="team_location-count">0</span>/20</div>
            </div>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">联系方式</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="content_number" type="number" maxlength="11" pattern="[0-9]*" name="content_number" placeholder="默认注册手机号"/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队介绍</label></div>
        <div class="weui-cell__bd">
            <div class="weui-cell__bd">
                <textarea id="teamDescription" class="weui-textarea" name="describe" placeholder="请输入描述..." rows="3" maxlength="200" oninput="checkLen(this)"></textarea>
                <div style="float:right; color:#999"><span id="description-count">0</span>/200</div>
            </div>
        </div>
    </div>
    <div style="padding: 10px; margin-bottom: 20px;">
        <a href="javascript:;" class="weui-btn weui-btn_primary" id="create" type="button">确定</a>
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
            $uploaderFiles1.empty();
            $uploaderInput1.parent().show();
            $uploaderInput1[0].value='';
        });
        $("#create").on('click', function (){
            var teamName=document.getElementById("team_name").value;
            if(teamName.length>12)
            {
                showAlert("团队名称建议不超过11个字");
                return;
            }
            var contextPath="${pageContext.request.contextPath}";
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/createTeam";
            var formData = new FormData($("#teamDetail")[0]);
            var phone=document.getElementById("content_number").value;
            if(document.getElementById("team_name").value===""){
                showAlert("请填写团队名称");
                return;
            }else if(document.getElementById("team_location").value==="") {
                showAlert("请填写团队主要活动地点");
                return;
            }else if(!isPoneAvailable(phone) && !isTelAvailable(phone)){
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
                        showAlert("创建成功",function () {
                            window.location.href="${pageContext.request.contextPath}/team/myTeams";
                        });
                    }else if(data==="missImg"){
                        showAlert("未上传头像");
                    }else if(data==="nameExist"){
                        showAlert("团队名称已被使用");
                    }else if(data==="hugeImg"){
                        showAlert("上传头像图片大小过大");
                    }else if(data==="failure"){
                        showAlert("创建失败");
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
        if (getLength(obj.value) > 400)
            obj.value = limitMaxLength(obj.value, 400);
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