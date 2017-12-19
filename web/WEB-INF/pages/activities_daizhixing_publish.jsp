<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/8
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>RateTest</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-tab">
            <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">待执行</p>
                </div>
                <div class="weui-flex__item"></div>
                <div class="weui-flex__item"></div>
            </div>
            <div class="weui-navbar">
                <div class="weui-navbar__item "id="navbar1">
                    待申请
                </div>
                <div class="weui-navbar__item weui-bar__item_on"id="navbar2">
                    待执行
                </div>
                <div class="weui-navbar__item "id="navbar3">
                    已完成
                </div>
            </div>
            <!--tab_pannel为navbar中自带的显示界面详细-->
            <div class="weui-tab__panel">
                <!--以下为界面显示部分，需要循环的部分，以下可修改-->
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/userdetails/专业服务认证.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #7ACF41">待执行活动2</h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">活动内容详情显示1 </p>
                            <p class="weui-media-box__desc">详情显示2</p>
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
                            <div class="weui-flex__item"> <a class="weui-btn weui-btn_mini weui-btn_primary" href="${pageContext.request.contextPath}/team/startActivities">开始</a></div>
                        </div>
                    </div>
                </div>
                <img src="../img/底部.png" width="375" height="15">
                <div class="weui-panel__bd">
                    <div class="weui-media-box weui-media-box_appmsg">
                        <div class="weui-media-box__hd">
                            <img class="weui-media-box__thumb" width="60" height="60"src="../img/userdetails/专业服务认证.png" alt="">
                        </div>
                        <div class="weui-media-box__bd">
                            <div class="weui-flex">
                                <div class="weui-flex__item"diaplay="none"><h4 class="weui-media-box__title"style="color: #7ACF41">待执行活动2</h4></div>
                                <div class="weui-flex__item"display="none"></div>
                                <div class="weui-flex__item"display="none"></div>
                            </div>
                            <p class="weui-media-box__desc">活动内容详情显示1 </p>
                            <p class="weui-media-box__desc">详情显示2</p>
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
                            <div class="weui-flex__item"> <a class="weui-btn weui-btn_mini weui-btn_primary" href="${pageContext.request.contextPath}/team/startActivities">开始</a></div>
                        </div>
                    </div>
                </div>
                <img src="../img/底部.png" width="375" height="15">

                <!--一个订单详情结束，以上可修改-->
            </div>
            <!--weui-tab_panel的结束位置-->
        </div>
    </div>
    <div class="weui-tabbar">
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
            location.href="${pageContext.request.contextPath}/record/daishenqing_activities";
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/record/daizhixing_activities_publish";

        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            location.href="${pageContext.request.contextPath}/record/yiwancheng_activities_publish";

        });
    });
</script>

</body>
</html>