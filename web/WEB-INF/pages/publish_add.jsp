<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="java.util.*" %><%--
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
    <link rel="stylesheet" href="../css/weui.css"/>
    <link rel="stylesheet" href="../css/weui-example.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css" >
</head>
<body>

<%
    Map<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
    List<ServiceEntity> list = (List<ServiceEntity>) request.getAttribute("service_list");
    for (ServiceEntity service : list) {
        if (!map.containsKey(service.getType())) map.put(service.getType(), new ArrayList<String>());
        map.get(service.getType()).add(service.getName());
    }
%>

<div class="weui-tab">
    <div class="weui-tab__panel">
        <form action="/publish/add/submit" method="post">
            <div class="weui-cells__title">发布服务</div>

            <div class="weui-cells weui-cells_form">

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">服务类型</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceType">
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
                        <label for="" class="weui-label">服务名称</label>
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

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label for="" class="weui-label">服务范围</label>
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
        $('.weui-name:gt(0)').hide();$('.weui-name:gt(0)').find('.weui-select').attr("name","");
        $('.weui-select:eq(0)').change(function () {
            $('.weui-name').hide();$('.weui-name').find('.weui-select').attr("name","");
            $('#'+$(this).val()).show();$('#'+$(this).val()).find('.weui-select').attr("name","serviceName");
        });
    });
</script>

</body>
</html>
