<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/19
  Time: 20:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动详情</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>



<div class="weui-tab__panel">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p style="font-size: large">活动名称:扫大街</p>
        </div>
        <div class="weui-cell__ft" style="color: #0D0D0D">发起团队:风华队</div>
    </div>
    <img src="../img/底部.png" width="375" height="10">
    <div class="weui-cells__title" style="color: #0D0D0D">活动详情</div>
    <div class="weui-cells weui-cells_form">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <textarea class="weui-textarea" placeholder="组织风华队志愿者们参加扫大街活动,组织风华队志愿者们参加扫大街活动" rows="3" readonly="true"></textarea>
            </div>
        </div>
    </div>
    <img src="../img/底部.png" width="375" height="10">
    <div class="weui-cell " href="javascript:;">
        <div class="weui-cell__bd">
            <p>活动开始时间</p>
        </div>
        <div class="weui-cell__ft">2017年12月19日15:00</div>
    </div>
    <div class="weui-cell " href="javascript:;">
        <div class="weui-cell__bd">
            <p>活动结束时间</p>
        </div>
        <div class="weui-cell__ft">2017年12月19日18:00</div>
    </div>
    <div class="weui-cell " href="javascript:;">
        <div class="weui-cell__bd">
            <p>报名截止时间</p>
        </div>
        <div class="weui-cell__ft">2017年12月18日18:00</div>
    </div>
    <img src="../img/底部.png" width="375" height="10">
    <div class=" weui-btn weui-btn_primary" style="padding-right: 1px;padding-left: 1px;margin-left: 10px;margin-right: 10px">开始活动</div>
    <img src="../img/底部.png" width="375" height="10">
    <div class="weui-cells__title" style="color: #0D0D0D;text-align:center;font-size: large">已报名人员</div>
    <div class="weui-cells">
        <!--以下循环参加的人数-->
        <div class="weui-cell" id="cell1">
            <div class="weui-cell__bd">
                <p style="font-size: 90%">孙芃达+联系电话</p>
            </div>
            <div class="weui-cell__ft">
                <div class="weui-btn weui-btn_mini weui-btn_primary" id="btn1">移除</div>
            </div>
        </div>
        <!--以上-->
        <div class="weui-cell" id="cell2">
            <div class="weui-cell__bd">
                <p style="font-size: 90%">大齐+联系电话</p>
            </div>
            <div class="weui-cell__ft">
                <div class="weui-btn weui-btn_mini weui-btn_primary" id="btn2">移除</div>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <p style="font-size: 90%">帅风+联系电话</p>
            </div>
            <div class="weui-cell__ft">
                <div class="weui-btn weui-btn_mini weui-btn_primary" >移除</div>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <p style="font-size: 90%">蔡磊+联系电话</p>
            </div>
            <div class="weui-cell__ft">
                <div class="weui-btn weui-btn_mini weui-btn_primary" >移除</div>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <p style="font-size: 90%">黄立波+联系电话</p>
            </div>
            <div class="weui-cell__ft">
                <div class="weui-btn weui-btn_mini weui-btn_primary" >移除</div>
            </div>
        </div>
    </div>
</div>

<div class="weui-tabbar">
    <a href="${pageContext.request.contextPath}/index" class="weui-tabbar__item">
        <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">首页</p>
    </a>
    <a href="${pageContext.request.contextPath}/publish/category" class="weui-tabbar__item">
        <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">服务</p>
    </a>
    <a href="${pageContext.request.contextPath}/user/" class="weui-tabbar__item">
        <img src="../img/我的.png" alt="" class="weui-tabbar__icon">
        <p class="weui-tabbar__label">我</p>
    </a>
</div>


<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script>
    $(function(){
        $("btn1").on('click',function(){
            var divObj=document.getElementById("cell1");
            divObj.style.display="none";//没用...
        });
    });
</script>

</body>
</html>
