<%@ page import="com.blockchain.timebank.entity.PublishOrderEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishOrderDetailEntity" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishOrderDetailEntity" %>
<%@ page import="com.blockchain.timebank.weixin.util.FormatOrderIdUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已完成</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/bootstrap.min.css" />
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/utils.js"></script>
</head>
<body onpageshow="back_to('${pageContext.request.contextPath}/publish/category');">
<%
    List<ViewPublishOrderDetailEntity> recordDetailList = (List<ViewPublishOrderDetailEntity>) request.getAttribute("recordDetailList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
           <%-- <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px;height:34px;">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p style="margin:0"><img src="../img/返回.png" width="20" height="15"alt="">已完成</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>--%>
            <div class="weui-navbar" style="position:fixed;">
                <div class="weui-navbar__item "id="navbar1">
                    已发布
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待确认
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    待服务
                </div>
                <div class="weui-navbar__item"id="navbar4">
                    待收款
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar5" style="color: #7ACF41">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel" style="padding-bottom: 50px; padding-top: 70px">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<recordDetailList.size();i++) {
                %>
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单状态</label>
                                <em class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getStatus());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        out.print(FormatOrderIdUtil.getServiceOrderFormatId(recordDetailList.get(i)));
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务实收款</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        if(recordDetailList.get(i).getStatus().equals("已完成")){
                                            if(recordDetailList.get(i).getPayWay() == 1)
                                                out.print(recordDetailList.get(i).getPayMoney()+"志愿者时间");
                                            else if(recordDetailList.get(i).getPayWay() == 2)
                                                out.print(recordDetailList.get(i).getPayMoney()+"时间币");
                                            else
                                                out.print(recordDetailList.get(i).getPayMoney()+"元");
                                        }else{
                                            out.print("未进行服务，未产生费用");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务对象</label>
                                <span class="weui-form-preview__value"><%out.print(recordDetailList.get(i).getApplyUserName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务开始时间</label>
                                <span class="weui-form-preview__value">
                                     <%
                                         if(recordDetailList.get(i).getStatus().equals("已完成")){
                                             Timestamp beginTimestamp = recordDetailList.get(i).getActualBeginTime();
                                             Date date = new Date(beginTimestamp.getTime());
                                             SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                             out.print(bartDateFormat.format(date));
                                         }else{
                                             out.print("未进行服务，无服务时间");
                                         }
                                     %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务结束时间</label>
                                <span class="weui-form-preview__value">
                                     <%
                                         if(recordDetailList.get(i).getStatus().equals("已完成")){
                                             Timestamp endTimestamp = recordDetailList.get(i).getActualEndTime();
                                             Date date2 = new Date(endTimestamp.getTime());
                                             SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                                             out.print(bartDateFormat2.format(date2));
                                         }else{
                                             out.print("未进行服务，无服务时间");
                                         }
                                     %>
                                </span>
                            </div>
                            <div class="weui-panel__ft">
                                <%--<a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>--%>
                            </div>
                        </div>

                    </div>
                    <div style="background-color: #f8f8f8; height:15px;"></div>
                </div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/request/list?type=volunteer" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">需求柜台</p>
        </a>
        <a href="${pageContext.request.contextPath}/request/applied?tab=1" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我承接的需求</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyPublish" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">我发布的服务</p>
        </a>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishAlreadyPublish";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingConfirm";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingService";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishWaitingCollect";
        });
        $("#navbar5").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryPublishAlreadyComplete";
        });
    });
</script>

</body>
</html>