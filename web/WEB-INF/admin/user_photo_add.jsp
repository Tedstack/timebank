<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <title>添加用户</title>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/file-input/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all"
          rel="stylesheet" type="text/css"/>
    <link href="vendor/file-input/themes/explorer-fa/theme.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/sb-admin.css" rel="stylesheet">
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/file-input/js/plugins/sortable.js" type="text/javascript"></script>
    <script src="vendor/file-input/js/fileinput.js" type="text/javascript"></script>
    <script src="vendor/file-input/js/locales/zh.js" type="text/javascript"></script>
    <script src="vendor/file-input/themes/explorer-fa/theme.js" type="text/javascript"></script>
    <script src="vendor/file-input/themes/fa/theme.js" type="text/javascript"></script>
    <script src="vendor/file-input/js/plugins/popper.min.js" type="text/javascript"></script>
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

        <div class="row">
            <div class="col-lg-6">
                <div class="card mb-3">

                    <div class="card-header">
                        <span><img src="img/实名认证.png" style="height: 40px;">&nbsp;</span>实名认证
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
                            UserEntity user = (UserEntity) request.getAttribute("user");
                        %>

                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">姓名：</label>
                            <input type="text" readonly class="form-control-plaintext" id="name" value="<%out.print(user.getName());%>">
                        </div>

                        <div class="form-group row">
                            <label class="col-sm-2 col-form-label">身份证号：</label>
                            <input type="text" readonly class="form-control-plaintext" id="idCard" value="<%out.print(user.getIdCard());%>">
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <img class="img-thumbnail" data-src="holder.js/100px180/?text=未上传"
                                     alt="Image cap [100%x180]" id="img1"
                                     src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22318%22%20height%3D%22180%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20318%20180%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15f7fafd480%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A16pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15f7fafd480%22%3E%3Crect%20width%3D%22318%22%20height%3D%22180%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22110%22%20y%3D%2297.5%22%3EImage%20cap%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
                                     data-holder-rendered="true" style="width: 100%;">
                                <button type="button" style="margin-top: 10px;"
                                        id="btn_img1" class="btn btn-primary btn-sm btn-block">
                                    上传正面照片
                                </button>
                            </div>

                            <div class="col-lg-6">
                                <img class="img-thumbnail" data-src="holder.js/100px180/?text=未上传"
                                     alt="Image cap [100%x180]" id="img2"
                                     src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22318%22%20height%3D%22180%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20318%20180%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15f7fafd480%20text%20%7B%20fill%3Argba(255%2C255%2C255%2C.75)%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A16pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15f7fafd480%22%3E%3Crect%20width%3D%22318%22%20height%3D%22180%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22110%22%20y%3D%2297.5%22%3EImage%20cap%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"
                                     data-holder-rendered="true" style="width: 100%;">
                                <button type="button" style="margin-top: 10px;"
                                        id="btn_img2" class="btn btn-primary btn-sm btn-block">上传背面照片
                                </button>
                            </div>
                        </div>
                    </div>


                </div>


            </div>
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
                <input id="input_img" type="hidden">
                <div class="container kv-main">
                    <form enctype="multipart/form-data">
                        <div class="file-loading">
                            <input id="input_file" type="file" name="file">
                        </div>
                        <br>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>


</div>


</body>


<script>

    $(document).ready(function () {
        var str = $("#idCard").val();
        if (str.length == 18) {
            $("#btn_img1").show();
            $("#btn_img2").show();
        }
        else {
            $("#btn_img1").hide();
            $("#btn_img2").hide();
        }

        $("#input_file").fileinput({
            language: 'zh', //设置语言
            theme: 'explorer-fa',
            uploadAsync: true, //默认异步上传
            allowedPreviewTypes: ['image'],
            allowedFileTypes: ['image'],
            allowedFileExtensions: ['jpg', 'png'],
            maxFileSize: 2014 * 1000, //单位为kb，如果为0表示不限制文件大小
            uploadUrl: '/admin/userUploadPhoto'
        }).on("fileuploaded", function (event, data, previewId, index) {
            if ($("#input_img").val() == 1) $("#img1").attr("src", data.response.url + "?time=" + new Date().getTime());//每次随机一个参数保证图片实时更新
            else $("#img2").attr("src", data.response.url + "?time=" + new Date().getTime());
        });

        $("#btn_img1").click(function () {
            $("#input_img").val("1");
            refresh();
        });

        $("#btn_img2").click(function () {
            $("#input_img").val(2);
            refresh();
        });

    });

    function refresh() {
        $("#input_file").fileinput('clear');
        $("#input_file").fileinput('refresh', {
            uploadExtraData: {
                idCard: $("#idCard").val(),
                img: $("#input_img").val()
            }
        });
        $('#fileModal').modal('show');
    }

</script>
</html>