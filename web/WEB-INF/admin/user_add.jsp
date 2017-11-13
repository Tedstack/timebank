<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>添加用户</title>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/file-input/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="vendor/file-input/themes/explorer-fa/theme.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/sb-admin.css" rel="stylesheet">
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/file-input/js/plugins/sortable.js" type="text/javascript"></script>
    <script src="vendor/file-input/js/fileinput.js" type="text/javascript"></script>
    <script src="vendor/file-input/js/locales/zh.js" type="text/javascript"></script>
    <script src="vendor/file-input/themes/explorer-fa/theme.js" type="text/javascript"></script>
    <script src="vendor/file-input/themes/fa/theme.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
            type="text/javascript"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">
<jsp:include page="navigation.jsp"/>
<div class="content-wrapper">
    <div class="container-fluid">
        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="/admin/index">Dashboard</a>
            </li>
            <li class="breadcrumb-item active">添加用户</li>
        </ol>
        <!-- Area Chart Example-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-user-circle-o"></i> 用户资料
            </div>
            <div class="card-body">
                <%
                    if (request.getAttribute("ok") != null) {
                        out.print("<div class='alert alert-success' role='alert'>"
                                + request.getAttribute("ok") + "</div>");
                    }
                    if (request.getAttribute("error") != null) {
                        out.print("<div class='alert alert-danger' role='alert'>"
                                + request.getAttribute("error") + "</div>");
                    }
                %>

                <form action="/admin/userAddSubmit" method="post">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">基本信息</h4>
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label>姓名</label>
                                            <input class="form-control" type="text" name="name" placeholder="请输入姓名">
                                        </div>
                                        <div class="form-group">
                                            <label>手机号</label>
                                            <input class="form-control" type="text" name="phone" placeholder="请输入手机号">
                                        </div>
                                        <div class="form-group">
                                            <label>身份证号</label>
                                            <input class="form-control" type="text" id="idCard" name="idCard"
                                                   placeholder="请输入身份证号">
                                        </div>
                                        <div class="form-group">
                                            <label>性别</label> <br>
                                            <label class="checkbox-inline">
                                                <input type="radio" name="sex" value="男" checked="checked"> 男
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="radio" name="sex" value="女"> 女
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label>出生年月</label>
                                            <input class="form-control" type="date" id="birth" name="birth"
                                                   placeholder="请输入出生年月">
                                        </div>
                                        <div class="form-group">
                                            <label>卡号</label>
                                            <input class="form-control" type="text" name="QRCode"
                                                   placeholder="请输入要绑定的卡号">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">

                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title"><span><img src="img/实名认证.png"
                                                                      style="height: 40px;">&nbsp;</span>实名认证</h4>
                                    <h6 class="card-subtitle mb-2 text-muted">身份证照片上传</h6>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <img class="img-thumbnail" data-src="holder.js/100px180/?text=Image cap"
                                                     alt="Image cap [100%x180]"
                                                     src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22318%22%20height%3D%22180%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20318%20180%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15f7fafd480%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A16pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15f7fafd480%22%3E%3Crect%20width%3D%22318%22%20height%3D%22180%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22110%22%20y%3D%2297.5%22%3EImage%20cap%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
                                                     data-holder-rendered="true" style="width: 100%;">
                                                <!-- Button trigger modal -->
                                                <button type="button" style="margin-top: 10px;"
                                                        class="btn btn-primary btn-sm btn-block" data-toggle="modal"
                                                        data-target="#fileModal">
                                                    上传正面照片
                                                </button>
                                            </div>

                                            <div class="col-lg-6">
                                                <img class="img-thumbnail" data-src="holder.js/100px180/?text=Image cap"
                                                     alt="Image cap [100%x180]"
                                                     src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22318%22%20height%3D%22180%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20318%20180%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15f7fafd480%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A16pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15f7fafd480%22%3E%3Crect%20width%3D%22318%22%20height%3D%22180%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22110%22%20y%3D%2297.5%22%3EImage%20cap%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
                                                     data-holder-rendered="true" style="width: 100%;">
                                                <button type="button" style="margin-top: 10px;"
                                                        class="btn btn-primary btn-sm btn-block">上传背面照片
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" style="margin-top: 10px;" class="btn btn-primary btn-block">添加</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>


    <!-- Modal -->
    <div class="modal fade" id="fileModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog  modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">上传照片</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container kv-main">
                        <form enctype="multipart/form-data">
                            <div class="file-loading">
                                <input id="kv-explorer" type="file" name="file">
                            </div>
                            <br>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>


</div>


</body>


<script>
    $("#idCard").change(function () {
        var str = $(this).val();
        if (str.length == 18) {
            var t = str.substr(6, 4) + "-" + str.substr(10, 2) + "-" + str.substr(12, 2);
            $("#birth").val(t);

            var sex = str[16];
            if (sex == 1) {
                $("input[name='sex']").eq(0).attr("checked", "checked");
                $("input[name='sex']").eq(1).removeAttr("checked");
                $("input[name='sex']").eq(0).click();
            } else {
                $("input[name='sex']").eq(0).removeAttr("checked");
                $("input[name='sex']").eq(1).attr("checked", "checked");
                $("input[name='sex']").eq(1).click();
            }
        }
    });

</script>

<script>
    $(document).ready(function () {
        $("#kv-explorer").fileinput({
            language: 'zh', //设置语言
            theme: 'explorer-fa',
            allowedPreviewTypes: ['image'],
            allowedFileTypes: ['image'],
            allowedFileExtensions:  ['jpg', 'png'],
            uploadUrl: 'http://127.0.0.1:8080/admin/userUploadPhoto'
//            overwriteInitial: false,
//            initialPreviewAsData: true,
//            initialPreview: [
//                "http://lorempixel.com/1920/1080/nature/1",
//                "http://lorempixel.com/1920/1080/nature/2",
//                "http://lorempixel.com/1920/1080/nature/3"
//            ],
//            initialPreviewConfig: [
//                {caption: "nature-1.jpg", size: 329892, width: "120px", url: "{$url}", key: 1},
//                {caption: "nature-2.jpg", size: 872378, width: "120px", url: "{$url}", key: 2},
//                {caption: "nature-3.jpg", size: 632762, width: "120px", url: "{$url}", key: 3}
//            ]
        });
    });
</script>
</html>