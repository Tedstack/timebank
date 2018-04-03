<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 02/01/2018
  Time: 13:54
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>需求申请</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>

<%
    ViewRequestDetailEntity detailEntity = (ViewRequestDetailEntity) request.getAttribute("detail");
%>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <form onsubmit="return check()" action="${pageContext.request.contextPath}/request/applySubmit" method="post">
            <div class="weui-cells">
                <input style="display: none" type="number" name="requestUserId" value="<%=detailEntity.getUserId()%>"/>
                <input style="display: none" type="number" name="requestId" value="<%=detailEntity.getId()%>"/>

                <div class="weui-cell">
                    <div class="weui-cell__bd"><label class="weui-label">姓名</label></div>
                    <div class="weui-cell__ft">
                        <p><%out.print(request.getAttribute("name"));%></p>
                    </div>
                </div>


                <div class="weui-cell">
                    <div class="weui-cell__bd"><label class="weui-label">手机号</label></div>
                    <div class="weui-cell__ft">
                        <p><%out.print(request.getAttribute("phone"));%></p>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd"><label class="weui-label">开始时间</label></div>
                    <div class="weui-cell__ft">
                        <%
                            out.print(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(detailEntity.getBeginTime()));
                        %>
                        <input id="service_beginTime" name="beginTime" style="display: none" type="datetime-local" value="<%out.print(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(detailEntity.getBeginTime()));%>"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <label class="weui-label">持续时间</label>
                    </div>
                    <div class="weui-cell__ft">
                        <%
                            BigDecimal sumTime = new BigDecimal((detailEntity.getEndTime().getTime() - detailEntity.getBeginTime().getTime())/3600000);
                            out.print(sumTime+"小时");
                        %>
                        <input name="serveTime" id="select_serveTime" style="display: none" type="number" value="<%out.print(sumTime);%>"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <label class="weui-label">
                            <%
                                String type = "";
                                switch (detailEntity.getServiceType()){
                                    case "volunteer":
                                        type = "志愿者需求";
                                        break;
                                    case "technic":
                                        type = "专业需求";
                                        break;
                                    case "mutualAid":
                                        type = "互助需求";
                                        break;
                                }
                                out.print(type);
                            %>
                        </label>
                    </div>
                    <div class="weui-cell__ft">
                        <p><img src="../img/服务名称/<%out.print(detailEntity.getServiceName());%>.png"
                                                    alt="" style="height:19px;display:inline;vertical-align: text-bottom">
                        <%out.print(detailEntity.getServiceName());%>需求</p>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <label class="weui-label">服务单价(/h)</label>
                    </div>
                    <div class="weui-cell__ft">
                        <span id="eachPrice"><%out.print(detailEntity.getPrice());%></span>
                        <span><%
                            switch (type) {
                                case "志愿者需求":
                                    out.print("（志愿者时间）");
                                    break;
                                case "互助需求":
                                    out.print("（互助时间）");
                                    break;
                                case "专业需求":
                                    out.print("（元）");
                                    break;
                            }
                        %></span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <label class="weui-label">预计付费</label>
                    </div>
                    <div class="weui-cell__ft">
                        <span id="sumPrice">
                            <%
                                out.print(detailEntity.getPrice().multiply(sumTime));
                            %>
                        </span>

                        <span><%
                            switch (type) {
                                case "志愿者需求":
                                    out.print("（志愿者时间）");
                                    break;
                                case "互助需求":
                                    out.print("（互助时间）");
                                    break;
                                case "专业需求":
                                    out.print("（元）");
                                    break;
                            }
                        %></span>
                    </div>
                </div>
            </div>

            <div style="padding: 10px;">
                <button type="submit" class="weui-btn weui-btn_primary">提交订单</button>
            </div>

            <%--</div>--%>

        </form>

    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/request/list?type=volunteer" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">需求柜台</p>
        </a>
        <a href="${pageContext.request.contextPath}/request/applied?tab=1" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">承接的需求</p>
        </a>
        <a href="${pageContext.request.contextPath}/request/published?tab=1" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">发布的需求</p>
        </a>
    </div>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script language="javascript">
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
        $('#select_serveTime').change(function () {
            var sum = $(this).val() * $('#eachPrice').text();
            $('#sumPrice').text(sum);
            console.log($('#eachPrice').text() + " " + sum);
            console.log($(this).val() + " " + $('#eachPrice').val());
        });
    });
    function check(){
        var serviceAddress = document.getElementById("service_address").value;
        var beginDate = document.getElementById("service_beginTime").value.substring(0,10);
        var detailBeginDate = "<%out.print(detailEntity.getBeginTime().toString().substring(0,10));%>";
        var detailEndDate = "<%out.print(detailEntity.getEndTime().toString().substring(0,10));%>";

        if(serviceAddress===""){
            showAlert("请填写上门服务地址");
            return false;
        }
        if(beginDate===""){
            showAlert("请选择服务开始时间");
            return false;
        }
        if(beginDate != ""){
            beginDate = beginDate.replace(/\-/gi,"/");
            detailBeginDate = detailBeginDate.replace(/\-/gi,"/");
            detailEndDate =detailEndDate.replace(/\-/gi,"/");
            var beginTime = new Date(beginDate).getTime();
            var detailBeginTime = new Date(detailBeginDate).getTime();
            var detailEndTime = new Date(detailEndDate).getTime();
            if(beginTime<detailBeginTime){
                showAlert("服务时间不能早于开始时间");
                return false;
            }
            if(beginTime>detailEndTime){
                showAlert("服务时间不能晚于结束时间");
                return false;
            }
        }
        return true;
    }
</script></body>
</html>
