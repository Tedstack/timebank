<%@ page import="com.blockchain.timebank.entity.RequestEntity" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 26/03/2018
  Time: 14:54
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <title>修改需求</title>
</head>
<body>
<%
    RequestEntity detail = (RequestEntity) request.getAttribute("detail");
%>

<div class="weui-tab">
    <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-left: 5px">
        <div id="return" onclick="history.go(-1)"><img src="../img/返回.png" style="width:20px; height:15px; display: inline-block" alt="">返回</div>
    </div>
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <%--<div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0; padding-left: 15px">
            <div align="center">
                <img class="weui-media-box__thumb" style="width:25%" src="../img/需求名称/<%=detail.getServiceName()%>.png">
                <h2><%=detail.getServiceName()%></h2>
                <p><%=detail.getDescription()%></p>
            </div>
        </div>--%>
        <form action="${pageContext.request.contextPath}/request/update/submit" method="post" onsubmit="return check();">
            <div class="weui-cells" style="margin-top: 40px;">
                <div class="weui-cell" style="padding-left:15px">
                    <h2 style="color:#76b852">修改需求内容</h2>
                </div>
                <input style="display: none;" name="id" value="<%=detail.getId()%>">
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label class="weui-label">需求地址</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" name="address" id="address" placeholder="请输入需求地址" maxlength="300">

                    </div>
                </div>
                <%
                    Date nowDate = new Date();
                    Date nextDate = new Date();
                    nextDate.setTime(nextDate.getTime() + 3600000);
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                    String nowTime = formatter.format(nowDate);
                    String nextTime = formatter.format(nextDate);
                %>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">开始时间</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="beginTime" class="weui-input" name="beginTime" type="datetime-local" value="<%=nowTime%>" placeholder="<%out.print(nowTime);%>" min="<%out.print(nowTime);%>"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">结束时间</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="endTime" class="weui-input" name="endTime" type="datetime-local" value="<%=nextTime%>" placeholder="<%out.print(nextTime);%>" min="<%out.print(nextTime);%>"/>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">需求价格</label>
                    </div>
                    <div class="weui-cell__bd">
                        <%
                        if(detail.getServiceId() / 100 == 1){
                        out.print("<input id=\"servicePrice-update\" value=\"1\" class=\"weui-input\" name=\"price\" type=\"number\" pattern=\"[0-9]*\" placeholder=\"请输入需求价格\" min=\"0\" max=\"200\" style=\"display:none\"/>\n");
                        } else{
                        out.print("<input id=\"servicePrice-update\" class=\"weui-input\" name=\"price\" type=\"number\" pattern=\"[0-9]*\" placeholder=\"请输入需求价格\" min=\"0\" max=\"200\"/>\n");
                        }%>
                    </div>
                    <div class="weui-cell__ft">
                    <span id = "priceUnit-span">
                        <%
                            if(detail.getServiceId() / 100 == 1){
                                out.print("1志愿者时间");
                            } else if(detail.getServiceId() / 100 == 3){
                                out.print("互助时间");
                            } else{
                                out.print("元");
                            }
                        %>/h
                    </span>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">需求描述</label></div>
                    <div class="weui-cell__bd">
                        <div class="weui-cell__bd">
                            <textarea id="serviceDescription-update" class="weui-textarea" name="description" placeholder="请输入描述" rows="3" maxlength="400"><%=detail.getDescription()%></textarea>
                        </div>
                    </div>
                </div>
                <div class="weui-btn-area">
                    <button class="weui-btn weui-btn_primary" type="submit">修改</button>
                </div>
            </div>
        </form>
    </div>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var address = $("#area-select").attr("value");
        $("#area-select option[value='"+address+"']").attr("selected","selected");
    });
    function check() {
        var serviceDescription = document.getElementById("serviceDescription-update").value;
        var beginDate = document.getElementById("beginDate-update").value;
        var endDate = document.getElementById("endDate-update").value;
        var servicePrice = document.getElementById("servicePrice-update").value;
        if (serviceDescription === "") {
            showAlert("请填写需求描述");
            return false;
        }
        if (beginDate === "") {
            showAlert("请填写需求开始日期");
            return false;
        }
        if (endDate === "") {
            showAlert("请填写需求结束日期");
            return false;
        }
        if (servicePrice === "") {
            showAlert("请填写需求价格");
            return false;
        }
        if (beginDate != "" && endDate != "") {
            beginDate = beginDate.replace(/\-/gi, "/");
            endDate = endDate.replace(/\-/gi, "/");
            var beginTime = new Date(beginDate).getTime();
            var endTime = new Date(endDate).getTime();
            if (beginTime > endTime) {
                showAlert("需求结束时间不能早于开始时间");
                return false;
            }
        }
        if (servicePrice < 0) {
            showAlert("需求金额不能为负");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
