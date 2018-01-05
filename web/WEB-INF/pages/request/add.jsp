<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.swing.text.html.HTMLDocument" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 29/12/2017
  Time: 14:31
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>发布需求</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <script src="../../js/zepto/zepto.min.js"></script>
    <script src="../../js/zepto/weui.min.js"></script>
    <script src="../../js/scan/function.js"></script>
</head>
<body>

<%
    Map<String, Map<Long, String>> map = new HashMap<>();
    List<ServiceEntity> list = (List<ServiceEntity>) request.getAttribute("service_list");
    for (ServiceEntity service : list) {
        if (!map.containsKey(service.getType())) map.put(service.getType(), new HashMap<Long, String>());
        map.get(service.getType()).put(service.getId(), service.getName());
    }
%>

<div class="weui-tab">
    <div class="weui-tab__panel">
        <form action="${pageContext.request.contextPath}/request/add/submit" method="post" onsubmit="return check();">
            <div class="weui-cells__title">发布需求</div>

            <div class="weui-cells weui-cells_form">

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__hd">
                        <label class="weui-label">需求类型</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceType">
                            <%
                                for (String type : map.keySet()) {
                                    out.print("<option value='" + type + "'>" + type.replace("服务", "需求") + "</option>");
                                }
                            %>
                            <%--<option value="2">志愿者需求</option>--%>
                            <%--<option value="3">专业需求</option>--%>
                            <%--<option value="4">社区O2O需求</option>--%>
                        </select>
                    </div>
                </div>

                <%
                    for (String type : map.keySet()) {
                        Iterator id_names = map.get(type).entrySet().iterator();
                %>

                <div class="weui-cell weui-cell_select weui-cell_select-after weui-name" id="<%out.print(type);%>">
                    <div class="weui-cell__hd">
                        <label class="weui-label">需求名称</label>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceId">
                            <%
                                while(id_names.hasNext()) {
                                    Map.Entry entry = (Map.Entry) id_names.next();
                                    out.print("<option value='" + entry.getKey().toString() + "'>" + entry.getValue() + "</option>");
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
                        <label class="weui-label">需求描述</label>
                    </div>
                    <div class="weui-cell__bd">
                        <div class="weui-cell__bd">
                            <textarea id="serviceDescription" class="weui-textarea" name="description" placeholder="请输入描述" rows="3"></textarea>
                        </div>
                    </div>
                </div>

                <%
                    Date nowDate = new Date();
                    Date nextDate = new Date();
                    nextDate.setTime(nextDate.getTime() + 3600000);
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    String nowTime = formatter.format(nowDate);
                    String nextTime = formatter.format(nextDate);
                %>
                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">开始时间</label></div>
                    <div class="weui-cell__bd">
                        <input id="beginTime" class="weui-input" name="beginTime" type="datetime-local" value placeholder="<%out.print(nowTime);%>" min=<%out.print(nowTime);%>/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">结束时间</label></div>
                    <div class="weui-cell__bd">
                        <input id="endTime" class="weui-input" name="endTime" type="datetime-local" value placeholder="<%out.print(nextTime);%>" min=<%out.print(nextTime);%>/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">需求价格</label></div>
                    <div class="weui-cell__bd">
                        <input id="servicePrice" class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入需求价格" min="0"/>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__hd">
                        <label class="weui-label">需求地址</label>
                    </div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" type="text" name="address" id="address" placeholder="请输入需求地址">
                    </div>
                </div>

            </div>

            <div style="padding: 10px; margin-bottom: 20px;">
                <input class="weui-btn weui-btn_primary" type="submit" value="发布"/>
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
            $('#'+$(this).val()).show();$('#'+$(this).val()).find('.weui-select').attr("name","serviceId");
        });
    });

    function check(){
        var serviceDescription = document.getElementById("serviceDescription").value;
        var beginTime = document.getElementById("beginTime").value;
        var endTime = document.getElementById("endTime").value;
        var servicePrice = document.getElementById("servicePrice").value;

        if(serviceDescription===""){
            showAlert("请填写需求描述");
            return false;
        }
        if(beginTime===""){
            showAlert("请填写需求开始时间");
            return false;
        }
        if(endTime===""){
            showAlert("请填写需求结束时间");
            return false;
        }
        if(servicePrice===""){
            showAlert("请填写需求价格");
            return false;
        }
        if(beginTime != "" && endTime != ""){
            beginTime = beginTime.replace(/\-/gi,"/");
            beginTime = beginTime.replace("T"," ");
            endTime = endTime.replace(/\-/gi,"/");
            endTime = endTime.replace("T"," ");
            beginTime = new Date(beginTime).getTime();
            endTime = new Date(endTime).getTime();
            if(beginTime>endTime){
                showAlert("需求结束时间不能早于开始时间");
                return false;
            }
        }
        return true;
    }
</script>

</body>
</html>
