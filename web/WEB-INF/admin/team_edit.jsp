<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>志愿者团队编辑</title>
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
            <li class="breadcrumb-item active">志愿者团队编辑</li>
        </ol>

        <!-- Example Bar Chart Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i> 团队信息
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

                    ViewTeamDetailEntity teamDetail=(ViewTeamDetailEntity) request.getAttribute("team");
                %>

                <form action="${pageContext.request.contextPath}/admin/teamEditSubmit" method="post">

                    <div class="form-group row" style="display: none;">
                        <label class="col-sm-1 col-form-label">编号</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="teamId" placeholder="请输入Id" value="<%=teamDetail.getId()%>" readonly>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">团队名称</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="name" placeholder="请输入名称" value="<%=teamDetail.getName()%>" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">创建者手机号</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="phone" pattern="[0-9]{11}" placeholder="请输入手机号"  value="<%=teamDetail.getCreatorUserPhone()%>" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">团队简介</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" name="description" placeholder="请输入描述" rows="6" required><%=teamDetail.getDescription()%></textarea>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-5">
                            <button type="submit" class="btn btn-primary btn-block">修 改</button>
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
</div>
</body>

</html>

