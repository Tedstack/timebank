<%@ page import="com.blockchain.timebank.entity.ViewRequestOrderDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.blockchain.timebank.weixin.util.FormatOrderIdUtil" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 05/01/2018
  Time: 16:27
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>已预约</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <link rel="stylesheet" href="../css/Item.css"/>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
    <style>
        .weui-bar__item_on{
            color: #7ACF41
        }
    </style>
    <script src="../js/utils.js"></script>
</head>
<body>
<div class="main-container">
    <div class="main-content">
<div class="page">
    <%
        List<ViewRequestOrderDetailEntity> requestApplied = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestApplied");
        List<ViewRequestOrderDetailEntity> requestToService = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestToService");
        List<ViewRequestOrderDetailEntity> requestToPay = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestToPay");
        List<ViewRequestOrderDetailEntity> requestCompleted = (List<ViewRequestOrderDetailEntity>) request.getAttribute("requestCompleted");
    %>
    <%!
        String formatTime(Long ms){
            Integer mi = 60;
            Integer hh = mi * 60;
            Integer dd = hh * 24;

            Long day = ms / dd;
            Long hour = (ms - day * dd) / hh;
            Long minute = (ms - day * dd - hour * hh) / mi;
            Long second = (ms - day * dd - hour * hh - minute * mi) ;
            //Long milliSecond = ms - day * dd - hour * hh - minute * mi - second * ss;

            StringBuffer sb = new StringBuffer();
            if(day > 0) {
                sb.append(day+"天");
            }
            if(hour > 0) {
                sb.append(hour+"小时");
            }
            if(minute > 0) {
                sb.append(minute+"分");
            } else {
                sb.append(0+"分");
            }
            if(second > 0) {
                sb.append(second+"秒");
            } else {
                sb.append(0+"秒");
            }

            return sb.toString();
        }
    %>

    <div class="page__bd" style="height: 100%;">
        <div class="weui-navbar">
            <div class="weui-navbar__item weui-bar__item_on" id="navbar1">
                已预约
            </div>
            <div class="weui-navbar__item" id="navbar2">
                待服务
            </div>
            <div class="weui-navbar__item" id="navbar3">
                待收款
            </div>
            <div class="weui-navbar__item" id="navbar4">
                已完成
            </div>
        </div>
        <!--tab_pannel为navbar中自带的显示界面详细-->
        <div class="weui-tab">
            
            <!--applied start-->
            <div class="weui-tab__panel" id="applied" style="padding-bottom: 50px; padding-top: 70px;display: block">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                
                <%
                    for (int i=0;i<requestApplied.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60" src="../img/服务名称/<%out.print(requestApplied.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"><%out.print(requestApplied.get(i).getServiceName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">订单编号: <%out.print(requestApplied.get(i).getId());%></p>
                            <p class="weui-media-box__desc">需求人员: <%out.print(requestApplied.get(i).getRequestUserName());%></p>
                            <p class="weui-media-box__desc"style="color: #7ACF41">开始时间:
                                <%
                                    Timestamp beginTimestamp = requestApplied.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc"style="color: #7ACF41">结束时间:
                                <%
                                    Timestamp endTimestamp = requestApplied.get(i).getEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <p class="weui-media-box__desc">需求地点:<%out.print(requestApplied.get(i).getAddress());%></p>
                            <p class="weui-media-box__desc">需求人手机号:<%out.print(requestApplied.get(i).getRequestUserPhone());%></p>
                        </div>


                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <%if(requestApplied.get(i).getEndTime().getTime() < new Date().getTime()){%>
                            <p class="weui-tabbar__label" style="float:right;color:#999;font-size:16px">申请已过期</p>
                            <%}else {%>
                            <p class="weui-tabbar__label" style="float:right;color:#76b852;font-size:16px">等待接受申请</p>
                            <%}%>
                        </div>
                    </div>
                    <%--<div class="weui-cell">--%>
                    <%--<div class="weui-cell__bd">--%>
                    <%--<div class="weui-flex">--%>
                    <%--<div class="weui-flex__item"diaplay="none"></div>--%>
                    <%--<div class="weui-flex__item"display="none"></div>--%>
                    <%--<div class="weui-flex__item"display="none"></div>--%>
                    <%--<div class="weui-flex__item"><a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_primary">删除</a></div>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <%--</div>--%>
                </div>
                <div style="background-color: #f8f8f8; height:10px;"></div>


                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--applied end-->
            
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
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"><%out.print(requestToService.get(i).getServiceName());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">订单编号 <%out.print(requestToService.get(i).getId());%></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">开始时间
                                <%
                                    Timestamp beginTimestamp = requestToService.get(i).getBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">结束时间
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
                            <p class="weui-media-box__desc">需求者: <%out.print(requestToService.get(i).getRequestUserName());%></p>
                            <p class="weui-media-box__desc" style="color: #7ACF41">联系方式: <%out.print(requestToService.get(i).getRequestUserPhone());%></p>

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
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"><a href="${pageContext.request.contextPath}/request/requestApplyUserStartScan?matchID=<%out.print(requestToService.get(i).getId());%>" class="weui-btn weui-btn_mini weui-btn_primary">扫码</a></div>
                            </div>
                        </div>
                    </div>

                </div>

                <div style="background-color: #f8f8f8; height:10px;"></div>
                <br/>
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
                            <%
                                String moneyType = null;
                                switch ((String) requestToPay.get(i).getServiceType()){
                                    case "volunteer":
                                        moneyType = "志愿者时间";
                                        break;
                                    case "technic":
                                        moneyType = "元";
                                        break;
                                    case "mutualAid":
                                        moneyType = "时间币";
                                        break;
                                }
                            %>
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务名称/<%out.print(requestToPay.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #7ACF41">价格 <%out.print(requestToPay.get(i).getPayMoney() + "(" + moneyType + ")");%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">订单号编号: <%out.print(FormatOrderIdUtil.getRequestOrderFormatId(requestToPay.get(i)));%></p>
                            <p class="weui-media-box__desc">需求项目: <%out.print(requestToPay.get(i).getServiceName());%></p>
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
                            <p class="weui-media-box__desc">服务时长:
                                <%
                                    Timestamp timestamp = requestToPay.get(i).getActualBeginTime();
                                    Timestamp timestamp2 = requestToPay.get(i).getActualEndTime();
                                    long ms = timestamp2.getTime() - timestamp.getTime();

                                    out.print(formatTime(ms/1000));
                                %></p>

                            <ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta"><%out.print(requestToPay.get(i).getAddress());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">需求人:<%out.print(requestToPay.get(i).getRequestUserName());%></li>
                            </ul>

                        </div>
                    </div>

                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <%
                            if(requestToPay.get(i).getServiceId() / 100 == 2){
                                out.print("<a class='weui-btn weui-btn_mini weui-btn_primary' style='float:right' id='ensurePay-btn' name ='" + requestToPay.get(i).getId() +"'>确认收款</a>");
                            }
                        %>
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
                                <label class="weui-form-preview__label">需求状态</label>
                                <em class="weui-form-preview__value" style="color: #7ACF41"><%out.print(requestCompleted.get(i).getStatus());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">需求名称</label>
                                <span class="weui-form-preview__value"><%out.print(requestCompleted.get(i).getServiceName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务收费</label>
                                <span class="weui-form-preview__value" style="color: #7ACF41"><%
                                    if(requestCompleted.get(i).getStatus().equals("已完成")){
                                        out.print(requestCompleted.get(i).getPayMoney());
                                    }else{
                                        out.print("未进行服务，未产生费用");
                                    }
                                %></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value"><%out.print(FormatOrderIdUtil.getRequestOrderFormatId(requestCompleted.get(i)));%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">需求者</label>
                                <span class="weui-form-preview__value"><%out.print(requestCompleted.get(i).getRequestUserName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务时间</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        if(requestCompleted.get(i).getStatus().equals("已完成")){
                                            Timestamp beginTimestamp = requestCompleted.get(i).getActualBeginTime();
                                            Date date = new Date(beginTimestamp.getTime());
                                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                                            Timestamp endTimestamp = requestCompleted.get(i).getActualEndTime();
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
                                <span class="weui-form-preview__value"><%out.print(requestCompleted.get(i).getAddress());%></span>
                            </div>

                        </div>
                    </div>
                </div>

                <div style="background-color: #f8f8f8; height:10px;"></div>

                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--completed end-->
            
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/request/list?type=volunteer" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">需求柜台</p>
        </a>
        <a href="${pageContext.request.contextPath}/request/applied?tab=1" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">我承接的需求</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyPublish" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我发布的服务</p>
        </a>
    </div>
</div>
    </div>
    <button class="float-button" style="font-size: xx-large;" id="create">+
    </button>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var url='${pageContext.request.contextPath}';
    $("#create").on("click", function() {
        goTo(url+"/publish/add");
    });
    $(function(){
        var panel_applied = $("#applied"),
            panel_to_service = $("#to_service"),
            panel_to_pay = $("#to_pay"),
            panel_completed = $("#completed");

        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("已预约");
            panel_applied.show();
            panel_to_service.hide();
            panel_to_pay.hide();
            panel_completed.hide();
            window.history.pushState('','','?tab=1');
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("待服务");
            panel_applied.hide();
            panel_to_service.show();
            panel_to_pay.hide();
            panel_completed.hide();
            window.history.pushState('','','?tab=2');
        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("待收款");
            panel_applied.hide();
            panel_to_service.hide();
            panel_to_pay.show();
            panel_completed.hide();
            window.history.pushState('','','?tab=3');
        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("title").html("已完成");
            panel_applied.hide();
            panel_to_service.hide();
            panel_to_pay.hide();
            panel_completed.show();
            window.history.pushState('','','?tab=4');
        });

        $("#navbar${pageContext.request.getParameter("tab")==null?1:pageContext.request.getParameter("tab")}").click();

        $("#ensurePay-btn").on('click', function () {
            var contextPath="${pageContext.request.contextPath}";
            var orderID = $(this).attr("name");
            console.log(orderID);
            var targetUrl = "${pageContext.request.contextPath}/request/updateOrderToComplete";
            var targetUrl2 = "${pageContext.request.contextPath}/request/applied?tab=4";
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                //dataType:'JSONP',
                data: "orderID=" + orderID,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    //alert(data);
                    showAlert("确认收款成功",function () {
                        goTo(targetUrl2);
                    })
                },
                error: function (xhr, type) {
                    //alert(type);
                    showAlert("确认收款失败",function () {
                        //goTo("http://www.hlb9978.com/user/queryOrderWaitingPay");
                    })
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
            //goTo(targetUrl2);
        });
    });


</script>

</body>
</html>

