<%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>发布服务</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="http://res.wx.qq.com/open/libs/weui/1.1.2/weui.min.css"/>
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <div class="weui-cells__title">发布志愿者服务</div>
        <form action="/publish/add/submit" method="post">
            <div class="weui-cells weui-cells_form">
                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">服务名称</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="name" type="text" placeholder="请输入服务名称"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">服务描述</label></div>
                    <div class="weui-cell__bd">
                        <div class="weui-cell__bd">
                            <textarea class="weui-textarea" name="description" placeholder="请输入描述" rows="3"></textarea>
                            <div class="weui-textarea-counter"><span>0</span>/200</div>
                        </div>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">开始日期</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="beginDate" type="date" value=""/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">结束日期</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="endDate" type="date" value=""/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">服务价格</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入服务价格"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">服务范围</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="address" type="text" placeholder="精确到区"/>
                    </div>
                </div>

            </div>

            <div style="padding: 10px;">
                <button type="submit" class="weui-btn weui-btn_primary">发布</button>
            </div>
        </form>


    </div>
    <jsp:include page="bottom_tabbar.jsp"/>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>
