<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
                                                   placeholder="请输入身份证号" value="<%out.print(user.getIdCard());%>">
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

                                        <button type="submit" style="margin-top: 10px;" class="btn btn-primary btn-block">提交</button>

                                    </div>
                                </div>
                            </div>
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
