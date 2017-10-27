<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.util.List" %><%--
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
    <title>服务列表</title>
    <link rel="stylesheet" href="../css/weui.css"/>
    <link rel="stylesheet" href="../css/weui-example.css"/>
    <link rel="stylesheet" href="../css/bootstrap.min.css" >
</head>
<body>


<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd"><%out.print(request.getAttribute("type"));%></div>
            <div class="weui-panel__bd">

                <%
                    List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>) request.getAttribute("list");
                    for (ViewPublishDetailEntity viewPublishEntity : list) {
                %>

                <a href="<%out.print("/publish/detail?id="+viewPublishEntity.getId());%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="../img/服务名称/<%out.print(viewPublishEntity.getServiceName());%>.png" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <h4 class="weui-media-box__title"><%out.print(viewPublishEntity.getServiceName());%></h4>
                        <div>¥
                            <%
                                out.print(viewPublishEntity.getPrice());
                                if(request.getAttribute("type").toString().equals("志愿者服务")){
                                    out.print("（志愿者币V）");
                                }else{
                                    out.print("（时间币C）");
                                }
                            %>
                        </div>
                        <div><p class="weui-media-box__desc">
                            <%out.print(viewPublishEntity.getUserName());%> &nbsp;&nbsp;&nbsp;
                            <%out.print(viewPublishEntity.getAddress());%>
                        </p></div>
                    </div>
                </a>

                <%}%>

            </div>
            <div class="weui-panel__ft">
                <a href="javascript:void(0);" class="weui-cell weui-cell_access weui-cell_link">
                    <div class="weui-cell__bd">查看更多</div>
                    <span class="weui-cell__ft"></span>
                </a>
            </div>
        </div>

    </div>

    <jsp:include page="bottom_tabbar.jsp"/>
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
