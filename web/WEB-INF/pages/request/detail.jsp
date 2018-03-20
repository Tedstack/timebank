<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 29/12/2017
  Time: 13:36
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <title>需求详情</title>
</head>
<body>

<%
    ViewRequestDetailEntity detail = (ViewRequestDetailEntity) request.getAttribute("detail");
    UserEntity currentUser = (UserEntity) request.getAttribute("currentUser");
%>

<div class="weui-tab">
    <div class="weui-tab__panel">

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0; padding-left: 15px">
            <div align="center">
                <img class="weui-media-box__thumb" style="width:25%" src="../img/服务名称/<%=detail.getServiceName()%>.png">
                <h2><%=detail.getServiceName()%></h2>
                <p><%=detail.getDescription()%></p>
            </div>
        </div>

        <div class="weui-cells__title">
            <span style="color:#76b852">需求详情</span>
        </div>
        <div class="weui-cells">

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="height:20.5px; display:inline; vertical-align: text-bottom;" src="../img/littleicon/定位.png">
                    <span><%=detail.getAddress()%></span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <img  class="weui-media-box__thumb" style="height:20.5px; display:inline; vertical-align: text-bottom;" src="../img/littleicon/时间.png">
                    <span>

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            Timestamp timestampBegin = detail.getBeginTime();
                            Date dateBegin = new Date(timestampBegin.getTime());
                            Timestamp timestampEnd = detail.getEndTime();
                            Date dateEnd = new Date(timestampEnd.getTime());
                            out.print(bartDateFormat.format(dateBegin) + " - " + bartDateFormat.format(dateEnd));
                        %>

                    </span>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <a id="requestApply-button" class="weui-btn weui-btn_primary" href="${pageContext.request.contextPath}/request/apply?id=<%=detail.getId()%>" style="color:#fff; border:0px;display: none;text-decoration:none;">
                        <%=detail.getPrice()%>
                        <%
                            if(detail.getServiceType().equals("volunteer"))
                                out.print("志愿者时间");
                            else if(detail.getServiceType().equals("mutualAid"))
                                out.print("时间币");
                            else
                                out.print("元");
                        %>
                        /小时 申请服务
                    </a>
                    <a id="requestOverDate-button" class="weui-btn weui-btn_plain-default" style="background-color: #999; color:#fff; border:0px;display: none;text-decoration:none;" onclick="return false;">
                        需求已过期，不可申请
                    </a>
                </div>
            </div>
        </div>

        <article class="weui-article">
            <section>
                <h2 class="title" style="color:#76b852">申请须知</h2>
                <section>
                    <p>
                        申请前请看清时间及需求地址<br/>
                        提交申请后不可取消，等待提供需求者确认接受后即可提供服务<br/>
                        若有任何变动请及时与需求者联系<br/>
                    </p>
                </section>
            </section>
        </article>

    </div>

    <div class="weui-tabbar" style="height: 50px">
        <a href="${pageContext.request.contextPath}/request/list?type=volunteer" class="weui-tabbar__item">
            <img src="../img/首页.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label" style="font-size: 10px;color: #28a921;margin:0px">需求柜台</p>
        </a>
        <a href="${pageContext.request.contextPath}/request/applied?tab=1" class="weui-tabbar__item">
            <img src="../img/服务.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我承接的需求</p>
        </a>
        <a href="${pageContext.request.contextPath}/user/queryPublishAlreadyPublish" class="weui-tabbar__item">
            <img src="../img/活动.png" alt="" class="weui-tabbar__icon">
            <p class="weui-tabbar__label">我发布的服务</p>
        </a>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script language="javascript">
    $(document).ready(function () {
        var detailEndDate = "<%out.print(detail.getEndTime().toString().substring(0,10));%>";
        detailEndDate =detailEndDate.replace(/\-/gi,"/");
        var detailEndTime = new Date(detailEndDate).getTime();
        var nowDate = new Date(new Date().Format("yyyy/MM/dd"))
        var nowTime = nowDate.getTime();
        if(detailEndTime < nowTime){
            $("#requestApply-button").hide();
            $("#requestOverDate-button").show();
        } else{
            $("#requestApply-button").show();
            $("#requestOverDate-button").hide();
        }
        var currentUserId = "";
        if(<%out.print(currentUser != null);%>) {
            currentUserId = <%out.print(currentUser.getId());%>;
        }
        var publishUserId = <%out.print(detail.getUserId());%>;
        if(currentUserId != "" && currentUserId == publishUserId){
            $("#requestApply-button").hide();
            $("#requestOverDate-button").show();
            $("#requestOverDate-button").html("不可申请自己的需求");
        }
        if(<%=detail.getIsComplete()==(byte) 1%>){
            $("#requestApply-button").hide();
            $("#requestOverDate-button").show();
            $("#requestOverDate-button").html("需求已完成");
        }
    });
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
</body>
</html>
