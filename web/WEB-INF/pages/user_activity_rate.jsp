<%@ page import="com.blockchain.timebank.entity.UserActivityEntity" %>
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
    UserActivityEntity userActivityEntity = (UserActivityEntity) request.getAttribute("userActivityEntity");
    String type=(String) request.getAttribute("type");
%>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none">
                        <p>参与评分</p>
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

        <div style="background-color: #f8f8f8; height:10px;"></div>
        <div class="weui-cells__title">详细评价</div>
        <div class="weui-cells weui-cells_form">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <%if(type.equalsIgnoreCase("0")){%>
                    <textarea name="text" class="weui-textarea" id="text" placeholder="例：活动表现积极，乐于帮助其他同伴" rows="3" oninput="checkLen(this)"></textarea>
                    <%}else{%>
                    <textarea name="text" class="weui-textarea" id="text" rows="3" oninput="checkLen(this)"><%out.print(userActivityEntity.getManagerComment());%></textarea>
                    <%}%>
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
    var type='<%=type%>';
    var rate='<%=userActivityEntity.getManagerRating()%>';
    var userActivityID='<%=userActivityEntity.getId()%>';
    var activityID='<%=userActivityEntity.getActivityId()%>';
    new Vue({
        el:'#app',
        data:function(){
            if(type==='0') {
                return {
                    value3: 4
                }
            }else{
                return {
                    value3: rate
                }
            }
        }
    })
    var contextPath="${pageContext.request.contextPath}";
    $(function() {
        $("#btn").on('click', function () {
            var targetUrl = "http://"+getDomainName()+contextPath+"/team/managerUserEvaluateUser";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/team/managerUserGetEvaluateList?activityID="+activityID;
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
            if(starNum<=3 && comment===""){
                showAlert("少于三星请填写具体原因");
            }
            //alert("服务评分："+$('#app').text()+"\n"+"服务者态度："+$('#app2').text()+"\n"+"详细评价："+$('#text').val());
            //alert("服务评分："+$('#app').text()+"\n"+"详细评价："+$('#text').val()+starNum);
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                data: "userActivityID=" + userActivityID + "&rating=" + starNum + "&comment=" + comment,
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
    function checkLen(obj)
    {
        if (getLength(obj.value) > 400)
            obj.value = limitMaxLength(obj.value, 400);
        document.getElementById("description-count").innerHTML = Math.ceil(getLength(obj.value)/2).toString();
    }
</script>
</html>
