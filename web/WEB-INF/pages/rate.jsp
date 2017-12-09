<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %><%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/7
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>评价</title>
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
    ViewRecordDetailEntity record = (ViewRecordDetailEntity) request.getAttribute("viewRecordDetailEntity");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">评价</p>
                </div>
            </div>
            <div class="weui-panel__bd">
                <a href="javascript:void(0);" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/服务名称/<%out.print(record.getServiceName());%>.png" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title"><%out.print(record.getServiceName());%></h4>
                        <p class="weui-media-box__desc">订单编号 <%out.print(record.getId());%></p>
                        <p class="weui-media-box__desc">服务人员 <%out.print(record.getServiceUserName());%></p>
                        <ul class="weui-media-box__info">
                            <li class="weui-media-box__info__meta">内容1</li>
                            <li class="weui-media-box__info__meta">内容2</li>
                            <li class="weui-media-box__info__meta weui-media-box__info__meta_extra"></li>
                            <li class="weui-media-box__info__meta">内容3</li>
                        </ul>
                    </div>
                </a>
            </div>
        </div>

        <div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none">
                        <p>服务评分</p>
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
        <%--<div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none">
                        <p>服务者态度</p>
                    </div>
                    <div class="weui-flex__item">
                        <div class="weui-flex__item">
                            <div id="app2">
                                <el-rate v-model="value3" show-text>
                                </el-rate>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>
        <img src="../img/底部.png" width="375" height="10">
        <div class="weui-cells__title">详细评价</div>
        <div class="weui-cells weui-cells_form">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <textarea name="text" class="weui-textarea" id="text" placeholder="例：服务非常满意，服务者的态度也很好" rows="3"></textarea>
                    <div class="weui-textarea-counter"><span>0</span>/200</div>
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
                    <div class="weui-flex__item"><div class="weui-btn weui-btn_mini weui-btn_primary" id="btn">提交</div></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<!-- 先引入 Vue -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="//unpkg.com/vue/dist/vue.js"></script>
<!-- 引入组件库 -->
<script src="//unpkg.com/element-ui@2.0.7/lib/index.js"></script>
<%--<script>
    new Vue({
        el:'#app',
        data:function(){
            return {
                value3: 4
            }
        }
    })
</script>--%>
<%--<script>
    new Vue({
        el:'#app2',
        data:function(){
            return {
                value3: 4
            }
        }
    })
</script>--%>
<script type="text/javascript">
    new Vue({
        el:'#app',
        data:function(){
            return {
                value3: 4
            }
        }
    })
    var contextPath="${pageContext.request.contextPath}";
    var recordID='<%=record.getId()%>';
    $(function() {
        $("#btn").on('click', function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/user/applyUserEvaluateRecord";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/user/queryOrderAlreadyComplete";
            var starNum = 0;
            var starText = $('#app').text();
            var comment = $('#text').val()
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
            //alert("服务评分："+$('#app').text()+"\n"+"服务者态度："+$('#app2').text()+"\n"+"详细评价："+$('#text').val());
            //alert("服务评分："+$('#app').text()+"\n"+"详细评价："+$('#text').val()+starNum);
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "recordID=" + recordID + "&rating=" + starNum + "&comment=" + comment,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    showAlert("更改成功",function () {
                        goTo(targetUrl2);
                    })

                },
                error: function (xhr, type) {
                    alert(type);
                    showAlert("更改失败");
                    /*showAlert("支付失败",function () {
                        //goTo("http://www.hlb9978.com/user/queryOrderWaitingPay");
                    })*/
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });
    });
</script>
</html>
