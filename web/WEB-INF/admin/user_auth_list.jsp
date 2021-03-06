<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.UserAuthEntity" %>
<%@ page import="com.blockchain.timebank.config.UserAuthRole" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>后台用户列表</title>
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
            <li class="breadcrumb-item active">后台用户列表</li>
        </ol>
        <!-- Example DataTables Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-table"></i> 后台用户表
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>手机号</th>
                                <th>权限</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <%--<tfoot>--%>
                        <%--<tr>--%>
                        <%--<th>Name</th>--%>
                        <%--<th>Position</th>--%>
                        <%--<th>Office</th>--%>
                        <%--<th>Age</th>--%>
                        <%--<th>Start date</th>--%>
                        <%--<th>Salary</th>--%>
                        <%--</tr>--%>
                        <%--</tfoot>--%>

                        <tbody>
                        <%
                            List<UserAuthEntity> list = (List< UserAuthEntity>) request.getAttribute("list");
                            for (UserAuthEntity userAuthEntity:list) {
                        %>
                        <tr>
                            <td><%=userAuthEntity.getName()%></td>
                            <td><%=userAuthEntity.getPhone()%></td>
                            <td>
                                <%
                                    List<String> auth = (List<String>) request.getAttribute("auth"+userAuthEntity.getId());
                                    List<String> auth_name = new ArrayList<>();
                                    if(auth.contains(UserAuthRole.ROLE_USER_MANAGE)) auth_name.add("用户管理");
                                    if(auth.contains(UserAuthRole.ROLE_SERVICE_MANAGE)) auth_name.add("服务种类管理");
                                    if(auth.contains(UserAuthRole.ROLE_PUBLISH_MANAGE)) auth_name.add("服务发布管理");
                                    if(auth.contains(UserAuthRole.ROLE_RECORD_MANAGE)) auth_name.add("订单管理");
                                    if(auth.contains(UserAuthRole.ROLE_TEAM_MANAGE)) auth_name.add("志愿者团队管理");
                                    if(auth.contains(UserAuthRole.ROLE_ACTIVITY_MANAGE)) auth_name.add("团队活动管理");
                                    if(auth.contains(UserAuthRole.ROLE_USER_AUTH_MANAGE)) auth_name.add("后台用户管理");
                                    for(String name:auth_name){
                                %>
                                        <span class="badge badge-primary"><%=name%></span>
                                <%
                                    }
                                %>
                            </td>
                            <td>
                                <a href='${pageContext.request.contextPath}/admin/userAuthEdit?id=<%=userAuthEntity.getId()%>' target='_blank' class='btn btn-primary btn-sm'>编辑</a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>


                </div>
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>
    </div>
    <!-- /.container-fluid-->
    <!-- /.content-wrapper-->
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

