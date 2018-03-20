<%@ page import="com.blockchain.timebank.entity.PublishEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/1/30
  Time: 22:17
  To change this template use File | Settings | File Templates.
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
    <title>修改服务</title>
</head>
<body>
<%
    PublishEntity detail = (PublishEntity) request.getAttribute("detail");
%>

<div class="weui-tab">
    <div class="weui-cell" style="font-size: 15px;background-color: #f8f8f8;position:fixed;width:100%;z-index:1000;padding-left: 5px">
        <div id="return" onclick="history.go(-1)"><img src="../img/返回.png" style="width:20px; height:15px; display: inline-block" alt="">返回</div>
    </div>
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <%--<div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0; padding-left: 15px">
            <div align="center">
                <img class="weui-media-box__thumb" style="width:25%" src="../img/服务名称/<%=detail.getServiceName()%>.png">
                <h2><%=detail.getServiceName()%></h2>
                <p><%=detail.getDescription()%></p>
            </div>
        </div>--%>
        <form action="${pageContext.request.contextPath}/publish/update/submit" method="post" onsubmit="return check();">
        <div class="weui-cells" style="margin-top: 40px;">
            <div class="weui-cell" style="padding-left:15px">
                <h2 style="color:#76b852">修改服务内容</h2>
            </div>
            <input style="display: none;" name="id" value="<%=detail.getId()%>">
            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__hd">
                    <label class="weui-label">服务范围</label>
                </div>
                <div class="weui-cell__bd">
                    <%--黄浦区、徐汇区、长宁区、静安区、普陀区、虹口区、杨浦区、宝山区、闵行区、嘉定区、浦东新区、松江区、金山区、青浦区、奉贤区、崇明区--%>
                    <select class="weui-select" name="address" id="area-select" value="<%=detail.getAddress()%>">
                        <option value="黄浦区">黄浦区</option>
                        <option value="徐汇区">徐汇区</option>
                        <option value="长宁区">长宁区</option>
                        <option value="静安区">静安区</option>
                        <option value="普陀区">普陀区</option>
                        <option value="虹口区">虹口区</option>
                        <option value="杨浦区">杨浦区</option>
                        <option value="宝山区">宝山区</option>
                        <option value="闵行区">闵行区</option>
                        <option value="嘉定区">嘉定区</option>
                        <option value="浦东新区">浦东新区</option>
                        <option value="松江区">松江区</option>
                        <option value="金山区">金山区</option>
                        <option value="青浦区">青浦区</option>
                        <option value="奉贤区">奉贤区</option>
                        <option value="崇明区">崇明区</option>
                    </select>
                </div>
            </div>
            <%
                Date nowDate = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                String nowTime = formatter.format(nowDate);
                SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Timestamp timestampBegin = detail.getBeginDate();
                Date dateBegin = new Date(timestampBegin.getTime());
                Timestamp timestampEnd = detail.getEndDate();
                Date dateEnd = new Date(timestampEnd.getTime());
            %>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">开始日期</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="beginDate-update" class="weui-input" name="beginDate" type="date" value=<%=bartDateFormat.format(dateBegin)%> min=<%out.print(nowTime);%>>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">结束日期</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="endDate-update" class="weui-input" name="endDate" type="date" value=<%=bartDateFormat.format(dateEnd)%> min=<%out.print(nowTime);%>>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">服务价格</label>
                </div>
                <div class="weui-cell__bd">
                    <input id="servicePrice-update" class="weui-input" name="price" type="number" pattern="[0-9]*" value="<%=detail.getPrice()%>" placeholder="请输入价格"/>
                </div>
                <div class="weui-cell__ft">
                    <span id = "priceUnit-span">
                        <%
                            if(detail.getServiceId() / 100 == 1){
                                out.print("志愿者时间");
                            } else if(detail.getServiceId() / 100 == 3){
                                out.print("时间币");
                            } else{
                                out.print("元");
                            }
                        %>/h
                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">服务描述</label></div>
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
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        var address = $("#area-select").attr("value");
        $("#area-select option[value='"+address+"']").attr("selected","selected");
    })

    function check() {
        var serviceDescription = document.getElementById("serviceDescription-update").value;
        var beginDate = document.getElementById("beginDate-update").value;
        var endDate = document.getElementById("endDate-update").value;
        var servicePrice = document.getElementById("servicePrice-update").value;
        if (serviceDescription === "") {
            showAlert("请填写服务描述");
            return false;
        }
        if (beginDate === "") {
            showAlert("请填写服务开始日期");
            return false;
        }
        if (endDate === "") {
            showAlert("请填写服务结束日期");
            return false;
        }
        if (servicePrice === "") {
            showAlert("请填写服务价格");
            return false;
        }
        if (beginDate != "" && endDate != "") {
            beginDate = beginDate.replace(/\-/gi, "/");
            endDate = endDate.replace(/\-/gi, "/");
            var beginTime = new Date(beginDate).getTime();
            var endTime = new Date(endDate).getTime();
            if (beginTime > endTime) {
                showAlert("服务结束时间不能早于开始时间");
                return false;
            }
        }
        if (servicePrice < 0) {
            showAlert("服务金额不能为负");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
