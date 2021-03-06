<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>服务发布</title>
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
            <li class="breadcrumb-item active">后台发布服务</li>
        </ol>

        <!-- Example Bar Chart Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i> 服务信息
            </div>
            <div class="card-body">

                <form action="${pageContext.request.contextPath}/admin/publishAddSubmit" method="post">
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
                        <label class="col-sm-1 col-form-label">服务类型</label>
                        <div class="col-sm-4">
                            <select name="serviceType" id="service_type" class="form-control">
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
                        <label class="col-sm-1 col-form-label">服务名称</label>
                        <div class="col-sm-4">
                            <select name="serviceName" class="form-control">
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
                        <label class="col-sm-1 col-form-label">发布者手机号</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="phone" pattern="[0-9]*" placeholder="请输入手机号" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务描述</label>
                        <div class="col-sm-4">
                            <textarea class="form-control" name="description" placeholder="请输入描述" rows="3" required></textarea>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">开始日期</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="date" name="beginDate" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">结束日期</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="date" name="endDate" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务价格</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="price" pattern="[0-9]*.[0-9]*" placeholder="请输入价格" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务范围</label>
                        <div class="col-sm-4">
                            <select name="address" id="address" class="form-control">
                                <%--黄浦区、徐汇区、长宁区、静安区、普陀区、虹口区、杨浦区、宝山区、闵行区、嘉定区、浦东新区、松江区、金山区、青浦区、奉贤区、崇明区--%>
                                <option value="黄浦区">黄浦区</option>
                                <option value="徐汇区">徐汇区</option>
                                <option value="长宁区">长宁区</option>
                                <option value="静安区">静安区</option>
                                <option value="普陀区">普陀区</option>
                                <option value="虹口区">虹口区</option>
                                <option value="杨浦区">杨浦区</option>
                                <option value="宝山区">宝山区</option>
                                <option value="闵行区">闵行区</option>
                                <option value="嘉定区">嘉定区</option>
                                <option value="浦东新区">浦东新区</option>
                                <option value="松江区">松江区</option>
                                <option value="金山区">金山区</option>
                                <option value="青浦区">青浦区</option>
                                <option value="奉贤区">奉贤区</option>
                                <option value="崇明区">崇明区</option>
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

    <script>
        $(document).ready(function () {
            $('.ui-name:gt(0)').hide();
            $('.ui-name:gt(0)').find("select").attr("name", "");
            $('#service_type').change(function () {
                $('.ui-name').hide();
                $('.ui-name').find("select").attr("name", "");
                $('#' + $(this).val()).show();
                $('#' + $(this).val()).find("select").attr("name", "serviceName");
            });
        });
    </script>
</div>
</body>

</html>

