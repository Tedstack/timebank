<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="java.util.*" %>
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
    <title>发布服务</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body onload="checkSurplus()">

<%
    Map<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
    List<ServiceEntity> list = (List<ServiceEntity>) request.getAttribute("service_list");
    for (ServiceEntity service : list) {
        if (!map.containsKey(service.getType())) map.put(service.getType(), new ArrayList<String>());
        map.get(service.getType()).add(service.getName());
    }
    boolean surplus = (boolean)request.getAttribute("surplus");
%>

<div class="weui-tab">
    <div class="weui-tab__panel">
        <form action="${pageContext.request.contextPath}/publish/add/submit" method="post" onsubmit="return check();">
            <div class="weui-cells__title">发布服务</div>

            <div class="weui-cells">

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务类型</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceType" id = "addServiceType">
                            <%
                                for (String type : map.keySet()) {
                                    out.print("<option value='" + type + "'>" + type + "</option>");
                                }
                            %>
                            <%--<option value="2">志愿者服务</option>--%>
                            <%--<option value="3">专业服务</option>--%>
                            <%--<option value="4">社区O2O服务</option>--%>
                        </select>
                    </div>
                </div>

                <%
                    for (String type : map.keySet()) {
                        List<String> names = map.get(type);
                %>

                <div class="weui-cell weui-cell_select weui-cell_select-after weui-name" id="<%out.print(type);%>">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务名称</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceName">
                            <%
                                for (String name : names) {
                                    out.print("<option value='" + name + "'>" + name + "</option>");
                                }
                            %>
                        </select>
                    </div>
                </div>

                <%
                    }
                %>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务描述</label></div>
                    <div class="weui-cell__bd">
                        <div class="weui-cell__bd">
                            <textarea id="serviceDescription" class="weui-textarea" name="description" placeholder="请输入描述" rows="3" maxlength="400" oninput="checkLen(this)"></textarea>
                            <div style="float:right; color:#999"><span id="description-count">0</span>/200</div>
                        </div>
                    </div>
                </div>

                <%
                    Date nowDate = new Date();
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String nowTime = formatter.format(nowDate);
                %>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">开始日期</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="beginDate" class="weui-input" name="beginDate" type="date" value="" min=<%out.print(nowTime);%>>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">结束日期</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="endDate" class="weui-input" name="endDate" type="date" value="" min=<%out.print(nowTime);%>>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务价格</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input id="servicePrice" class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入服务价格"/>
                    </div>
                    <div class="weui-cell__ft">
                        <span id = "priceUnit-span">志愿者时间/h</span>
                    </div>
                </div>

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label class="weui-label">服务范围</label>
                    </div>
                    <div class="weui-cell__bd">
                        <%--黄浦区、徐汇区、长宁区、静安区、普陀区、虹口区、杨浦区、宝山区、闵行区、嘉定区、浦东新区、松江区、金山区、青浦区、奉贤区、崇明区--%>
                        <select class="weui-select" name="address">
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

            </div>

            <div class="weui-btn-area">
                <%if(!surplus){%>
                    <button class="weui-btn weui-btn_primary" type="submit">发布</button>
                <%}else{%>
                    <button class="weui-btn weui-btn_primary" type="submit" style="background-color: #999; color:#fff; border:0px;display: none;text-decoration:none;" onclick="return false;">发布</button>
                <%}%>
            </div>
        </form>


    </div>
    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">首页</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;">服务</p>
        </a>
        <a href="${pageContext.request.contextPath}/publish/activities_category" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">活动</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
            <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我</p>
        </a>
    </div>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
        $('.weui-name:gt(0)').hide();$('.weui-name:gt(0)').find('.weui-select').attr("name","");
        $('.weui-select:eq(0)').change(function () {
            $('.weui-name').hide();$('.weui-name').find('.weui-select').attr("name","");
            $('#'+$(this).val()).show();$('#'+$(this).val()).find('.weui-select').attr("name","serviceName");
        });
       $("#addServiceType").change(function () {
           var type = $(this).val();
           if(type === "志愿者服务"){
               $("#priceUnit-span").html("志愿者时间/h");
           } else if(type === "互助服务"){
               $("#priceUnit-span").html("时间币/h");
           } else
               $("#priceUnit-span").html("元/h");
       });
    });

    function getLength(str) {
        return str.replace(/[^ -~]/g, 'AA').length;
    }

    function limitMaxLength(str, maxLength) {
        var result = [];
        for (var i = 0; i < maxLength; i++) {
            var char = str[i]
            if (/[^ -~]/.test(char))
                maxLength--;
            result.push(char);
        }
        return result.join('');
    }

    function checkLen(obj)
    {
        if (getLength(obj.value) > 400)
            obj.value = limitMaxLength(obj.value, 400);
        document.getElementById("description-count").innerHTML = Math.ceil(getLength(obj.value)/2).toString();
    }

    function check(){
        var addServiceType = document.getElementById("addServiceType").value;
        var serviceDescription = document.getElementById("serviceDescription").value;
        var beginDate = document.getElementById("beginDate").value;
        var endDate = document.getElementById("endDate").value;
        var servicePrice = document.getElementById("servicePrice").value;
        var isTechnicUser = <%out.print(request.getAttribute("isTechnicUser"));%>;
        if(addServiceType === "专业服务" && isTechnicUser == false){
            showAlert("发布专业服务请先认证专业技能");
            return false;
        }

        if(serviceDescription===""){
            showAlert("请填写服务描述");
            return false;
        }
        if(beginDate===""){
            showAlert("请填写服务开始日期");
            return false;
        }
        if(endDate===""){
            showAlert("请填写服务结束日期");
            return false;
        }
        if(servicePrice===""){
            showAlert("请填写服务价格");
            return false;
        }
        if(beginDate != "" && endDate != ""){
            beginDate = beginDate.replace(/\-/gi,"/");
            endDate = endDate.replace(/\-/gi,"/");
            var beginTime = new Date(beginDate).getTime();
            var endTime = new Date(endDate).getTime();
            if(beginTime>endTime){
                showAlert("服务结束时间不能早于开始时间");
                return false;
            }
        }
        if(servicePrice < 0){
            showAlert("服务金额不能为负");
            return false;
        }
        if(<%out.print(surplus);%>){
            showAlert("每日至多可以发布3条服务<br/>您今日发布条数已达到上限！");
            return false;
        }
        return true;
    }
    function checkSurplus(){
        if(<%out.print(surplus);%>){
            showAlert("每日至多可以发布3条服务<br/>您今日发布条数已达到上限！");
        }
    }
</script>

</body>
</html>
