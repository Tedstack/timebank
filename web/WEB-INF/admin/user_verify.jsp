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
    <title>用户详情</title>
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
            <li class="breadcrumb-item active">实名认证审核</li>
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
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">基本信息</h4>
                                <div class="card-body">

                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">姓名：</label>
                                        <label class="col-sm-4 col-form-label"><%out.print(user.getName());%></label>
                                    </div>


                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">手机号：</label>
                                        <label class="col-sm-4 col-form-label"><%out.print(user.getPhone());%></label>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">身份证号：</label>
                                        <label class="col-sm-4 col-form-label"><%out.print(user.getIdCard());%></label>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">性别：</label>
                                        <label class="col-sm-4 col-form-label"><%out.print(user.getSex());%></label>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">出生年月：</label>
                                        <label class="col-sm-4 col-form-label"><%out.print(user.getBirth());%></label>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-sm-2 col-form-label">卡号：</label>
                                        <label class="col-sm-4 col-form-label"><%out.print(user.getQrCode());%></label>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">

                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title"><span><img src="img/实名认证.png" style="height: 40px;">&nbsp;</span>实名认证
                                </h4>
                                <h6 class="card-subtitle mb-2 text-muted">身份证照片</h6>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <%
                                                if (user.getImg1() != null && user.getImg1().length() > 0) {
                                                    out.print("<img class='img-thumbnail' id='img1' style='width: 100%;' src='/img/profile/" + user.getImg1() + "'>");
                                                } else {
                                                    out.print("<img class='img-thumbnail' id='img1' style='width: 100%;' src='/img/空白身份证.jpg'>");
                                                }
                                            %>
                                        </div>

                                        <div class="col-lg-6">
                                            <%
                                                if (user.getImg2() != null && user.getImg2().length() > 0) {
                                                    out.print("<img class='img-thumbnail' id='img2' style='width: 100%;' src='/img/profile/" + user.getImg2() + "'>");
                                                } else {
                                                    out.print("<img class='img-thumbnail' id='img2' style='width: 100%;' src='/img/空白身份证.jpg'>");
                                                }
                                            %>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <form action="/admin/userVerifySubmit" method="post">

                    <input type="hidden" name="userId" value="<%=user.getId()%>">

                    <fieldset class="form-group">
                        <div class="row">
                            <legend class="col-form-legend col-sm-1">审核</legend>
                            <div class="col-sm-4">
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio" name="isVerify" value="0"
                                               checked>不通过
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio" name="isVerify" value="1">通过
                                    </label>
                                </div>
                            </div>
                        </div>
                    </fieldset>

                    <div class="form-group row">
                        <div class="col-sm-6">
                            <button type="submit" class="btn btn-primary btn-block">提交</button>
                        </div>
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
