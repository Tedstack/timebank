<%@ page import="com.blockchain.timebank.config.UserAuthRole" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>后台用户添加</title>
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
            <li class="breadcrumb-item active">后台用户添加</li>
        </ol>

        <!-- Example Bar Chart Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i> 用户信息
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

                <form action="${pageContext.request.contextPath}/admin/userAuthAddSubmit" method="post">

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">姓名</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="name" placeholder="请输入名称" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">手机号</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="phone" pattern="[0-9]{11}" placeholder="请输入手机号" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">密码</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="password" name="password" placeholder="请输入密码" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">重复密码</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="password" name="password2" placeholder="请再次输入密码" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">选择管理权限（可多选）</label>
                        <div class="col-sm-4">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="<%=UserAuthRole.ROLE_USER_MANAGE%>"> 用户管理
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="<%=UserAuthRole.ROLE_SERVICE_MANAGE%>"> 服务种类管理
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="<%=UserAuthRole.ROLE_PUBLISH_MANAGE%>"> 服务发布管理
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="<%=UserAuthRole.ROLE_RECORD_MANAGE%>"> 订单管理
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="<%=UserAuthRole.ROLE_TEAM_MANAGE%>"> 志愿者团队管理
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="<%=UserAuthRole.ROLE_ACTIVITY_MANAGE%>"> 团队活动管理
                                </label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="auth" value="<%=UserAuthRole.ROLE_USER_AUTH_MANAGE%>"> 后台用户管理
                                </label>
                            </div>
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
</div>
</body>

</html>

