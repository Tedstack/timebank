<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>编辑用户</title>
    <!-- Bootstrap core CSS-->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template-->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet">
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
            <li class="breadcrumb-item active">编辑用户</li>
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
                    UserEntity user = (UserEntity) request.getAttribute("user");
                %>

                <form action="/admin/userEditSubmit" method="post">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title">基本信息</h4>
                                    <div class="card-body">
                                        <input type="hidden" value="<%=user.getId()%>" name="userId">
                                        <div class="form-group">
                                            <label>姓名</label>
                                            <input class="form-control" type="text" name="name" placeholder="请输入姓名"
                                                   value="<%out.print(user.getName());%>">
                                        </div>
                                        <div class="form-group">
                                            <label>手机号</label>
                                            <input class="form-control" type="text" name="phone" placeholder="请输入手机号"
                                                   value="<%out.print(user.getPhone());%>">
                                        </div>
                                        <div class="form-group">
                                            <label>身份证号</label>
                                            <input class="form-control" type="text" id="idCard" name="idCard"
                                                   placeholder="请输入身份证号"
                                                   value="<%out.print(user.getIdCard());%>">
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
                                                   placeholder="请输入出生年月" value="<%out.print(user.getBirth());%>">
                                        </div>
                                        <div class="form-group">
                                            <label>卡号</label>
                                            <input class="form-control" type="text" name="QRCode"
                                                   placeholder="请输入要绑定的卡号" value="<%out.print(user.getQrCode());%>">
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
                                                <button type="button" style="margin-top: 10px;"
                                                        class="btn btn-primary btn-sm btn-block">上传正面照片
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
                        <button type="submit" style="margin-top: 10px;" class="btn btn-primary btn-block">提交</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>

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

</div>
</body>

</html>
