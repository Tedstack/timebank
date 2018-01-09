<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>

<%
    ViewPublishDetailEntity detailEntity = (ViewPublishDetailEntity) request.getAttribute("detail");
%>


<div class="weui-tab">
    <div class="weui-tab__panel">

        <form onsubmit="return check()" action="${pageContext.request.contextPath}/record/applySubmit" method="post">

            <%--<div class="page">--%>
            <div class="weui-cells">
                <input style="display: none" type="number" name="serviceUserId" value="<%=detailEntity.getUserId()%>"/>
                <input style="display: none" type="number" name="publishId" value="<%=detailEntity.getId()%>"/>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">姓名</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="applyUserName" type="text"
                               value="<%out.print(request.getAttribute("name"));%>"/>
                    </div>
                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">手机号</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="applyUserPhone" type="number" pattern="[0-9]*"
                               value="<%out.print(request.getAttribute("phone"));%>"/>
                    </div>
                </div>


                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务地址</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="service_address" class="weui-input" name="address" type="text" placeholder="请输入上门服务地址"/>
                    </div>
                </div>

                    <%
                        Date nowDate = new Date();
                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                        String nowTime = formatter.format(nowDate);
                    %>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">开始时间</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="service_beginTime" class="weui-input" name="beginTime" type="datetime-local" value="<%out.print(nowTime);%>" min="<%out.print(nowTime);%>">
                    </div>
                </div>

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务时间</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serveTime" id="select_serveTime">
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

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">支付方式</label>
                    </div>
                    <div class="weui-cell__bd"></div>
                    <div class="weui-cell__ft">
                        <span>
                            <%
                                if (detailEntity.getServiceType().equals("志愿者服务")) {
                                    out.print("志愿者时间");
                                } else if(detailEntity.getServiceType().equals("互助服务")){
                                    out.print("时间币");
                                }else{
                                    out.print("元");
                                }
                            %>
                        </span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label"><%out.print(detailEntity.getServiceType());%></label>
                    </div>
                    <div class="weui-cell__bd"></div>
                    <div class="weui-cell__ft">
                        <img src="../img/服务名称/<%out.print(detailEntity.getServiceName());%>.png" style="height:18px;margin-right:5px;display:inline;vertical-align: text-bottom">
                        <span><%out.print(detailEntity.getServiceName());%>服务</span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务单价</label>
                    </div>
                    <div class="weui-cell__bd"></div>
                    <div class="weui-cell__ft">
                        <span id="eachPrice"><%out.print(detailEntity.getPrice());%>
                            <%
                            if (detailEntity.getServiceType().equals("志愿者服务")) {
                                out.print("（志愿者时间/h）");
                            } else if(detailEntity.getServiceType().equals("互助服务")){
                                out.print("（时间币/h）");
                            } else{
                                out.print("（元/h）");
                            }
                        %></span>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">预计付费</label>
                    </div>
                    <div class="weui-cell__bd"></div>
                    <div class="weui-cell__ft">
                        <span id="sumPrice"><%out.print(detailEntity.getPrice());%></span>

                        <span><%
                            if (detailEntity.getServiceType().equals("志愿者服务")) {
                                out.print("（志愿者时间）");
                            } else if(detailEntity.getServiceType().equals("互助服务")){
                                out.print("（时间币）");
                            } else{
                                out.print("（元）");
                            }
                        %></span>
                    </div>
                </div>
            </div>

            <div class="weui-btn-area">
                <button type="submit" class="weui-btn weui-btn_primary">提交订单</button>
            </div>

            <%--</div>--%>

        </form>

    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">活动</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="margin:0px">我</p>
        </a>
    </div>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script language="javascript">
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
        $('#select_serveTime').change(function () {
            var hours = parseInt($(this).val());
            var eachPrice = parseInt($('#eachPrice').text());
            var sum = hours * eachPrice;
            $('#sumPrice').text(sum);
        });
    });
    function check(){
        var serviceAddress = document.getElementById("service_address").value;
        var beginDate = document.getElementById("service_beginTime").value.substring(0,10);
        var detailBeginDate = "<%out.print(detailEntity.getBeginDate().toString().substring(0,10));%>";
        var detailEndDate = "<%out.print(detailEntity.getEndDate().toString().substring(0,10));%>";

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
            detailBeginDate = detailBeginDate.replace(/\//gi,"-");
            detailEndDate =detailEndDate.replace(/\//gi,"-");
            if(beginTime<detailBeginTime){
                showAlert("服务时间不能早于开始时间 <br/><br/>申请时间范围为：<br/>"+detailBeginDate+" — "+detailEndDate);
                return false;
            }
            if(beginTime>detailEndTime){
                showAlert("服务时间不能晚于结束时间 <br/><br/>申请时间范围为：<br/>"+detailBeginDate+" — "+detailEndDate);
                return false;
            }
        }
        return true;
    }
</script></body>
</html>
