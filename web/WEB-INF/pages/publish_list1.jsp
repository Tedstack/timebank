<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %><%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/23
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
    <meta content="telephone=no,email=no" name="format-detection">
    <title>List</title>
    <script type="text/javascript" async="" src="./service/vds.js.下载"></script>
    <script src="../service/tracker.js.下载"></script>

    <script src="../service/base.js.下载" charset="utf-8"></script>
    <link href="../service/wx_list_v2_v170921.css" rel="stylesheet">
    <style>
        @
        -moz-keyframes nodeInserted {

        from {
            opacity: 0.99;
        }

        to {
            opacity: 1;
        }

        }
        @
        -webkit-keyframes nodeInserted {

        from {
            opacity: 0.99;
        }

        to {
            opacity: 1;
        }

        }
        @
        -o-keyframes nodeInserted {

        from {
            opacity: 0.99;
        }

        to {
            opacity: 1;
        }

        }
        @
        keyframes nodeInserted {

        from {
            opacity: 0.99;
        }

        to {
            opacity: 1;
        }

        }
        embed, object {
            animation-duration: .001s;
            -ms-animation-duration: .001s;
            -moz-animation-duration: .001s;
            -webkit-animation-duration: .001s;
            -o-animation-duration: .001s;
            animation-name: nodeInserted;
            -ms-animation-name: nodeInserted;
            -moz-animation-name: nodeInserted;
            -webkit-animation-name: nodeInserted;
            -o-animation-name: nodeInserted;
        }
    </style>
