<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
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
    <title>用户列表</title>
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
                <a href="/admin/index">Dashboard</a>
            </li>
            <li class="breadcrumb-item active">用户列表</li>
        </ol>
        <!-- Example DataTables Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-table"></i> 用户表
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>手机号</th>
                            <th>身份证号</th>
                            <th>实名认证</th>
                            <th>是否已审核</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<UserEntity> list_user = (List<UserEntity>) request.getAttribute("list_user");
                            for (UserEntity userEntity : list_user) {
                        %>
                        <tr>
                            <td><%=userEntity.getName()%>
                            </td>
                            <td><%=userEntity.getPhone()%>
                            </td>
                            <td>
                                <%
                                    out.print(userEntity.getIdCard());
                                %>
                            </td>
                            <td>
                                <%
                                    if (userEntity.getImg1() == null || userEntity.getImg2() == null) {
                                        out.print("未上传照片");
                                        out.print("<a href='/admin/userPhotoAdd?userId=" + userEntity.getId() + "' target='_blank'>（上传）</a> ");
                                    } else {
                                        out.print("已上传照片");
                                        out.print("<a href='/admin/userPhotoAdd?userId=" + userEntity.getId() + "' target='_blank'>（查看）</a> ");
                                    }

                                %>
                            </td>
                            <td>
                                <%
                                    if (userEntity.getIsVerify() != null && userEntity.getIsVerify() != 0) {
                                        out.print("已审核");
                                    }else{
                                        out.print("未审核");
                                    }
                                %>
                            </td>
                            <td>
                                <%
                                    if (request.getAttribute("link_userView") != null) {
                                        out.print("<a href='/admin/userView?userId=" + userEntity.getId() + "' target='_blank' class='btn btn-primary btn-sm'>查看</a> ");
                                    }
                                    if (request.getAttribute("link_userEdit") != null) {
                                        out.print("<a href='/admin/userEdit?userId=" + userEntity.getId() + "' target='_blank' class='btn btn-primary btn-sm'>编辑</a> ");
                                    }
                                %>
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

