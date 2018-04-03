<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>添加服务种类</title>
    <!-- Bootstrap core CSS-->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom fonts for this template-->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Page level plugin CSS-->
    <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet">
</head>

<body class="fixed-nav sticky-footer bg-dark" id="page-top">

<!-- Navigation-->
<jsp:include page="navigation.jsp"/>
<div class="content-wrapper">
    <div class="container-fluid">
        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/admin/index">Dashboard</a>
            </li>
            <li class="breadcrumb-item active">添加服务</li>
        </ol>

        <!-- Example Bar Chart Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i> 添加服务种类
            </div>
            <div class="card-body">

                <form action="${pageContext.request.contextPath}/admin/serviceAddSubmit" method="post">
                    <%
                        if (request.getAttribute("ok") != null) {
                            out.print("<div class='alert alert-success' role='alert'>"
                                    + request.getAttribute("ok") + "</div>");
                        }
                        if (request.getAttribute("error") != null) {
                            out.print("<div class='alert alert-danger' role='alert'>"
                                    + request.getAttribute("error") + "</div>");
                        }

                        List<String> types = (List<String>) request.getAttribute("types");
                    %>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务类型</label>
                        <div class="col-sm-2">
                            <select name="type" id="service_type" class="form-control">
                                <%
                                    for (String type : types) {
                                        out.print("<option value='" + type + "'>" + type + "</option>");
                                    }
                                %>
                                <option value="自定义">自定义</option>
                            </select>
                        </div>
                        <div class="col-sm-2" id="type_detail">
                            <input class="form-control" type="text" name="type_detail" placeholder="请输入自定义名称">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务名称</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="text" name="name" placeholder="请输入名称">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务推荐价格</label>
                        <div class="col-sm-2">
                            <input class="form-control" type="number" name="price" placeholder="请输入价格" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务收费方式</label>
                        <div class="col-sm-2">
                            <select name="price_type" id="price_type" class="form-control">
                                <option value="互助时间">互助时间</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-5">
                            <button type="submit" class="btn btn-primary btn-block">添 加</button>
                        </div>
                    </div>
                </form>
            </div>
            <%--<div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
        </div>

    </div>

    <jsp:include page="footer.jsp"/>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Page level plugin JavaScript-->
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
    <!-- Custom scripts for this page-->
    <script src="js/sb-admin-datatables.min.js"></script>

    <script>
        $(document).ready(function () {
            if ("自定义" != $("#service_type").val()) $("#type_detail").hide();
            $("#service_type").change(function () {
                if ("自定义" == $(this).val()) {
                    $("#type_detail").show();
                } else {
                    $("#type_detail").hide();
                }
            });
        });
    </script>
</div>
</body>

</html>

