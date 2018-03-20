<%@ page import="com.blockchain.timebank.entity.ViewUserActivityDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>团队评价</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/configs.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<%
    String headImg=(String)request.getAttribute("HeadImg");
    String averageRate=(String)request.getAttribute("averageRate");
    List<ViewUserActivityDetailEntity> userList=(List<ViewUserActivityDetailEntity>)request.getAttribute("userList");
    List<String> comment=Arrays.asList("吐槽","失望","一般","满意","点赞");
%>
<div class="weui-tab__panel">
    <div class="weui-cells__title" style="color: #ce3c39;text-align:center;font-size: small;font-weight: bold">团 队 评 价</div>
    <div class="weui-cells">
        <div class="weui-cell">
            <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                <img src="../img/teamHeadImg/<%out.print(headImg);%>" height="80px">
            </div>
            <div class="weui-cell__bd">
                <p class="page__desc" style="margin-bottom: 6px;">综合评分: <%out.print(averageRate);%></p>
                <div class="weui-flex__item">
                    <div class="weui-flex__item">
                        <div id="app" >
                            <el-rate v-model="value3" show-text disabled>
                            </el-rate>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
            for (int i=0;i<userList.size();i++) {
        %>
        <div class="weui-cell">
            <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                <img src="<%out.print(userList.get(i).getUserHeadImg());%>" style="width: 50px;display: block">
            </div>
            <div class="weui-cell__bd">
                <p style="font-size: 13px;color: #888888;"><%out.print(comment.get((int) Math.ceil(userList.get(i).getUserRating())));%></p>
                <p style="font-size: 13px;color: #888888;"><%out.print(userList.get(i).getUserComment());%></p>
            </div>
        </div>
        <%}%>
        <!--以上-->
    </div>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script src="//unpkg.com/vue/dist/vue.js"></script>
<script src="//unpkg.com/element-ui@2.0.7/lib/index.js"></script>
<script type="text/javascript">
    var rate='<%=averageRate%>';
    new Vue({
        el:'#app',
        data:function(){
            return {
                value3: rate
            }
        }
    })
</script>
</html>
