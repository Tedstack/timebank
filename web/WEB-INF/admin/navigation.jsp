<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/28
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/index">邻里智助后台管理</a>
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/index">
                    <i class="fa fa-fw fa-dashboard"></i>
                    <span class="nav-link-text">Dashboard</span>
                </a>
            </li>

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseUser" data-parent="#exampleAccordion">
                    <i class="fa fa-fw fa-user"></i>
                    <span class="nav-link-text">用户管理</span>
                </a>
                <ul class="sidenav-second-level collapse" id="collapseUser">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/userList">用户列表</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/userVerifyList">审核认证</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/userAdd">添加用户</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/userAddMany">批量导入</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseService" data-parent="#exampleAccordion">
                    <i class="fa fa-fw fa-gratipay"></i>
                    <span class="nav-link-text">服务种类管理</span>
                </a>
                <ul class="sidenav-second-level collapse" id="collapseService">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/serviceList">服务种类列表</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/serviceAdd">添加服务种类</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapsePublish" data-parent="#exampleAccordion">
                    <i class="fa fa-fw fa-paper-plane"></i>
                    <span class="nav-link-text">服务发布管理</span>
                </a>
                <ul class="sidenav-second-level collapse" id="collapsePublish">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/publishList">已发布服务列表</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/publishAdd">后台发布服务</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseRecord" data-parent="#exampleAccordion">
                    <i class="fa fa-fw fa-calendar-check-o"></i>
                    <span class="nav-link-text">订单管理</span>
                </a>
                <ul class="sidenav-second-level collapse" id="collapseRecord">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/recordList">订单列表</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/recordAddChoosePublish">帮助预约</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseTeam" data-parent="#exampleAccordion">
                    <i class="fa fa-fw fa-group"></i>
                    <span class="nav-link-text">志愿者团体管理</span>
                </a>
                <ul class="sidenav-second-level collapse" id="collapseTeam">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/teamList">团体列表</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/teamAdd">添加团体</a>
                    </li>
                </ul>
            </li>

            <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Components">
                <a class="nav-link nav-link-collapse collapsed" data-toggle="collapse" href="#collapseActivity" data-parent="#exampleAccordion">
                    <i class="fa fa-fw fa-handshake-o"></i>
                    <span class="nav-link-text">团队活动管理</span>
                </a>
                <ul class="sidenav-second-level collapse" id="collapseActivity">
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/activityPublishList">团队活动列表</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/admin/activityPublishAdd">团队活动发布</a>
                    </li>
                </ul>
            </li>


        <%--<li class="nav-item" data-toggle="tooltip" data-placement="right" title="Link">--%>
                <%--<a class="nav-link" href="#">--%>
                    <%--<i class="fa fa-fw fa-link"></i>--%>
                    <%--<span class="nav-link-text">Link</span>--%>
                <%--</a>--%>
            <%--</li>--%>

        </ul>
        <ul class="navbar-nav sidenav-toggler">
            <li class="nav-item">
                <a class="nav-link text-center" id="sidenavToggler">
                    <i class="fa fa-fw fa-angle-left"></i>
                </a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle mr-lg-2" id="messagesDropdown" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-fw fa-envelope"></i>
                    <span class="d-lg-none">Messages
              <span class="badge badge-pill badge-primary">12 New</span>
            </span>
                    <span class="indicator text-primary d-none d-lg-block">
              <i class="fa fa-fw fa-circle"></i>
            </span>
                </a>
                <div class="dropdown-menu" aria-labelledby="messagesDropdown">
                    <h6 class="dropdown-header">New Messages:</h6>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
                        <strong>David Miller</strong>
                        <span class="small float-right text-muted">11:21 AM</span>
                        <div class="dropdown-message small">Hey there! This new version of SB Admin is pretty awesome! These messages clip off when they reach the end of the box so they don't overflow over to the sides!</div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
                        <strong>Jane Smith</strong>
                        <span class="small float-right text-muted">11:21 AM</span>
                        <div class="dropdown-message small">I was wondering if you could meet for an appointment at 3:00 instead of 4:00. Thanks!</div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
                        <strong>John Doe</strong>
                        <span class="small float-right text-muted">11:21 AM</span>
                        <div class="dropdown-message small">I've sent the final files over to you for review. When you're able to sign off of them let me know and we can discuss distribution.</div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item small" href="#">View all messages</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle mr-lg-2" id="alertsDropdown" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <i class="fa fa-fw fa-bell"></i>
                    <span class="d-lg-none">Alerts
              <span class="badge badge-pill badge-warning">6 New</span>
            </span>
                    <span class="indicator text-warning d-none d-lg-block">
              <i class="fa fa-fw fa-circle"></i>
            </span>
                </a>
                <div class="dropdown-menu" aria-labelledby="alertsDropdown">
                    <h6 class="dropdown-header">New Alerts:</h6>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
              <span class="text-success">
                <strong>
                  <i class="fa fa-long-arrow-up fa-fw"></i>Status Update</strong>
              </span>
                        <span class="small float-right text-muted">11:21 AM</span>
                        <div class="dropdown-message small">This is an automated server response message. All systems are online.</div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
              <span class="text-danger">
                <strong>
                  <i class="fa fa-long-arrow-down fa-fw"></i>Status Update</strong>
              </span>
                        <span class="small float-right text-muted">11:21 AM</span>
                        <div class="dropdown-message small">This is an automated server response message. All systems are online.</div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">
              <span class="text-success">
                <strong>
                  <i class="fa fa-long-arrow-up fa-fw"></i>Status Update</strong>
              </span>
                        <span class="small float-right text-muted">11:21 AM</span>
                        <div class="dropdown-message small">This is an automated server response message. All systems are online.</div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item small" href="#">View all alerts</a>
                </div>
            </li>
            <li class="nav-item">
                <form class="form-inline my-2 my-lg-0 mr-lg-2">
                    <div class="input-group">
                        <input class="form-control" type="text" placeholder="Search for...">
                        <span class="input-group-btn">
                <button class="btn btn-primary" type="button">
                  <i class="fa fa-search"></i>
                </button>
              </span>
                    </div>
                </form>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="modal" data-target="#exampleModal">
                    <i class="fa fa-fw fa-sign-out"></i>退出</a>
            </li>
        </ul>
    </div>
</nav>


<!-- Logout Modal-->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">提示信息</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">确认要退出吗？</div>
            <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">取消</button>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/admin/logout">确认退出</a>
            </div>
        </div>
    </div>
</div>
