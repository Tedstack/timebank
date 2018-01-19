<%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 26/12/2017
  Time: 10:51
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>专业技能认证</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <style>
        .justify{
            justify-content: center;
        }
        .align{
            align-items: center;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page input js_show">
        <div class="page__bd">
            <div class="weui-gallery" id="gallery" style="opacity: 1; display: none;">
                <span class="weui-gallery__img" id="galleryImg" style="background-image:url(.)"></span>
                <%--<div class="weui-gallery__opr">--%>
                <%--<a href="javascript:" class="weui-gallery__del">--%>
                <%--<i class="weui-icon-delete weui-icon_gallery-delete"></i>--%>
                <%--</a>--%>
                <%--</div>--%>
            </div>
            <form id="userForm" class="weui-cells weui-cells_form">
                <div class="weui-cells__title">
                    <p>证书信息</p>
                </div>
                <div class="weui-cells">
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <lable class="weui-label">证书名称</lable>
                        </div>
                        <div class="weui-cell__bd">
                            <input id="techName" name="techName" class="weui-input" maxlength="40" placeholder="请输入专业技能证书名称">
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <lable class="weui-label">证书等级</lable>
                        </div>
                        <div class="weui-cell__bd">
                            <input id="techLevel" name="techLevel" class="weui-input" maxlength="20" placeholder="请输入专业技能证书等级">
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd">
                            <label class="weui-label">证书编号</label>
                        </div>
                        <div class="weui-cell__bd">
                            <input id="techId" name="techId" class="weui-input" maxlength="20" placeholder="请输入专业技能证书编号">
                        </div>
                    </div>
                </div>
                <div class="weui-cells__title">
                    <p>证书照片(至少上传1张个人页，长按可删除)</p>
                </div>
                <div class="weui-cells">
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item weui-flex justify align">
                                    <div class="weui-uploader">
                                        <div class="weui-uploader__hd">
                                            <p class="weui-uploader__title">证书封面</p>
                                        </div>
                                        <div class="weui-uploader__bd">
                                            <ul class="weui-uploader__files" id="files1"></ul>
                                            <div class="weui-uploader__input-box">
                                                <input id="file1" name="file1" class="weui-uploader__input" type="file" accept="image/*">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="weui-flex__item weui-flex justify align">
                                    <div class="weui-uploader">
                                        <div class="weui-uploader__hd">
                                            <p class="weui-uploader__title">证书第一页</p>
                                        </div>
                                        <div class="weui-uploader__bd">
                                            <ul class="weui-uploader__files" id="files2"></ul>
                                            <div class="weui-uploader__input-box">
                                                <input id="file2" name="file2" class="weui-uploader__input" type="file" accept="image/*">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="weui-flex__item weui-flex justify align">
                                    <div class="weui-uploader">
                                        <div class="weui-uploader__hd">
                                            <p class="weui-uploader__title">证书个人页</p>
                                        </div>
                                        <div class="weui-uploader__bd">
                                            <ul class="weui-uploader__files" id="files3"></ul>
                                            <div class="weui-uploader__input-box">
                                                <input id="file3" name="file3" class="weui-uploader__input" type="file" accept="image/*">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="weui-btn-area">
                <a class="weui-btn weui-btn_primary" id="button1" type="button" href="javascript:;" >提交审核</a>
            </div>
            <article class="weui-article">
                <section>
                    <h2 class="title">示例图片</h2>
                    <div class="weui-flex">
                        <div class="weui-flex__item">
                            <img id="techExample1" src="../img/techExample/f1.jpg" width="95%"/>
                        </div>
                        <div class="weui-flex__item">
                            <img id="techExample2" src="../img/techExample/f2.jpg" width="95%"/>
                        </div>
                        <div class="weui-flex__item">
                            <img id="techExample3" src="../img/techExample/f3.jpg" width="95%"/>
                        </div>
                    </div>
                    <h2 class="title">注意事项</h2>
                    <section>
                        <p>
                            1. 照片必须清晰。照片大小不得大于5MB。<br/>
                            2. 所填写证件名称、证书等级、证书编号必须与上传的照片一致。<br/>
                            3. 证书持有者必须是用户本人。<br/>
                            4. 上传的照片必须是原始的，不得使用任何软件修改。
                        </p>
                    </section>
                </section>
            </article>
        </div>
    </div>
</div>
<script type="text/javascript">
    $.fn.longPress = function(fn) {
        var timeout = undefined;
        var $this = this;
        for(var i = 0;i<$this.length;i++){
            $this[i].addEventListener('touchstart', function(event) {
                timeout = setTimeout(fn, 500);  //长按时间超过800ms，则执行传入的方法
            }, false);
            $this[i].addEventListener('touchend', function(event) {
                clearTimeout(timeout);  //长按时间少于800ms，不会执行传入的方法
            }, false);
        }
    };
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
            $gallery = $("#gallery"), $galleryImg = $("#galleryImg"),
            $uploaderInput1 = $("#file1"),
            $uploaderInput2 = $("#file2"),
            $uploaderInput3 = $("#file3"),
            $uploaderFiles1 = $("#files1"),
            $uploaderFiles2 = $("#files2"),
            $uploaderFiles3 = $("#files3")
        ;

        $uploaderInput1.on("change", function(e){
            if ($uploaderInput1[0].files.length <= 0) return;

            if ($uploaderInput1[0].files[0].size > 1024*1024*5) {
                $uploaderInput1[0].value='';
                alert('图片过大请重新选择');
                return;
            }
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
        $uploaderInput2.on("change", function(e){
            if ($uploaderInput2[0].files.length <= 0) return;

            if ($uploaderInput2[0].files[0].size > 1024*1024*5) {
                $uploaderInput2[0].value='';
                alert('图片过大请重新选择');
                return;
            }
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }

                $uploaderFiles2.append(tmpl.replace("#url#", src));
                $uploaderInput2.parent().hide();

            }
        });

        $uploaderInput3.on("change", function(e){
            if ($uploaderInput3[0].files.length <= 0) return;

            if ($uploaderInput3[0].files[0].size > 1024*1024*5) {
                $uploaderInput3[0].value='';
                alert('图片过大请重新选择');
                return;
            }
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }

                $uploaderFiles3.append(tmpl.replace("#url#", src));
                $uploaderInput3.parent().hide();

            }
        });

        $uploaderFiles1.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $uploaderFiles1.longPress(function () {
            $uploaderFiles1.empty();
            $uploaderInput1.parent().show();
            $uploaderInput1[0].value='';
        });
        $uploaderFiles2.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $uploaderFiles2.longPress(function () {
            $uploaderFiles2.empty();
            $uploaderInput2.parent().show();
            $uploaderInput2[0].value='';
        });
        $uploaderFiles3.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $uploaderFiles3.longPress(function () {
            $uploaderFiles3.empty();
            $uploaderInput3.parent().show();
            $uploaderInput3[0].value='';
        });
        $gallery.on("click", function(){
            $gallery.fadeOut(100);
        });

        $("#techExample1").on("click", function () {
            $galleryImg.css("background-image", "url(../img/techExample/f1.jpg)");
            $gallery.fadeIn(100);
        });
        $("#techExample2").on("click", function () {
            $galleryImg.css("background-image", "url(../img/techExample/f2.jpg)");
            $gallery.fadeIn(100);
        });
        $("#techExample3").on("click", function () {
            $galleryImg.css("background-image", "url(../img/techExample/f3.jpg)");
            $gallery.fadeIn(100);
        });
    });
    $(function() {
        $("#button1").on('click', function () {
            if (jQuery("input[id='file3']").val() !== "") {
                if ($('#techName').val() !== "" && $('#techId').val() !== "" && $('#techLevel').val() !== "") {
                    //进行身份证合法性验证
                    post()
                }
                else {
                    showAlert("请输入完整信息！");
                }
            }
            else {
                showAlert("请上传个人页！");
            }
        });

        function post(){
            var baseUrl = "http://" + location.host,
                uploadUrl = baseUrl + "/timebanktest/user/uploadTechInfo",
                notiUrl = baseUrl + "/timebanktest/user/techNotification";
            var formData = new FormData($("#userForm")[0]);
            $.ajax({
                url: uploadUrl,
                type: 'POST',
                data: formData,
                async: false,
                cache: false,
                contentType: false,// 告诉jQuery不要去设置Content-Type请求头
                processData: false,// 告诉jQuery不要去处理发送的数据
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data=="upload success")
                    {
                        location.href=notiUrl;
                    }
                    //...
                },
                error: function (data) {
                    if(data=="failure")
                    {
                        showAlert("很抱歉，上传信息失败，请稍后尝试！");
                    }
                    //...
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
            return false;
        }
    });
</script>

</body>
</html>