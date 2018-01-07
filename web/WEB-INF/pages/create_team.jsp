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
<div class="weui-cells weui-cells_form">
    <form id="teamDetail" method="post">
    <div class="weui-cells__title">
        <p>团队头像</p>
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
            <input class="weui-input" id="team_name" name="team_name" placeholder="输入团队名称">
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">地点</label></div>
        <div class="weui-cell__bd">
            <input class="weui-input" id="team_location" name="team_location" placeholder="输入团队主要活动地点"/>
        </div>
    </div>
    <div class="weui-cell">
        <div class="weui-cell__hd"><label class="weui-label">团队介绍</label></div>
        <div class="weui-cell__hd"><label class="weui-label" style="color: grey;">200字以内</label></div>
    </div>
    <div style="text-align:center;">
        <textarea id="describe" name="describe" rows="10" cols="30" placeholder=".... " maxlength=200 style="width:250px; height:180px; border:solid 1px #4d4d4d;resize:none; font-size: 16px; padding:3px;border-radius: 1px;"></textarea>
    </div>
    <div style="padding: 10px; margin-bottom: 20px;">
        <a href="javascript:;" class="weui-btn weui-btn_primary" id="create" type="button">确定</a>
    </div>
    </form>
</div>

</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
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
        $("#create").on('click', function () {
            var contextPath="${pageContext.request.contextPath}"
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/createTeam";
            var formData = new FormData($("#teamDetail")[0]);
            if(document.getElementById("team_name").value===""){
                showAlert("请填写团体名称");}
            else if(document.getElementById("team_location").value===""){
                showAlert("请填写团体主要活动地点");
            }else{
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
                        showAlert("创建成功",function () {
                            window.location.href="${pageContext.request.contextPath}/team/myTeams"
                        });
                    }else if(data==="nameExist") {
                        showAlert("团队名称已被使用");
                    }else if(data==="failure"){
                        showAlert("创建失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("创建失败");
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