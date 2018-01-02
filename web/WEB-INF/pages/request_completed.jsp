<%@ page import="com.blockchain.timebank.entity.ViewVolunteerRequestMatchDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 02/01/2018
  Time: 21:40
--%>
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
</head>
<body>
<%
    List<ViewVolunteerRequestMatchDetailEntity> matchDetailList = (List<ViewVolunteerRequestMatchDetailEntity>) request.getAttribute("matchDetailList");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-bottom:0px;height:34px;">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p style="margin:0"><img src="../img/返回.png" width="20" height="15"alt="">已完成</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>
            <div class="weui-navbar" style="position:fixed; top:34px">
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
                    待付款
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar5" style="color: #7ACF41">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel" style="padding-bottom: 50px; padding-top: 70px">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <%
                    for (int i=0;i<matchDetailList.size();i++) {
                %>
                <div class="page__bd">
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单状态</label>
                                <em class="weui-form-preview__value"><%out.print(matchDetailList.get(i).getStatus());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">订单号</label>
                                <span class="weui-form-preview__value"><%out.print(matchDetailList.get(i).getId());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务实收款</label>
                                <span class="weui-form-preview__value">
                                    <%
                                        if(matchDetailList.get(i).getStatus().equals("已完成")){
                                            out.print(matchDetailList.get(i).getPayMoney());
                                        }else{
                                            out.print("未进行服务，未产生费用");
                                        }
                                    %>
                                </span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务对象:</label>
                                <span class="weui-form-preview__value"><%out.print(matchDetailList.get(i).getApplyUserName());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务开始时间:</label>
                                <span class="weui-form-preview__value">
                                     <%
                                         if(matchDetailList.get(i).getStatus().equals("已完成")){
                                             Timestamp beginTimestamp = matchDetailList.get(i).getActualBeginTime();
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
                                         if(matchDetailList.get(i).getStatus().equals("已完成")){
                                             Timestamp endTimestamp = matchDetailList.get(i).getActualEndTime();
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
                    <div class="weui-cell">
                        <div class="weui-cell__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"><a href="javascript:;" class="weui-btn weui-btn_mini weui-btn_default">举报</a></div>
                                <div class="weui-flex__item">
                                    <%
                                        if(matchDetailList.get(i).getRate()==null){
                                            out.print("<a href='"+ request.getContextPath() +"/user/applyUserStartEvaluate?recordID="+ matchDetailList.get(i).getId()+"' class='weui-btn weui-btn_mini weui-btn_primary'>评价</a>");
                                        }else{
                                            out.print("<a class='weui-btn weui-btn_mini weui-btn_default'>已评</a>");
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                    <img src="../img/底部.png" width="375" height="15">
                </div>
                <%}%>
                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <div class="weui-tabbar" style="height: 50px; position:fixed;">
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
    $(function(){
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestAlreadyPublish";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestWaitingConfirm";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestWaitingService";

        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestWaitingCollect";
        });
        $("#navbar5").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="queryRequestAlreadyComplete";
        });
    });
</script>

</body>
</html>
