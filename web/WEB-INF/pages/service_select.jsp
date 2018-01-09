<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2017/12/21
  Time: 15:20
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
    <link rel="stylesheet" href="../css/jquery.range.css">
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
    <style>
        .slider-container{
            margin-top: 30px;
        }
        table{
            width: 100%;
            margin:auto;
        }
        td{
            width:25%;
        }
        .select-button {
            display: inline-block;
            width: 85%;
            margin:auto;
            height: 30px;
            margin-top: 20px;
            border: 1px solid #515151;
            border-radius: 8px;
            text-align: center;
            padding-top: 2px;
            background-color:#ffffff ;
            color: #515151;
        }
        .active{
            background-color:#76b852 ;
            color: #ffffff;
        }
    </style>
    <title>筛选<%out.print(request.getAttribute("type"));%></title>
</head>
<body>

<%
    Map<String, ArrayList<String>> map = new HashMap<String, ArrayList<String>>();
    List<ServiceEntity> list = (List<ServiceEntity>) request.getAttribute("service_list");
    for (ServiceEntity service : list) {
        if (!map.containsKey(service.getType())) map.put(service.getType(), new ArrayList<String>());
        map.get(service.getType()).add(service.getName());
    }
    List<String> names = map.get(request.getAttribute("type"));
%>

<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel__hd">
            <span>筛选<span class="select-title"><%out.print(request.getAttribute("type"));%></span></span>
        </div>
        <%--<form action="${pageContext.request.contextPath}/publish/list_select" method="post" onsubmit="return check();">--%>
            <div class="weui-panel__bd">
                <div class="weui-media-box weui-media-box_text" style="padding-bottom: 25px">
                    <div style="margin-left: 15px">
                        <span style="color:#76b852">服务类型</span>
                        <%
                            out.print("<table><tbody>");
                            int i = 0;
                            for (String name : names) {
                                if(i % 3 == 0){
                                    out.print("<tr>");
                                }
                                out.print("<td><span class='select-button'>" + name + "</span></td>");
                                if(i % 3 == 2){
                                    out.print("</tr>");
                                }
                                i++;
                            }
                            while(i % 3 != 0) {
                                out.print("<td></td>");
                                if(++i % 3 == 0) {
                                    out.print("</tr>");
                                }
                            }
                            out.print("</tbody></table>");
                        %>
                        <%--<div class="weui-flex">
                            <div class="weui-flex_item select-button">家政</div>
                            <div class="weui-flex_item select-button">陪聊</div>
                            <div class="weui-flex_item select-button">就医陪诊</div>
                        </div>
                        <div class="weui-flex">
                            <div class="weui-flex_item select-button">代购</div>
                            <div class="weui-flex_item select-button">快递代收</div>
                            <div class="weui-flex_item select-button">其它</div>
                        </div>--%>
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text">
                    <div style="margin-left: 15px">
                        <span style="color:#76b852">服务时间</span>
                        <div style="margin: 10px;margin-bottom: 30px">
                            <input id='select-begintime' class="weui-input" type="date" style="height: 50px;line-height: 34px;display: inline-block;width:40%;float: left" placeholder="开始时间">
                            <span style="margin:0 auto; vertical-align:middle">--</span>
                            <input id='select-endtime' class="weui-input" type="date" style="height: 50px;line-height: 34px;display: inline-block;width:40%;float: right" placeholder="结束时间">
                        </div>
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text" style="padding-bottom: 25px">
                    <div style="margin-left: 15px">
                        <span style="color:#76b852">服务金额</span>
                        <div class="range-slider"></div>
                    </div>
                </div>
                <div class="weui-media-box weui-media-box_text" style="padding-bottom: 25px">
                    <div style="margin-left: 15px; margin-top: 20px;margin-bottom: 30px; float:right">
                        <a class="weui-btn weui-btn_mini weui-btn_default" href="${pageContext.request.contextPath}/publish/list?type=<%out.print(request.getAttribute("type"));%>">取消</a>
                        <a class="weui-btn weui-btn_mini weui-btn_primary" id="select-confirm" >完成</a>
                    </div>
                </div>
            </div>
        <%--</form>--%>
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
</div>
    <script src="../js/jquery/jquery-3.2.1.min.js"></script>
    <script src="../js/range/jquery.range.js"></script>
    <script>
        $('.range-slider').jRange({
            from: 0,
            to: 200,
            step: 1,
            scale: [0,50,100,150,200],
            format: '%s',
            width: 300,
            showLabels: true,
            isRange : true //theme:'theme-blue'
        });
        $('.select-button').click(function(){
            $(this).toggleClass('active');
        });
        $('#select-confirm').click(function(){
            var type = $(".select-title").html();
            var serviceName = "";
            var i =0;
            $('.active').each(function(){
                serviceName = serviceName + $(this).html() + ',';
            });
            var upperDate = $('#select-endtime').val();
            var lowerDate = $('#select-begintime').val();
            var aa = $(".range-slider").val();
            var range = aa.split(',');
            var upperPrice = range[1];
            var lowerPrice = range[0];
            console.log("upperDate",upperDate);
            console.log("lowerDate",lowerDate);
            if(check(serviceName, lowerDate, upperDate, upperPrice, lowerPrice)){
                location.href="${pageContext.request.contextPath}/publish/selectList?type="+ type +"&upper="+ upperPrice + "&lower=" + lowerPrice
                    + "&upperDate=" + upperDate + "&lowerDate=" + lowerDate + "&serviceName=" + serviceName;
             }
        });

        function check(serviceName, lowerDate, upperDate, upperPrice, lowerPrice){
            if(serviceName===""){
                showAlert("请选择服务名称");
                return false;
            }
            if(lowerDate===""){
                showAlert("请填写服务开始日期");
                return false;
            }
            if(upperDate===""){
                showAlert("请填写服务结束日期");
                return false;
            }
            if(upperPrice===0 && lowerPrice===0){
                showAlert("请选择服务价格");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
