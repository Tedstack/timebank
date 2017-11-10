<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>服务种类列表</title>
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
            <li class="breadcrumb-item active">已发布服务列表</li>
        </ol>
        <!-- Example DataTables Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-table"></i> 服务发布表
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>发布人</th>
                            <th>发布人手机号</th>
                            <th>服务类型</th>
                            <th>服务名称</th>
                            <th>发布价格</th>
                            <th>服务的范围</th>
                            <th>生效时间</th>
                            <th>失效时间</th>
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
                            List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>) request.getAttribute("list");
                            for (ViewPublishDetailEntity detailEntity : list) {
                        %>
                        <tr>
                            <td><%=detailEntity.getId()%></td>
                            <td><%=detailEntity.getUserName()%></td>
                            <td><%=detailEntity.getUserPhone()%></td>
                            <td><%=detailEntity.getServiceType()%></td>
                            <td>
                                <span><img src="../img/服务名称/<%=detailEntity.getServiceName()%>.png" height="25px"></span>
                                &nbsp;<%=detailEntity.getServiceName()%>
                            </td>
                            <td><%=detailEntity.getPrice()%></td>
                            <td><%=detailEntity.getAddress()%></td>
                            <td><%out.print(new SimpleDateFormat("yyyy-MM-dd").format(detailEntity.getBeginDate()));%></td>
                            <td><%out.print(new SimpleDateFormat("yyyy-MM-dd").format(detailEntity.getEndDate()));%></td>
                            <td>
                                <%
                                    if (request.getAttribute("link_publishView") != null) {
                                        out.print("<a href='' class='btn btn-primary btn-sm'>查看</a> ");
                                    }
                                    if (request.getAttribute("link_recordAdd") != null) {
                                        out.print("<a href='/admin/recordAdd?publishId=" + detailEntity.getId() + "' target='_blank' class='btn btn-primary btn-sm'>预约服务</a> ");
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

