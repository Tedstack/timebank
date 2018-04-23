<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.PayWay" %>
<%@ page import="java.util.Date" %>
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
    <link href="vendor/bootstrap/css/bootstrap-datetimepicker.css" rel="stylesheet">
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
            <li class="breadcrumb-item active">预约服务</li>
        </ol>

        <!-- Example Bar Chart Card-->
        <div class="card mb-3">
            <div class="card-header">
                <i class="fa fa-bar-chart"></i> 预约信息
            </div>
            <div class="card-body">

                <form action="${pageContext.request.contextPath}/admin/recordAddSubmit" method="post">
                    <%
                        if (request.getAttribute("ok") != null) {
                            out.print("<div class='alert alert-success' role='alert'>"
                                    + request.getAttribute("ok") + "</div>");
                        }
                        if (request.getAttribute("error") != null) {
                            out.print("<div class='alert alert-danger' role='alert'>"
                                    + request.getAttribute("error") + "</div>");
                        }

                        ViewPublishDetailEntity publishDetail = (ViewPublishDetailEntity) request.getAttribute("publish");
                    %>


                    <input style="display: none" type="number" name="serviceUserId" value="<%=publishDetail.getUserId()%>"/>
                    <input style="display: none" type="number" name="publishId" value="<%=publishDetail.getId()%>"/>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">手机号</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="applyUserPhone" placeholder="请输入手机号" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">姓名</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="applyUserName" placeholder="请输入姓名" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务地址</label>
                        <div class="col-sm-4">
                            <input class="form-control" type="text" name="address" placeholder="请输入地址" required>
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
                            <%--<input class="form-control" type="datetime-local" name="beginTime" placeholder="请输入时间">--%>
                            <input size="16" type="text" name="beginTime" value="<%=nowTime%>" readonly class="form_datetime" required>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务时间</label>
                        <div class="col-sm-4">
                            <select name="serveTime" id="select_serveTime" class="form-control">
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
                        <label class="col-sm-1 col-form-label">支付方式</label>
                        <div class="col-sm-4">
                            <select name="payWay" id="payWay" class="form-control">
                                <%
                                    if (publishDetail.getServiceType().equals("志愿者服务")) {
                                        out.print("<option value='"+ PayWay.PAY_WAY_TIME_VOL +"'>志愿者币V</option>");
                                    } else {
                                        out.print("<option value='"+ PayWay.PAY_WAY_TIME_COIN +"'>互助时间C</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label"><%=publishDetail.getServiceType()%>
                        </label>
                        <div class="col-sm-4">
                            <span><img src="../img/服务名称/<%=publishDetail.getServiceName()%>.png"
                                       style="height:20px;"></span>
                            <input type="text" readonly class="form-control-plaintext"
                                   value="<%=publishDetail.getServiceName()%>服务">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">服务单价</label>
                        <div class="col-sm-4 col-form-label">
                            <span id="eachPrice"><%out.print(publishDetail.getPrice());%></span>
                            <span><%
                                if (publishDetail.getServiceType().equals("志愿者服务")) {
                                    out.print("（志愿者币V/h）");
                                } else {
                                    out.print("（互助时间C/h）");
                                }
                            %></span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-1 col-form-label">预计付费</label>
                        <div class="col-sm-4 col-form-label">
                            <span id="sumPrice"><%out.print(publishDetail.getPrice());%></span>
                            <span><%
                                if (publishDetail.getServiceType().equals("志愿者服务")) {
                                    out.print("（志愿者币V/h）");
                                } else {
                                    out.print("（互助时间C/h）");
                                }
                            %></span>
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-sm-5">
                            <button type="submit" class="btn btn-primary btn-block">确认预约</button>
                        </div>
                    </div>
                </form>
            </div>
            <%--<div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
        </div>

    </div>

    <jsp:include page="footer.jsp"/>

    <script src="${pageContext.request.contextPath}/js/jquery/jquery-3.2.1.min.js"></script>
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
    <script src="vendor/bootstrap/js/bootstrap-datetimepicker.js"></script>

    <script>
        $(document).ready(function () {
            $('#select_serveTime').change(function () {
                var sum = $(this).val() * $('#eachPrice').text();
                $('#sumPrice').text(sum);
            });
        });
    </script>
    <script type="text/javascript">
        $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii:ss'});
    </script>
</div>
</body>

</html>