</head>
<body>
<div>
    <div id="page_load" style="display: none;">
        <div class="pull_up_loading">
            <span><i></i></span> <span>加载中…</span>
        </div>
    </div>
    <div class="wx-header">
        <div class="city-wrap">
            <div class="wx-header-location">
                <div class="box_city">
                    <span>志愿者服务</span> <i class="arrow-down"></i>
                </div>
                <div class="box_invest">
                    <span class="btn"></span>
                </div>
            </div>
        </div>
    </div>
    <div class="header-hidden"
         style="height: 87px; background-color: rgb(46, 49, 50);"></div>
    <div>
        <div class="filter-main" style="top: 44px;">
            <div class="filter">
                <ul>
                    <li class="sort-tab"><span class="filter-title">综合排序</span> <span
                            class="icon-arrow"></span></li>
                    <li class="filter-tab"><span class="filter-title">筛选</span> <span
                            class="icon-arrow"></span></li>
                </ul>
            </div>
        </div>
        <!-- 下拉显示还没弄 -->
        <div class="op-mask" style="display: none;"></div>
        <div class="filter-detail" style="padding-top: 86px; display: none;">
            <div class="filter-wrap">
                <ul class="filter-sort move">
                    <li class="active">综合排序</li>
                    <li class="">销量最高</li>
                    <li class="">评价最好</li>
                    <li class="">离我最近</li>
                    <li class="">价格由低到高</li>
                    <li class="">价格由高到低</li>
                </ul>
            </div>
        </div>
        <!---->
    </div>
    <div style="">
        <ul class="list_pet">

            <%
                List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>) request.getAttribute("list");
                for (ViewPublishDetailEntity viewPublishEntity : list) {
            %>
            <li class="">
                <div class="picbox"
                     style="background-image: url(&quot;https://images.daojia.com/dop/custom/7fea3b27212c357b458019fd69aa5b50.jpg@330w_246h&quot;);"></div>
                <div class="list-main">
                    <div class="tit">
                        <span class="title_name" style="text-indent: 0px;"><a href="./order.html"> <%
                            out.print(viewPublishEntity.getServiceName());%></a></span>
                    </div>
                    <div class="evaluate-info clearfix">
                    </div>
                    <div class="price clearfix">
							<span class="pri_now"><span class="rmb">¥</span><span><%
                                out.print(viewPublishEntity.getPrice());%></span></span>

                    </div>
                    <div class="store-info">
                        <div class="info"><%out.print(viewPublishEntity.getUserName());%></div>
                        <div class="order-rate"><%out.print(viewPublishEntity.getAddress());%></div>
                    </div>
                </div>
            </li>

            <%}%>
            <li id="list1" class="">
                <div class="picbox"
                     style="background-image: url(&quot;https://images.daojia.com/dop/custom/7e65cc6af37c2307a0f0f0d701927042.jpg@330w_246h&quot;);"></div>
                <div class="list-main">

                    <div class="store-info">
                        <div class="tit">
                            <!---->
                            <span class="title_name" style="text-indent: 0px;">xx服务</span>
                        </div>
                        <div class="evaluate-info clearfix">
                            <!---->
                            <!---->
                            <!---->
                        </div>
                        <div class="price clearfix">
							<span class="pri_now"><span class="rmb">¥</span><span>200</span>
                                <!----></span>

                        </div>
                        <div class="store-info">
                            <div class="info">xxx</div>
                            <div class="order-rate">长宁区</div>
                        </div>
                    </div>
            </li>

            <li id="list2" class="">
                <div class="picbox"
                     style="background-image: url(&quot;https://images.daojia.com//dop2c/discovery/670e9871bf1983e9528c4e3943789a52.jpeg@330w_246h&quot;);"></div>
                <div class="list-main">
                    <div class="tit">
                        <!---->
                        <span class="title_name" style="text-indent: 0px;">xx服务</span>
                    </div>
                    <div class="evaluate-info clearfix">
                        <!---->
                        <!---->
                        <!---->
                    </div>
                    <div class="price clearfix">
							<span class="pri_now"><span class="rmb">¥</span><span>30</span>
                                <!----></span>
                        <!---->
                        <!---->
                        <!---->
                        <!---->
                    </div>
                    <div class="store-info">
                        <div class="info">xxx</div>
                        <div class="order-rate">静安区</div>
                    </div>
                </div>
            </li>
            <li id="list3" class="noBottom">
                <div class="picbox"
                     style="background-image: url(&quot;https://images.daojia.com/dop/custom/ace0f908908b9fec8541f7f714b7608f.jpg@330w_246h&quot;);"></div>
                <div class="list-main">
                    <div class="tit">
							<span
                                    class="title_name" style="text-indent: 0px;">xx服务</span>
                    </div>
                    <div class="evaluate-info clearfix">
                        <!---->
                        <!---->
                        <!---->
                    </div>
                    <div class="price clearfix">
							<span class="pri_now"><span class="rmb">¥</span><span>30</span>
                                <!----></span>
                        <!---->
                        <!---->
                        <!---->
                        <!---->
                    </div>
                    <div class="store-info">
                        <div class="info">xxx</div>
                        <div class="order-rate">普陀区</div>
                    </div>
                </div>
            </li>
        </ul>
        <div class="loadmore-box" style="display: none;">
            <div class="pull_up_loading_more">

            </div>
        </div>
    </div>
    <!-- href要改  -->
    <ul class="invite-wrap">
        <li><i><img
                src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFoAAABaCAYAAAA4qEECAAAAAXNSR0IArs4c6QAABP1JREFUeAHt3U+I3FQYAPDvZTK7Le5lFAUV6h8QBAtKXSg7XSie3FNXEXtQodqulv0jSu2hiNLSi1CFrjhdOyt486AIRZG9eZrZloriSQXr365W0LoFW23tdvL83raJmeTLzKJ5yXvJl0ve+/Ly5eXHm2T+JBkAnliABViABViABVggCwHRbyOttyfvhCvOtJDyQQlwO0h5Xb91TFouBKxICZ+7bmXPyERjMa++9YRuN6dfBPD2Y0cH8upgetsVFxxXbNwyceTH9HKuPZOb1HTx6NSsJ73nkpbbF5dDsiMexn7PptX39vzMNvA6ezFfDYT4yKkNHqxvP3yRyk9CL87PPOJ5nQIhU7v+/2Kt5tQL0uu8FmSRcqN37tIGrD8exEIFJ1QOioj8SlApTEFcEBU4lsbuKGQ8V/2LfC0pHmIfa70zWaO2EYNuH50ZxoZ3UY1tjKmTIfb7E9d1xtI4Prfnp/ZSyL6NuFRZ75fD8/ihQ3j3A769iE1CfD3gOGObn258H1tWkoBClp58NWl3hRAnRnc1zlDLYyMaG91ENRQg32fkZGQ8Gf4kq/IJyk7FYiMaB3OFaixBqJdgKaerJ77eyJUKPFDf+eZ3SUDUiE5qW8p40okvwMCRvIo8MfdNECMKDE2g+KG0kFU+hvZVI/M0kRk6gutX00ZmaF82NNeBzNAhYFXUhczQIWidyAx9DVo3MkOjQBbIpYfOCrnU0FkilxY6a+RSQueBXDrovJBLBZ0ncmmg80YuBbQJyIWHzhL5i/cODHzafP5mhUpNhf0+OkvkdnPq5eXlX/+4KP8+g+WvTjSnN0WxCwmdJXKrOfmolPIggBxUuFi+uwPesVMLz67WffDCQWeJrBAFiG0+pj/HC2k2nF3y7vPral4o6KyRVyElXB8G9csdB27wy2peGOhckMOSfcqFgDYduRAj2gZk66FtQbYaut9VnepauLVcQdTn0JraYiuP0f2u6jQN2coRbSOyddC2IlsFbTOyNdC2I1sBXQRk46GLgmw0dJGQjYUuGrKR0Mebkw/1usXMxA8jCrLfZNwnww6IfYmdNuxjdWI/iQXGQePjFrq+MA/6bDGy2gfjoPE+x4UA1y9YjmwktHCHXsL7tz/0jfGYfBKqcmu9z318QXtDC7E7Z/Pu5+iuQ+exD+PqGomVARgceWr2h7z7lMb2jYP2d2p49+wvfrkIc+OO0UVApfaBoSkVDTGG1oBKpWRoSkVDjKE1oFIpGZpS0RBjaA2oVEqGplQ0xBhaAyqVkqEpFQ0xhtaASqVkaEpFQ4yhNaBSKRmaUtEQY2gNqFRKhqZUNMQYWgMqlZKhKRUNsRg03qD4J7kdCbeQ8dIH5a0UgSO9LsfYb4b4C/QS3vkZm4SQT7bmp8/jQ7wTH90bW6nAAXyeNv5jCtQlyHup3ey4sBSOx6DXu87Hf13Gi7JAdo12TFoF6e0Jr1zmMjEWAw4crN+ORp4l3YWpWm7a+cZvmOTdYC0u/AcBpxFdKQatGghR3Yd3k5+NNub6GgQEfFar3TgXbUlCj+5+/XRFiHF8CSxHV+B6T4EvK+vWjd+z/cDlaCsSWjWqPzN3vOpUhvFdyAfRlbjeLYADcgX/saJRHXJH6jsO/9y99Gqt539l+SucfGvmjiueHPOEd5uQMOTHyz1HCYBzCHzKHYSFzTuO/F5uD957FmABFmABFmABMwT+AScUOpVgoC5KAAAAAElFTkSuQmCC"

                alt=""></i><a href="./login.html"> 免费入驻，发布服务</a></li>
    </ul>
</div>
</body>
</html>