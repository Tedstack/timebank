<%@ page import="com.blockchain.timebank.entity.ViewVolunteerRequestMatchDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 02/01/2018
  Time: 21:41
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>待收款</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>

<%
    List<ViewVolunteerRequestMatchDetailEntity> matchDetailList = (List<ViewVolunteerRequestMatchDetailEntity>) request.getAttribute("matchDetailList");
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

<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-cell"style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px">
            <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                <p><img src="../img/返回.png" width="20" height="15"alt="">待支付</p>
            </div>
            <div class="weui-flex__item"></div>
            <div class="weui-flex__item"></div>
        </div>
        <div class="weui-navbar" style="position:fixed; top:34px">
            <div class="weui-navbar__item"id="navbar1">
                已预约
            </div>
            <div class="weui-navbar__item"id="navbar2">
                待服务
            </div>
            <div class="weui-navbar__item weui-bar__item_on"id="navbar3">
                待收款
            </div>
            <div class="weui-navbar__item"id="navbar4">
                已完成
            </div>
        </div>
        <!--tab_pannel为navbar中自带的显示界面详细-->
        <div class="weui-tab">
            <div class="weui-tab__panel" style="padding-bottom: 50px; padding-top: 70px">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<matchDetailList.size();i++) {
                %>
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/服务名称/<%out.print(matchDetailList.get(i).getServiceName());%>.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #7ACF41">价格 <%out.print(matchDetailList.get(i).getPayMoney());%></h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">订单号编号 <%out.print(matchDetailList.get(i).getId());%></p>
                            <p class="weui-media-box__desc">开始时间
                                <%
                                    Timestamp beginTimestamp = matchDetailList.get(i).getActualBeginTime();
                                    Date date = new Date(beginTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat.format(date));
                                %></p>
                            <p class="weui-media-box__desc">结束时间
                                <%
                                    Timestamp endTimestamp = matchDetailList.get(i).getActualEndTime();
                                    Date date2 = new Date(endTimestamp.getTime());
                                    SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                    out.print(bartDateFormat2.format(date2));
                                %></p>
                            <p class="weui-media-box__desc">服务时长
                                <%
                                    Timestamp timestamp = matchDetailList.get(i).getActualBeginTime();
                                    Timestamp timestamp2 = matchDetailList.get(i).getActualEndTime();
                                    long ms = timestamp2.getTime() - timestamp.getTime();

                                    out.print(formatTime(ms/1000));
                                %></p>

                            <ul class="weui-media-box__info">
                                <li class="weui-media-box__info__meta"><%out.print(matchDetailList.get(i).getAddress());%></li>
                                <li class="weui-media-box__info__meta weui-media-box__info__meta_extra">需求人：<%out.print(matchDetailList.get(i).getRequestUserName());%></li>
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
                                <div class="weui-flex__item"> <a class="weui-btn weui-btn_mini weui-btn_primary" href="${pageContext.request.contextPath}<%out.print("/user/applyUserStartPay?recordID="+matchDetailList.get(i).getId());%>">支付</a></div>
                            </div>
                        </div>
                    </div>
                </div>
                <img src="../img/底部.png" width="100%" height="15">
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px;position:fixed">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    //var recordList=<%=matchDetailList%>;
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestMatchAlreadyApply";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestMatchWaitingService";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestMatchWaitingPay";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestMatchAlreadyComplete";
        });

        /*$("#payBtn").on('click',function () {
            //location.href="/user/applyUserPayTimeCoin?recordID="+$("#payBtn").attr("value");
            //alert($("#payBtn").attr("value"));
            $.ajax({
                type: 'POST',
                cache: false,
                url: "http://www.hlb9978.com/user/applyUserPayTimeCoin",
                //dataType:'JSONP',
                data: "recordID=" + $("#payBtn").attr("value"),
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    //alert(data);
                    showAlert("支付成功",function () {
                        goTo("http://www.hlb9978.com/user/queryOrderAlreadyComplete");
                    })
                },
                error: function (xhr, type) {
                    //alert(type);
                    showAlert("支付失败",function () {
                        //goTo("http://www.hlb9978.com/user/queryOrderWaitingPay");
                    })
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });*/
    });
</script>

</body>
</html>
