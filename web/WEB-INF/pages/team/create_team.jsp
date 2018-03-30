<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>创建团队</title>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body onload="checkVerify();">
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
                                <p id="head-intro" class="weui-uploader__title">单击选择个性头像</p>
                            </div>
                            <div class="weui-uploader__bd">
                                <ul class="weui-uploader__files" id="files1"></ul>
                                <a id="changeImg" href="javascript:" style="display:inline;">
                                    <img src="../img/teamHeadImg/team.png" style="width:90px;height:90px;display: block">
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
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队名称</label>
        </div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="team_name" name="team_name" placeholder="输入团队名称" maxlength="10">
        </div>
    </div>
    <div class="weui-cell weui-cell_select weui-cell_select-after">
        <div class="weui-cell__bh">
            <label class="weui-label">活动区域</label>
        </div>
        <div class="weui-cell__bd">
            <select id="team_address" class="weui-select" name="team_address">
                <option value="普陀区">普陀区</option>
                <option value="黄浦区">黄浦区</option>
                <option value="徐汇区">徐汇区</option>
                <option value="长宁区">长宁区</option>
                <option value="静安区">静安区</option>
                <option value="虹口区">虹口区</option>
                <option value="杨浦区">杨浦区</option>
                <option value="宝山区">宝山区</option>
                <option value="闵行区">闵行区</option>
                <option value="嘉定区">嘉定区</option>
                <option value="浦东新区">浦东新区</option>
                <option value="松江区">松江区</option>
                <option value="金山区">金山区</option>
                <option value="青浦区">青浦区</option>
                <option value="奉贤区">奉贤区</option>
                <option value="崇明区">崇明区</option>
                <option value="不限">不限</option>
            </select>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">联系方式</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="content_number" type="number" maxlength="11" pattern="[0-9]*" name="content_number" placeholder="默认为注册手机号"/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <label class="weui-label">团队介绍</label></div>
        <div class="weui-cell__bd">
            <div class="weui-cell__bd">
                <textarea id="teamDescription" class="weui-textarea" name="describe" placeholder="请输入描述..." rows="3" maxlength="400" oninput="checkLen(this)"></textarea>
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
    function checkVerify() {
        var msg='<%=request.getAttribute("msg")%>';
        if(msg==="NoVerified"){
            showAlert("未完成实名认证",function () {
                window.location.href="${pageContext.request.contextPath}/user/startRealNameAuth";
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
        $("#changeImg").on('click', function (){
            var pre_Img=document.getElementById("changeImg");
            var add_Img=document.getElementById("addHeadImg");
            pre_Img.style.display="none";
            add_Img.style.display="inline";
            var obj = document.getElementById("head-intro");
            obj.innerHTML= "请上传头像";
        });
        $("#create").on('click', function (){
            var teamName=document.getElementById("team_name").value;
            var formData = new FormData($("#teamDetail")[0]);
            if(teamName.length>12)
            {
                showAlert("团队名称建议不超过11个字");
                return;
            }
            var contextPath="${pageContext.request.contextPath}";
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/createTeam";
            var phone=document.getElementById("content_number").value;
            if(document.getElementById("team_name").value===""){
                showAlert("请填写团队名称");
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
                    }else if(data==="nameExist"){
                        showAlert("团队名称已被使用");
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
    function isPoneAvailable (pone) {
        var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
        if(pone!=="") {
            return myreg.test(pone);
        }else
            return true;
    }
    function isTelAvailable (tel) {
        var myreg = /^0\d{2,3}-?\d{7,8}$/;
        if(tel!=="") {
            return myreg.test(tel);
        }else
            return true;
    }
</script>
</html>