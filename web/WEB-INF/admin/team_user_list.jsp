<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ViewTeamDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewTeamUserDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.TeamUserStatus" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>团队成员列表</title>
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

<%
    ViewTeamDetailEntity teamDetailEntity = (ViewTeamDetailEntity)request.getAttribute("teamDetail");
%>

<!-- Navigation-->
<jsp:include page="navigation.jsp"/>
<div class="content-wrapper">
    <div class="container-fluid">
        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/admin/index">Dashboard</a>
            </li>
            <li class="breadcrumb-item active"> <span class="badge badge-primary"><%=teamDetailEntity.getName()%></span> 团队成员列表</li>
        </ol>
        <!-- Example DataTables Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-table"></i> <span class="badge badge-primary"><%=teamDetailEntity.getName()%></span> 成员表
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>手机号</th>
                            <th>性别</th>
                            <th>出生年月</th>
                            <th>是否被锁定</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<ViewTeamUserDetailEntity> list = (List<ViewTeamUserDetailEntity>) request.getAttribute("list");
                            for (ViewTeamUserDetailEntity teamUserEntity : list) {
                        %>
                        <tr>
                            <td>
                                <a href='${pageContext.request.contextPath}/admin/userView?userId=<%=teamUserEntity.getUserId()%>' target='_blank' class='btn btn-link'><%=teamUserEntity.getUserName()%></a>
                            </td>
                            <td><%=teamUserEntity.getUserPhone()%></td>
                            <td><%=teamUserEntity.getUserSex()%></td>
                            <td><%=teamUserEntity.getUserBirth()%></td>
                            <td><%=teamUserEntity.getStatus()%></td>
                            <td>
                                <%
                                    if(teamUserEntity.getStatus().equals(TeamUserStatus.isLocked)){
                                %>
                                        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#unlockModal" data-whatever="<%=teamUserEntity.getId()%>">解锁</button>
                                <%
                                    }
                                    else {
                                %>
                                        <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#lockModal" data-whatever="<%=teamUserEntity.getId()%>">锁定</button>
                                <%
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


    <div class="modal fade" id="lockModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">提示信息</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <p>您确认要锁定该用户吗？锁定后该用户将不能申请团队组织的活动</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <form action="${pageContext.request.contextPath}/admin/teamUserLockSubmit" method="post">
                        <input style="display: none" name="id">
                        <input style="display: none" name="teamId" value="<%=teamDetailEntity.getId()%>" >
                        <input style="display: none" name="isLock" value="1">
                        <button type="submit" class="btn btn-danger">是的，确定锁定！</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="unlockModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">提示信息</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        &times;
                    </button>
                </div>
                <div class="modal-body">
                    <p>您确认要解锁该用户吗？解锁后该用户可以正常申请团队组织的活动</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <form action="${pageContext.request.contextPath}/admin/teamUserLockSubmit" method="post">
                        <input style="display: none" name="id">
                        <input style="display: none" name="teamId" value="<%=teamDetailEntity.getId()%>" >
                        <input style="display: none" name="isLock" value="0">
                        <button type="submit" class="btn btn-success">是的，确定解锁！</button>
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
        $('#lockModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var id = button.data('whatever');
            $(this).find('.modal-footer input:eq(0)').val(id);
        });
        $('#unlockModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var id = button.data('whatever');
            $(this).find('.modal-footer input:eq(0)').val(id);
        });
    </script>

</div>
</body>

</html>

