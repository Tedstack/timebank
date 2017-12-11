<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.blockchain.timebank.entity.ViewRecordDetailEntity" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: toyking
  Date: 2017/10/24
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>服务详情</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link href="../css/dj_base_838a930.css" rel="stylesheet" type="text/css">
    <link href="../css/dj_dc_content_f60f458.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="../css/swiper-3.4.0.min.css">
</head>
<body>
<!-- 使用 -->

<%
    ViewPublishDetailEntity detail = (ViewPublishDetailEntity) request.getAttribute("detail");
    List<ViewRecordDetailEntity> recordList = (List<ViewRecordDetailEntity>) request.getAttribute("recordList");
    int age = (int) request.getAttribute("age");
%>
<div class="weui-tab">
    <div class="weui-tab__panel">
       <!-- <div style="padding: 15px;">
            <img src="../img/服务名称/<%=detail.getServiceName()%>.png" alt="">
        </div>-->

        <!--以下内容在右侧显示-->
        <div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0;">
            <a href="javascript:void(0)">
                <div class="shop-logo">
                    <img src="../img/服务名称/<%=detail.getServiceName()%>.png" alt="">
                </div>
                <div class="txt"><%out.print(detail.getServiceName());%></div>
                <div class="tags-rz">
                    <span class="tag-sm">
                        <%
                            if(detail.getSex()==null){
                                out.print("暂无性别信息");
                            }else{
                                out.print(detail.getSex());
                            }
                        %>
                    </span>
                </div>
                <div class="tags-rz">
                    <span class="tag-sm">
                        <%
                            if(age==-1){
                                out.print("暂无年龄信息");
                            }else{
                                out.print(age);
                            }
                        %>
                    </span>
                </div>
            </a>
        </div>

        <div class="weui-cells">
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>服务类型</p>
                </div>
                <div class="weui-cell__ft"><%=detail.getServiceType()%></div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>开始日期</p>
                </div>
                <div class="weui-cell__ft">
                    <%
                        Timestamp timestamp = detail.getBeginDate();
                        Date date = new Date(timestamp.getTime());
                        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        out.print(bartDateFormat.format(date));
                    %></div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>结束日期</p>
                </div>
                <div class="weui-cell__ft">
                    <%
                        Timestamp timestamp2 = detail.getEndDate();
                        Date date2 = new Date(timestamp2.getTime());
                        SimpleDateFormat bartDateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                        out.print(bartDateFormat2.format(date2));
                    %></div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>服务价格</p>
                </div>
                <div class="weui-cell__ft"><%=detail.getPrice()%>元/小时</div>
            </div>
            <div class="weui-cell">
                <!--<div class="weui-cell__hd"><img src="../img/暂时使用商家.png" alt="" style="width:20px;margin-right:5px;display:block"></div>-->
                <div class="weui-cell__bd">
                    <p>服务范围</p>
                </div>
                <div class="weui-cell__ft"><%=detail.getAddress()%></div>
            </div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span>详情描述</span>
            </div>
            <div class="con_u"><%out.print(detail.getDescription());%></div>
        </div>

        <div class="block block_tcxq mt10">
            <div class="title">
                <span>历史评价</span>
            </div>
            <%
                for (int i=0;i<recordList.size();i++) {
            %>
                <div class="con_u">服务评分:<%out.print(recordList.get(i).getRating());%></div>
                <div class="con_u"><%out.print(recordList.get(i).getComment());%></div>
            <%
                }
            %>
        </div>

        <div style="padding: 10px; margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/record/apply?id=<%=detail.getId()%>" class="weui-btn weui-btn_primary">预约</a>
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
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>

<script>
    $(document).ready(function () {
        $('.weui-tabbar:eq(0)').find('a:eq(1)').addClass("weui-bar__item_on");
    });
</script>

</body>
</html>
