<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.weixin.util.FormatOrderIdUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已完成</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/utils.js"></script>
</head>
<body>
<%
    List<ViewPublishOrderDetailEntity> recordDetailList = (List<ViewPublishOrderDetailEntity>) request.getAttribute("recordDetailList");
%>
<div class="main-container">
    <div class="main-content">
<div class="page">
    <div class="page__bd" style="height: 100%;">
            <%--<div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">已完成</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>--%>
            <div class="weui-navbar" style="position:fixed;">
                <div class="weui-navbar__item"id="navbar1">
                    已预约
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待服务
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    待付款
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar4">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
        <div class="weui-tab">
            <div class="weui-tab__panel" style="padding-bottom: 50px; padding-top: 70px">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<recordDetailList.size();i++) {
                %>
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务状态</label>
                                <em class="weui-form-preview__value" style="color: #7ACF41"><%out.print(recordDetailList.get(i).getStatus());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务名称</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getServiceName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务收费</label>
                                <span class="weui-form-preview__value" style="color: #7ACF41"><%
                                    if(recordDetailList.get(i).getStatus().equals("已完成")){
                                        out.print(recordDetailList.get(i).getPayMoney());
                                    }else{
                                        out.print("未进行服务，未产生费用");
                                    }
                                %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value"><%out.print(FormatOrderIdUtil.getServiceOrderFormatId(recordDetailList.get(i)));%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务提供者</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getServiceUserName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务时间</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        if(recordDetailList.get(i).getStatus().equals("已完成")){
                                            Timestamp beginTimestamp = recordDetailList.get(i).getActualBeginTime();
                                            Date date = new Date(beginTimestamp.getTime());
                                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                                            Timestamp endTimestamp = recordDetailList.get(i).getActualEndTime();
                                            Date date2 = new Date(endTimestamp.getTime());
                                            SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                                            out.print(bartDateFormat.format(date)+" - "+bartDateFormat2.format(date2));
                                        }else{
                                            out.print("未进行服务，无服务时间");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务地点</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getAddress());%></span>
                            </div>
                            <%if(recordDetailList.get(i).getRating()!=null){%>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务评分</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getRating());%>分</span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务评价</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        if(recordDetailList.get(i).getComment()!=null){
                                            out.print(recordDetailList.get(i).getComment());
                                        }
                                        else{
                                            out.print("无");
                                        }
                                    %>
                                </span>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div class="weui-flex">
                            <div class="weui-flex__item"diaplay="none"></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item">
                                <%
                                    if(recordDetailList.get(i).getRating()==null){
                                        out.print("<a href='"+ request.getContextPath() +"/user/applyUserStartEvaluate?recordID="+ recordDetailList.get(i).getId()+"' class='weui-btn weui-btn_mini weui-btn_primary'>评价</a>");
                                    }else{
                                        out.print("<span>已评价</span>");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>

                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/publish/list?type=志愿者服务" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">服务柜台</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/queryOrderAlreadyApply" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">我预约的服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/request/published?tab=1" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">我发布的需求</p>
        </a>
    </div>
</div>
    </div>
    <button class="float-button" style="font-size: xx-large;" id="create">+
    </button>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/request/add");
    });
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderAlreadyApply";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderWaitingService";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderWaitingPay";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryOrderAlreadyComplete";
        });
    });
</script>
</html>