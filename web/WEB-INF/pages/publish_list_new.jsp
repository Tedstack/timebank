<%@ page import="com.blockchain.timebank.entity.ViewPublishDetailEntity" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: caozihan
  Date: 2017/12/20
  Time: 13:38
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
    <title>服务列表</title>
</head>
<body>
<div class="weui-tab">
    <div class="weui-tab__panel">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <span><%out.print(request.getAttribute("type"));%></span>
                <a href="${pageContext.request.contextPath}/publish/select?type=<%out.print(request.getAttribute("type"));%>" style="float:right">筛选</a>
            </div>
            <div class="weui-panel__bd">

                <%
                    List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>) request.getAttribute("list");
                    for (ViewPublishDetailEntity viewPublishEntity : list) {
                %>

                <a href="<%out.print("detail?id="+viewPublishEntity.getId());%>" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="../img/userAvatar/<%out.print(viewPublishEntity.getHeadImgUrl());%>">
                    </div>
                    <div class="weui-media-box__bd">
                        <img class="weui-media-box__thumb" style="width:30px" src="../img/服务名称/<%out.print(viewPublishEntity.getServiceName());%>.png" />
                        <h4 class="weui-media-box__title" style="display:inline-block"><%out.print(viewPublishEntity.getServiceName());%></h4>
                        <div style="color: #7ACF41;">¥
                            <%
                                out.print(viewPublishEntity.getPrice());
                                String type = request.getAttribute("type").toString();
                                if(("志愿者服务").equals(type)){
                                    out.print("（志愿者币）");
                                }else if(("互助服务".equals(type))){
                                    out.print("（时间币）");
                                } else{
                                    out.print("（人民币）");
                                }
                            %></div>
                        <div><p class="weui-media-box__desc">
                            <%out.print(viewPublishEntity.getUserName());%> &nbsp;&nbsp;&nbsp;
                            <%out.print(viewPublishEntity.getAddress());%>
                        </p></div>
                    </div>
                </a>
                <%}%>
                <%--<a href="" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="../img/userAvatar/user2.jpg">
                    </div>
                    <div class="weui-media-box__bd">
                        <img class="weui-media-box__thumb" style="width:30px" src="../img/服务名称/陪聊.png" />
                        <h4 class="weui-media-box__title" style="display:inline">陪聊</h4>
                        <div style="color: #7ACF41;">¥20（志愿者币）</div>
                        <div><p class="weui-media-box__desc">
                            李四 &nbsp;&nbsp;&nbsp;
                            闵行区
                        </p></div>
                    </div>
                </a>
                <a href="" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="../img/userAvatar/user3.jpg">
                    </div>
                    <div class="weui-media-box__bd">
                        <img class="weui-media-box__thumb" style="width:30px" src="../img/服务名称/代购.png" />
                        <h4 class="weui-media-box__title" style="display:inline">代购</h4>
                        <div style="color: #7ACF41;">¥100（志愿者币）</div>
                        <div><p class="weui-media-box__desc">
                            chloe &nbsp;&nbsp;&nbsp;
                            普陀区
                        </p></div>
                    </div>
                </a>
                <a href="" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="../img/userAvatar/user4.jpg">
                    </div>
                    <div class="weui-media-box__bd">
                        <img class="weui-media-box__thumb" style="width:30px" src="../img/服务名称/就医陪诊.png" />
                        <h4 class="weui-media-box__title" style="display:inline">快递代收</h4>
                        <div style="color: #7ACF41;">¥50（志愿者币）</div>
                        <div><p class="weui-media-box__desc">
                            李四 &nbsp;&nbsp;&nbsp;
                            静安区
                        </p></div>
                    </div>
                </a>
                <a href="" class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" style="" src="../img/userAvatar/user2.jpg">
                    </div>
                    <div class="weui-media-box__bd">
                        <img class="weui-media-box__thumb" style="width:30px" src="../img/服务名称/就医陪诊.png" />
                        <h4 class="weui-media-box__title" style="display:inline">代购</h4>
                        <div style="color: #7ACF41;">¥100（志愿者币）</div>
                        <div><p class="weui-media-box__desc">
                            王二 &nbsp;&nbsp;&nbsp;
                            普陀区
                        </p></div>
                    </div>
                </a>--%>
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
</div>
</body>
</html>
