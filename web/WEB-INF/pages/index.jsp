<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>首页</title>
    <link rel="stylesheet" href="css/weui.css">
    <link rel="stylesheet" href="css/weui-example.css">
    <%--<link rel="stylesheet" href="css/bootstrap.min.css">--%>
    <%--<link rel="stylesheet" href="css/bootstrap-touch-slider.css" media="all">--%>
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">

            <%--<!--图片轮转-->--%>
            <%--<div id="bootstrap-touch-slider" class="carousel bs-slider fade  control-round indicators-line"--%>
                 <%--data-ride="carousel" data-pause="hover" data-interval="5000">--%>

                <%--<!-- Indicators -->--%>
                <%--<ol class="carousel-indicators">--%>
                    <%--<li data-target="#bootstrap-touch-slider" data-slide-to="0" class="active"></li>--%>
                    <%--<li data-target="#bootstrap-touch-slider" data-slide-to="1"></li>--%>
                    <%--<li data-target="#bootstrap-touch-slider" data-slide-to="2"></li>--%>
                <%--</ol>--%>

                <%--<!-- Wrapper For Slides -->--%>
                <%--<div class="carousel-inner" role="listbox">--%>

                    <%--<!-- first Slide -->--%>
                    <%--<div class="item active">--%>

                        <%--<!-- Slide Background -->--%>
                        <%--<img src="img/slider/slide1.png" alt="Bootstrap Touch Slider" class="slide-image"/>--%>
                        <%--<div class="bs-slider-overlay"></div>--%>
                    <%--</div>--%>
                    <%--<!-- End of Slide -->--%>

                    <%--<!-- Second Slide -->--%>
                    <%--<div class="item">--%>

                        <%--<!-- Slide Background -->--%>
                        <%--<img src="img/slider/slide2.png" alt="Bootstrap Touch Slider" class="slide-image"/>--%>
                        <%--<div class="bs-slider-overlay"></div>--%>
                        <%--<!-- Slide Text Layer -->--%>
                    <%--</div>--%>
                    <%--<!-- End of Slide -->--%>

                    <%--<!-- Third Slide -->--%>
                    <%--<div class="item">--%>

                        <%--<!-- Slide Background -->--%>
                        <%--<img src="img/slider/slide3.png" alt="Bootstrap Touch Slider" class="slide-image"/>--%>
                        <%--<div class="bs-slider-overlay"></div>--%>
                        <%--<!-- Slide Text Layer -->--%>
                    <%--</div>--%>
                    <%--<!-- End of Slide -->--%>


                <%--</div><!-- End of Wrapper For Slides -->--%>

                <%--<!-- Left Control -->--%>
                <%--<a class="left carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="prev">--%>
                    <%--<span class="fa fa-angle-left" aria-hidden="true"></span>--%>
                    <%--<span class="sr-only">Previous</span>--%>
                <%--</a>--%>

                <%--<!-- Right Control -->--%>
                <%--<a class="right carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="next">--%>
                    <%--<span class="fa fa-angle-right" aria-hidden="true"></span>--%>
                    <%--<span class="sr-only">Next</span>--%>
                <%--</a>--%>

            <%--</div> <!--图片轮转结束-->--%>
            <%--<div class="weui-cell">--%>
                <%--<div class="weui-cell__hd"><img src="img/服务名称/所有服务.png" alt="" style="width:20px;margin-right:5px;display:block"></div>--%>
                <%--<div class="weui-cell__bd" style="color: #7ACF41">--%>
                    <%--<p>所有服务</p>--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="weui-grids">
                <a href="${pageContext.request.contextPath}/publish/list?type=志愿者服务" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/服务类型/志愿者服务.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        志愿者服务
                    </p>
                </a>

                <a href="${pageContext.request.contextPath}/publish/list?type=互助服务" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/服务类型/互助.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        互助服务
                    </p>
                </a>

                <a href="${pageContext.request.contextPath}/publish/list?type=专业服务" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/服务类型/专业.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        专业服务
                    </p>
                </a>

                <a href="${pageContext.request.contextPath}/request/list?type=volunteer" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/服务类型/志愿者服务.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        志愿者需求
                    </p>
                </a>

                <a href="${pageContext.request.contextPath}/request/list?type=mutualAid" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/服务类型/互助.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        互助需求
                    </p>
                </a>

                <a href="${pageContext.request.contextPath}/request/list?type=technic" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/服务类型/专业.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        专业需求
                    </p>
                </a>

                <a href="${pageContext.request.contextPath}/team/teamActivities" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/userdetails/专业服务认证.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        团队活动
                    </p>
                </a>
                <%--<a href="${pageContext.request.contextPath}/publish/list?type=社区O2O服务" class="weui-grid">
                    <div class="weui-grid__icon">
                        <img src="img/服务类型/社区O2O.png" alt="">
                    </div>
                    <p class="weui-grid__label">
                        社区O2O服务
                    </p>
                </a>--%>
            </div>
        </div>




    </div>
<div class="weui-tabbar" style="height: 50px">
    <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
        <img src="img/首页.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">首页</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
        <img src="img/服务.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">服务</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
        <img src="img/活动.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">活动</p>
    </a>
    <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
        <img src="img/我的.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">我</p>
    </a>
</div>
</div>


<script src="js/jquery/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/bootstrap/bootstrap.min.js"></script>
<script src="js/bootstrap/jquery.touchSwipe.min.js"></script>
<script src="js/bootstrap/bootstrap-touch-slider.js"></script>

<script type="text/javascript" class="searchbar js_show">
    $(function () {
        var $searchBar = $('#searchBar'),
            $searchResult = $('#searchResult'),
            $searchText = $('#searchText'),
            $searchInput = $('#searchInput'),
            $searchClear = $('#searchClear'),
            $searchCancel = $('#searchCancel');

        function hideSearchResult() {
            $searchResult.hide();
            $searchInput.val('');
        }

        function cancelSearch() {
            hideSearchResult();
            $searchBar.removeClass('weui-search-bar_focusing');
            $searchText.show();
        }

        $searchText.on('click', function () {
            $searchBar.addClass('weui-search-bar_focusing');
            $searchInput.focus();
        });
        $searchInput
            .on('blur', function () {
                if (!this.value.length) cancelSearch();
            })
            .on('input', function () {
                if (this.value.length) {
                    $searchResult.show();
                } else {
                    $searchResult.hide();
                }
            })
        ;
        $searchClear.on('click', function () {
            hideSearchResult();
            $searchInput.focus();
        });
        $searchCancel.on('click', function () {
            cancelSearch();
            $searchInput.blur();
        });
    });
</script>

<script>
    $('#bootstrap-touch-slider').bsTouchSlider();
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(0)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>