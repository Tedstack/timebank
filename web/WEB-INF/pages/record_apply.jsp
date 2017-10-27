<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %><%--
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
    <title>服务申请</title>
    <link rel="stylesheet" href="../css/weui.css"/>
    <link rel="stylesheet" href="../css/weui-example.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css" >>
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <%
            ViewPublishDetailEntity detailEntity = (ViewPublishDetailEntity) request.getAttribute("detail");
        %>

        <form action="/order/apply/submit" method="post">

            <div class="page">

                <input style="display: none" type="number" name="serviceUserId" value="<%=detailEntity.getUserId()%>"/>
                <input style="display: none" type="number" name="publishId" value="<%=detailEntity.getId()%>"/>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">姓名</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="applyUserName" type="text"
                               value="<%out.print(request.getAttribute("name"));%>"/>
                    </div>
                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">手机号</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="applyUserPhone" type="number" pattern="[0-9]*"
                               value="<%out.print(request.getAttribute("phone"));%>"/>
                    </div>
                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd"><label class="weui-label">服务地址</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="address" type="text" placeholder="请输入上门服务地址"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd"><label for="" class="weui-label">开始时间</label></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="beginTime" type="datetime-local" value="" placeholder=""/>
                    </div>
                </div>

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">服务时间</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serveTime">
                            <option value="1">1小时</option>
                            <option value="2">2小时</option>
                            <option value="3">3小时</option>
                            <option value="4">4小时</option>
                            <option value="5">5小时</option>
                            <option value="6">6小时</option>
                            <option value="7">7小时</option>
                            <option value="8">8小时</option>
                            <option value="9">9小时</option>
                            <option value="10">10小时</option>
                        </select>
                    </div>
                </div>

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">支付方式</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="payWay">
                            <%
                                if (detailEntity.getServiceType().equals("志愿者服务")) {
                                    out.print("<option value='1'>志愿者币V</option>");
                                } else {
                                    out.print("<option value='2'>时间币C</option>");
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p><%out.print(detailEntity.getServiceType());%></p>
                    </div>
                    <div class="weui-cell__hd"><img src="../img/服务名称/<%out.print(detailEntity.getServiceName());%>.png"
                                                    alt="" style="width:20px;margin-right:5px;display:block"></div>
                    <div class="weui-cell__ft">
                        <%out.print(detailEntity.getServiceName());%>服务
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>服务单价</p>
                    </div>
                    <div class="weui-cell__ft">
                        <%
                            out.print(detailEntity.getPrice());
                            if (detailEntity.getServiceType().equals("志愿者服务")) {
                                out.print("（志愿者币V/h）");
                            } else {
                                out.print("（时间币C/h）");
                            }
                        %>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>预计付费</p>
                    </div>
                    <div class="weui-cell__ft">
                        12 时间币C
                    </div>
                </div>

                <div style="padding: 10px;">
                    <button type="submit" class="weui-btn weui-btn_primary">提交订单</button>
                </div>

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