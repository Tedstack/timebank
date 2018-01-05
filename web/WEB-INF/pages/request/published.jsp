<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewRequestOrderDetailEntity" %>
<%@ page import="java.math.BigDecimal" %>
<%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 05/01/2018
  Time: 15:09
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已发布</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <style>
        .weui-bar__item_on{
            color: #7ACF41
        }
    </style>
</head>
<body>
<%
    List<ViewRequestDetailEntity> requestPublished = (List<ViewRequestDetailEntity>) request.getAttribute("requestPublished");
    List<ViewRequestOrderDetailEntity> requestToConfirm = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestToConfirm");
    List<ViewRequestOrderDetailEntity> requestToService = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestToService");
    List<ViewRequestOrderDetailEntity> requestToPay = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestToPay");
    List<ViewRequestOrderDetailEntity> requestCompleted = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestCompleted");

%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-navbar">
            <div class="weui-navbar__item weui-bar__item_on" id="navbar1">
                已发布
            </div>
            <div class="weui-navbar__item" id="navbar2">
                待确认
            </div>
            <div class="weui-navbar__item" id="navbar3">
                待服务
            </div>
            <div class="weui-navbar__item" id="navbar4">
                待付款
            </div>
            <div class="weui-navbar__item" id="navbar5">
                已完成
            </div>
        </div>
        <div class="weui-tab">
            <!--published start-->
            <div class="weui-tab__panel" id="published" style="padding-bottom: 50px; padding-top: 70px;display: block">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i = 0; i< requestPublished.size(); i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60" src="../img/服务名称/<%out.print(requestPublished.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title" style="color: #7ACF41;"><%out.print(requestPublished.get(i).getServiceName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">需求类型:
                                <%
                                    switch(requestPublished.get(i).getServiceType()) {
                                    case "volunteer":
                                        out.print("志愿者需求");
                                        break;
                                    case "technic":
                                        out.print("专业需求");
                                        break;
                                    case "mutualAid":
                                        out.print("互助需求");
                                        break;
                                }
                                %>
                            </p>
                            <p class="weui-media-box__desc">开始时间:
                                <%
                                    Timestamp timestamp = requestPublished.get(i).getBeginTime();
                                    Date date = new Date(timestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc">结束时间:
                                <%
                                    Timestamp timestamp2 = requestPublished.get(i).getEndTime();
                                    Date date2 = new Date(timestamp2.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <p class="weui-media-box__desc">需求地址:<%out.print(requestPublished.get(i).getAddress());%></p>
                            <p class="weui-media-box__desc">预留联系方式:<%out.print(requestPublished.get(i).getUserPhone());%></p>
                        </div>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div class="weui-flex">
                            <div class="weui-flex__item"diaplay="none"></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"><a href="<%out.print("publishDetail?id="+requestPublished.get(i).getId()+"&type="+requestPublished.get(i).getServiceType());%>" class="weui-btn weui-btn_mini weui-btn_primary">查看</a></div>
                        </div>
                    </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--published end-->
            
            <!--to_confirm start-->
            <div class="weui-tab__panel" id="to_confirm" style="padding-bottom: 50px; padding-top: 70px;display: none">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<requestToConfirm.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务名称/<%out.print(requestToConfirm.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title">订单号<%out.print(requestToConfirm.get(i).getId());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>

                            </div>
                            <p class="weui-media-box__desc">需求项目: <%out.print(requestToConfirm.get(i).getServiceName());%></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">开始时间:
                                <%
                                    Timestamp beginTimestamp = requestToConfirm.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc"style="color: #7ACF41">结束时间:
                                <%
                                    Timestamp endTimestamp = requestToConfirm.get(i).getEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <p class="weui-media-box__desc">需求地点: <%out.print(requestToConfirm.get(i).getAddress());%></p>
                            <p class="weui-media-box__desc">申请者: <%out.print(requestToConfirm.get(i).getApplyUserName());%></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">申请者联系方式: <%out.print(requestToConfirm.get(i).getApplyUserPhone());%></p>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"><p>预估价:</p></div>
                                <div class="weui-flex__item"><p>
                                    <%
                                        Timestamp beginStamp = requestToConfirm.get(i).getBeginTime();
                                        Timestamp endStamp = requestToConfirm.get(i).getEndTime();
                                        long begin = beginStamp.getTime();
                                        long end = endStamp.getTime();

                                        long l = end - begin;
                                        String s = String.valueOf(l);
                                        double d = Double.parseDouble(s);
                                        BigDecimal price = requestToConfirm.get(i).getRequestPrice();
                                        BigDecimal money = price.multiply(new BigDecimal(d/(3600*1000)));

                                        double convertedMoney = money.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                                        out.print(convertedMoney);
                                    %>
                                </p></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/request/handleRequestMatch?handle=refuse&matchID=<%out.print(requestToConfirm.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_default">拒绝</a></div>
                                <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/request/handleRequestMatch?handle=confirm&matchID=<%out.print(requestToConfirm.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_primary">接受</a></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--to_confirm end-->
            
            <!--to_service start-->
            <div class="weui-tab__panel" id="to_service" style="padding-bottom: 50px; padding-top: 70px;display: none">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<requestToService.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务名称/<%out.print(requestToService.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"><%out.print(requestToService.get(i).getApplyUserName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">需求项目: <%out.print(requestToService.get(i).getServiceName());%></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">开始时间:
                                <%
                                    Timestamp beginTimestamp = requestToService.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc"style="color: #7ACF41">结束时间:
                                <%
                                    Timestamp endTimestamp = requestToService.get(i).getEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <p class="weui-media-box__desc">服务地点: <%out.print(requestToService.get(i).getAddress());%></p>
                            <p class="weui-media-box__desc">订单状态:  <%
                                if(requestToService.get(i).getActualBeginTime()==null){
                                    out.print("已确认");
                                }else if(requestToService.get(i).getActualEndTime()==null){
                                    out.print("开始服务");
                                }else{
                                    out.print("结束服务");
                                }
                            %></p>
                        </div>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <div class="weui-flex">
                            <div class="weui-flex__item"><p>预估价:</p></div>
                            <div class="weui-flex__item"><p>
                                <%
                                    Timestamp beginStamp = requestToService.get(i).getBeginTime();
                                    Timestamp endStamp = requestToService.get(i).getEndTime();
                                    long begin = beginStamp.getTime();
                                    long end = endStamp.getTime();

                                    long l = end - begin;
                                    String s = String.valueOf(l);
                                    double d = Double.parseDouble(s);
                                    BigDecimal price = requestToService.get(i).getRequestPrice();
                                    BigDecimal money = price.multiply(new BigDecimal(d/(3600*1000)));

                                    double convertedMoney = money.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                                    out.print(convertedMoney);
                                %>
                            </p></div>
                            <div class="weui-flex__item"display="none"></div>
                            <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/user/startModifyPersonalInfo" class="weui-btn weui-btn_mini weui-btn_primary">二维码</a></div>
                        </div>
                    </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>


                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--to_service end-->
            
            <!--to_pay start-->
            <div class="weui-tab__panel" id="to_pay" style="padding-bottom: 50px; padding-top: 70px;display: none">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<requestToPay.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务名称/<%out.print(requestToPay.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title">价格 <%out.print(requestToPay.get(i).getPayMoney());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">服务对象: <%out.print(requestToPay.get(i).getApplyUserName());%></p>
                            <p class="weui-media-box__desc">开始时间:
                                <%
                                    Timestamp beginTimestamp = requestToPay.get(i).getActualBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc">结束时间:
                                <%
                                    Timestamp endTimestamp = requestToPay.get(i).getActualEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta"><%out.print(requestToPay.get(i).getAddress());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">其他信息</li>
                            </ul>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"> <a class="weui-btn weui-btn_mini weui-btn_primary" href="${pageContext.request.contextPath}<%out.print("/request/requestUserStartPay?matchID="+requestToPay.get(i).getId());%>">支付</a></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--to_pay end-->
            
            <!--completed start-->
            <div class="weui-tab__panel" id="completed" style="padding-bottom: 50px; padding-top: 70px;display: none">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<requestCompleted.size();i++) {
                %>
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单状态</label>
                                <em class="weui-form-preview__value"><%out.print(requestCompleted.get(i).getStatus());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value"><%out.print(requestCompleted.get(i).getId());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务实收款</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        if(requestCompleted.get(i).getStatus().equals("已完成")){
                                            out.print(requestCompleted.get(i).getPayMoney());
                                        }else{
                                            out.print("未进行服务，未产生费用");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务对象:</label>
                                <span class="weui-form-preview__value"><%out.print(requestCompleted.get(i).getApplyUserName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务开始时间:</label>
                                <span class="weui-form-preview__value">
                                     <%
                                         if(requestCompleted.get(i).getStatus().equals("已完成")){
                                             Timestamp beginTimestamp = requestCompleted.get(i).getActualBeginTime();
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
                                         if(requestCompleted.get(i).getStatus().equals("已完成")){
                                             Timestamp endTimestamp = requestCompleted.get(i).getActualEndTime();
                                             Date date2 = new Date(endTimestamp.getTime());
                                             SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                                             out.print(bartDateFormat2.format(date2));
                                         }else{
                                             out.print("未进行服务，无服务时间");
                                         }
                                     %>
                                </span>
                            </div>
                        </div>

                    </div>
                    <div style="background-color: #f8f8f8; height:10px;"></div>
                </div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--completed end-->

        </div>
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">活动</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(function(){
        var panel_published = $("#published"),
            panel_to_confirm = $("#to_confirm"),
            panel_to_service = $("#to_service"),
            panel_to_pay = $("#to_pay"),
            panel_completed = $("#completed");
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("已发布");
            panel_published.show();
            panel_to_confirm.hide();
            panel_to_service.hide();
            panel_to_pay.hide();
            panel_completed.hide();
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("待确认");
            panel_published.hide();
            panel_to_confirm.show();
            panel_to_service.hide();
            panel_to_pay.hide();
            panel_completed.hide();
        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("待服务");
            panel_published.hide();
            panel_to_confirm.hide();
            panel_to_service.show();
            panel_to_pay.hide();
            panel_completed.hide();

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("待付款");
            panel_published.hide();
            panel_to_confirm.hide();
            panel_to_service.hide();
            panel_to_pay.show();
            panel_completed.hide();
        });
        $("#navbar5").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("已完成");
            panel_published.hide();
            panel_to_confirm.hide();
            panel_to_service.hide();
            panel_to_pay.hide();
            panel_completed.show();
        });

        $("#navbar${pageContext.request.getParameter("tab")}").click();

    });
</script>

</body>
</html>

