<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>实名认证</title>
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
        <div class="page__bd" >
            <div class="weui-gallery" id="gallery" style="opacity: 1; display: none;">
                <span class="weui-gallery__img" id="galleryImg" style="background-image:url(.)"></span>
                <%--<div class="weui-gallery__opr">--%>
                    <%--<a href="javascript:" class="weui-gallery__del">--%>
                        <%--<i class="weui-icon-delete weui-icon_gallery-delete"></i>--%>
                    <%--</a>--%>
                <%--</div>--%>
            </div>
            <form class="weui-cells weui-cells_form" id="userForm" method="post" action="uploadUserInfo">

                <div class="weui-cells__title">
                    <p>身份证照片</p>
                </div>
                <div class="weui-cells_form weui-cells">
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item weui-flex justify align">
                                    <div class="weui-uploader">
                                        <div class="weui-uploader__hd">
                                            <p class="weui-uploader__title">身份证正面</p>
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
                                            <p class="weui-uploader__title">身份证背面</p>
                                        </div>
                                        <div class="weui-uploader__bd">
                                            <ul class="weui-uploader__files" id="files2"></ul>
                                            <div class="weui-uploader__input-box">
                                                <input id="file2" name="file2" class="weui-uploader__input" type="file" accept="image/*">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="weui-cells__title">
                    <p>身份证号码</p>
                </div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <input class="weui-input" id="ID" name="idNum" pattern="^([0-9]){7,18}(x|X)?$" placeholder="请输入身份证号">
                        </div>
                    </div>
                </div>
                <div class="weui-btn-area">
                    <a class="weui-btn weui-btn_primary" id="button1" type="button" href="javascript:;">提交审核</a>
                </div>
            </form>

            <article class="weui-article">
                <section>
                    <h2 class="title">示例图片</h2>
                    <div class="weui-flex">
                        <div class="weui-flex__item">
                            <img src="../img/idCardExample/cardExampleFront.png" width="100%" id="exampleFront"/>
                        </div>
                        <div class="weui-flex__item">
                            <img src="../img/idCardExample/cardExampleNegative.png" width="100%" id="exampleNegative"/>
                        </div>

                    </div>
                    <h2 class="title">注意事项</h2>
                    <section>
                        <p>
                            1. 照片必须清晰，且含有完整身份证。<br/>
                            2. 所填写证件号码必须与上传的照片一致。<br/>
                            3. 上传的照片必须是原始的，不得使用任何软件修改。
                        </p>
                    </section>
                </section>
            </article>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
            $gallery = $("#gallery"), $galleryImg = $("#galleryImg"),
            $uploaderInput1 = $("#file1"),
            $uploaderInput2 = $("#file2"),
            $uploaderFiles1 = $("#files1"),
            $uploaderFiles2 = $("#files2")
        ;

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
        $uploaderInput2.on("change", function(e){
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

        $uploaderFiles1.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $uploaderFiles2.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $gallery.on("click", function(){
            $gallery.fadeOut(100);
        });

        $("#exampleFront").on("click", function () {
            $galleryImg.css("background-image", "url(../img/idCardExample/cardExampleFront.png)");
            $gallery.fadeIn(100);
        });
        $("#exampleNegative").on("click", function () {
            $galleryImg.css("background-image", "url(../img/idCardExample/cardExampleNegative.png)");
            $gallery.fadeIn(100);
        });
    });
    $(function() {
        $("#button1").on('click', function () {
            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            var idnum=jQuery("input[id='ID']").val();
            if(jQuery("input[id='file1']").val()!==""){
                //未选择文件
                if(jQuery("input[id='file2']").val()!==""){
                    if(idnum!==""){
                        //进行身份证合法性验证
                        if(reg.test(idnum)){
                            post();
                        }
                        else{
                            showAlert("身份证号输入错误，请确定是否正确输入！");
                        }

                    }
                    else{
                        showAlert("请输入身份证号！");
                    }
                }
                else{
                    showAlert("请上传身份证背面照片！");
                }
            }
            else{
                showAlert("请上传身份证照片！");
            }
        });
        function post(){
            var baseUrl = "http://" + location.host,
                uploadUrl = baseUrl + "/timebank/user/uploadUserInfo",
                notiUrl = baseUrl + "/timebank/user/realnameNotification";
            var formData = new FormData($("#userForm")[0]);
            console.log(formData.getAll("ID"));
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