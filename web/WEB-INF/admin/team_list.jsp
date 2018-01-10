<%@ page import="java.util.List" %>
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
    <title>志愿者团队列表</title>
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
            <li class="breadcrumb-item active">志愿者团队列表</li>
        </ol>
        <!-- Example DataTables Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-table"></i> 志愿者团队表
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>团队名称</th>
                            <th>团队管理者</th>
                            <th>成员列表</th>
                            <th>团队简介</th>
                            <th>创建日期</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            List<ViewTeamDetailEntity> list = (List<ViewTeamDetailEntity>) request.getAttribute("list");
                            for (ViewTeamDetailEntity teamEntity : list) {
                        %>
                        <tr>
                            <td>
                                <%=teamEntity.getName()%>
                            </td>
                            <td>
                                <a href='${pageContext.request.contextPath}/admin/userView?userId=<%=teamEntity.getCreatorId()%>' target='_blank' class='btn btn-link'><%=teamEntity.getManagerUserName()%></a>
                            </td>
                            <td>
                                <a href='${pageContext.request.contextPath}/admin/teamUserList?teamId=<%=teamEntity.getId()%>' target='_blank' class='btn btn-link'>查看</a>
                            </td>
                            <td>
                                <button type="button" class="btn btn-link" data-toggle="modal" data-target="#descriptionModal" data-whatever="<%=teamEntity.getDescription()%>">查看</button>
                            </td>
                            <td><%=teamEntity.getCreateDate()%></td>
                            <td>
                                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteModal" data-whatever="<%=teamEntity.getId()%>">删除</button>
                                <a href='${pageContext.request.contextPath}/admin/teamEdit?teamId=<%=teamEntity.getId()%>' target='_blank' class='btn btn-primary btn-sm'>编辑</a>
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

    <div class="modal fade" id="descriptionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">团队简介</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <p></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">提示信息</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <p>您确认要删除吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <form action="${pageContext.request.contextPath}/admin/teamDeleteSubmit" method="post">
                        <input style="display: none" name="teamId">
                        <button type="submit" class="btn btn-danger">是的，确定删除！</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

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
        $('#descriptionModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var description = button.data('whatever'); // Extract info from data-* attributes
            $(this).find('.modal-body p').text(description);
        });


        $('#teamUserModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var description = button.data('whatever'); // Extract info from data-* attributes
            $(this).find('.modal-body p').text(description);
        });

        $('#deleteModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var teamId = button.data('whatever');
            $(this).find('.modal-footer input').val(teamId);
        });
    </script>

</div>
</body>

</html>

