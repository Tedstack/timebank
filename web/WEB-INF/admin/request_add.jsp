<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="java.util.*" %>
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
    <title>需求发布</title>
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
            <li class="breadcrumb-item active">后台发布需求</li>
        </ol>

        <!-- Example Bar Chart Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i> 需求信息
            </div>
            <div class="card-body">

                <form action="${pageContext.request.contextPath}/admin/requestAddSubmit" method="post">
                    <%
                        if (request.getAttribute("ok") != null) {
                            out.print("<div class='alert alert-success' role='alert'>"
                                    + request.getAttribute("ok") + "</div>");
                        }
                        if (request.getAttribute("error") != null) {
                            out.print("<div class='alert alert-danger' role='alert'>"
                                    + request.getAttribute("error") + "</div>");
                        }

                        Map<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
                        List<ServiceEntity> list = (List<ServiceEntity>) request.getAttribute("service_list");
                        for (ServiceEntity service : list) {
                            if (!map.containsKey(service.getType()))
                                map.put(service.getType(), new ArrayList<String>());
                            map.get(service.getType()).add(service.getName());
                        }
                    %>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">需求类型</label>
                        <div class="col-sm-4">
                            <select name="requestType" id="request_type" class="form-control">
                                <%
                                    for (String type : map.keySet()) {
                                        out.print("<option value='" + type + "'>" + type + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <%
                        for (String type : map.keySet()) {
                            List<String> names = map.get(type);
                    %>

                    <div class="form-group row ui-name" id="<%out.print(type);%>">
                        <label class="col-sm-1 col-form-label">需求名称</label>
                        <div class="col-sm-4">
                            <select name="requestName" class="form-control">
                                <%
                                    for (String name : names) {
                                        out.print("<option value='" + name + "'>" + name + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <%
                        }
                    %>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">需求者手机号</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="phone" pattern="[0-9]*" placeholder="请输入手机号" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">需求描述</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" name="description" placeholder="请输入描述" rows="3" required></textarea>
                        </div>
                    </div>

                    <%
                        Date nowDate = new Date();
                        Date nextDate = new Date();
                        nextDate.setTime(nextDate.getTime() + 3600000);
                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String nowTime = formatter.format(nowDate);
                        String nextTime = formatter.format(nextDate);
                    %>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">开始时间</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="datetime-local" name="beginTime" value="<%=nowTime%>" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">结束时间</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="datetime-local" name="endTime" value="<%=nextTime%>" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">需求价格</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="number" name="price" pattern="[0-9]*.[0-9]*" placeholder="请输入价格" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">需求地址</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" name="address" placeholder="请输入需求地址" rows="3" required></textarea>
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

    <script>
        $(document).ready(function () {
            $('.ui-name:gt(0)').hide();
            $('.ui-name:gt(0)').find("select").attr("name", "");
            $('#request_type').change(function () {
                $('.ui-name').hide();
                $('.ui-name').find("select").attr("name", "");
                $('#' + $(this).val()).show();
                $('#' + $(this).val()).find("select").attr("name", "requestName");
            });
        });
    </script>
</div>
</body>

</html>

