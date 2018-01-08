<%@ page import="com.blockchain.timebank.entity.ViewActivityPublishDetailEntity" %><%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/20
  Time: 19:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动评价</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    ViewActivityPublishDetailEntity activityDetail=(ViewActivityPublishDetailEntity) request.getAttribute("activityDetail");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">活动评价</p>
                </div>
            </div>
            <div class="weui-panel__bd">
                <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/服务名称/旅居.png" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title">活动名称:<%out.print(activityDetail.getName());%></h4>
                        <p class="weui-media-box__desc">活动组织:<%out.print(activityDetail.getTeamName());%></p>
                        <p class="weui-media-box__desc">活动梗概:</p>
                        <ul class="weui-media-box__info" style="margin-top: 1px;">
                            <li class="weui-media-box__info__meta">地点:<%out.print(activityDetail.getAddress());%></li>
                            <li class="weui-media-box__info__meta">简介:<%out.print(activityDetail.getDescription());%></li>
                        </ul>
                    </div>
                </a>
            </div>
        </div>

        <div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none">
                        <p>活动评分</p>
                    </div>
                    <div class="weui-flex__item">
                        <div class="weui-flex__item">
                            <div id="app">
                                <el-rate v-model="value3" show-text>
                                </el-rate>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <img src="../img/底部.png" width="375" height="10">
        <div class="weui-cells__title">详细评价</div>
        <div class="weui-cells weui-cells_form">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <textarea name="text" class="weui-textarea" id="commentIndex" placeholder="例：活动丰富有意义" rows="3"></textarea>
                </div>
            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"><a class="weui-btn weui-btn_mini weui-btn_primary" id="submitComment">提交</a></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="//unpkg.com/vue/dist/vue.js"></script>
<!-- 引入组件库 -->
<script src="//unpkg.com/element-ui@2.0.7/lib/index.js"></script>
<script type="text/javascript">
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    new Vue({
        el:'#app',
        data:function(){
            return {
                value3: 4
            }
        }
    })
    var contextPath="${pageContext.request.contextPath}";
    var activityId='<%=activityDetail.getId()%>';
    $(function() {
        $("#submitComment").on('click', function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/userEvaluateActivity";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/team/alreadyCompleteActivities2";
            var starNum = 0;
            var starText = $('#app').text();
            var comment = $('#commentIndex').val();
            if(starText==="极差"){
                starNum = 1;
            }
            if(starText==="失望"){
                starNum = 2;
            }
            if(starText==="一般"){
                starNum = 3;
            }
            if(starText==="满意"){
                starNum = 4;
            }
            if(starText==="惊喜"){
                starNum = 5;
            }
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userActivityID=" + activityId + "&rating=" + starNum + "&comment=" + comment,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="ok"){
                        showAlert("评价成功",function () {
                            goTo(targetUrl2);
                        })
                    }
                },
                error: function (xhr, type) {
                    alert(type);
                    showAlert("评价失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });
    });
</script>
</html>
