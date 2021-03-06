<%@ page import="com.blockchain.timebank.entity.TeamEntity" %>
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
    <title>团队活动发布</title>
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
            <li class="breadcrumb-item active">团队活动发布</li>
        </ol>

        <!-- Example Bar Chart Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i> 团队活动信息
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

                <form action="${pageContext.request.contextPath}/admin/activityPublishAddSubmit" method="post">


                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">发布的团队</label>
                        <div class="col-sm-4">
                            <select name="teamId" class="form-control">
                                <%
                                    List<TeamEntity> teamEntities = (List<TeamEntity>)request.getAttribute("team_list");
                                    for(TeamEntity teamEntity:teamEntities){
                                %>
                                        <option value="<%=teamEntity.getId()%>"><%=teamEntity.getName()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">活动名称</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="name" placeholder="请输入名称" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">活动简介</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" name="description" placeholder="请输入描述" rows="6" required></textarea>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">开始时间</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="datetime-local" name="beginTime" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">活动时长</label>
                        <div class="col-sm-4">
                            <select name="serveTime" class="form-control">
                                <option value="1">1小时</option>
                                <option value="2">2小时</option>
                                <option value="3">3小时</option>
                                <option value="4">4小时</option>
                                <option value="5">5小时</option>
                                <option value="6">6小时</option>
                                <option value="7">7小时</option>
                                <option value="8">8小时</option>
                                <option value="9">9小时</option>
                                <option value="10">10小时</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">活动地点</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" name="address" placeholder="请输入地点" rows="2" required></textarea>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">活动人数</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="number" name="peopleCount" placeholder="请输入人数" required>
                        </div>
                    </div>


                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">申请截止时间</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="datetime-local" name="applyEndTime" required>
                        </div>
                    </div>


                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">是否公开</label>
                        <div class="col-sm-4">
                            <select name="IsPublic" class="form-control">
                                <option value="1">是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-5">
                            <button type="submit" class="btn btn-primary btn-block">发 布</button>
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

