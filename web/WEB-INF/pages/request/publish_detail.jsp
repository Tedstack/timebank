<%@ page import="com.blockchain.timebank.entity.ViewRequestDetailEntity" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 06/01/2018
  Time: 00:02
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <title>已发布需求详情</title>
</head>
<body>

<%
    ViewRequestDetailEntity detail = (ViewRequestDetailEntity) request.getAttribute("detail");
    String type = null;
    switch (request.getParameter("type")){
        case "volunteer":
            type = "志愿者需求";
            break;
        case "technic":
            type = "专业需求";
            break;
        case "mutualAid":
            type = "互助需求";
            break;
    }

%>

<div class="weui-tab">
    <div class="weui-tab__panel">


        <!--以下内容在右侧显示-->
        <%--<div class="enterbar bar_shop border_b mt10" style="margin-bottom: 0; padding-left: 15px">
            <div align="center">
                <img class="weui-media-box__thumb" style="width:25%" src="../img/服务名称/<%=detail.getServiceName()%>.png">
                <h2><%=detail.getServiceName()%></h2>
                <p><%=detail.getDescription()%></p>
            </div>
        </div>--%>

        <div class="weui-cells__title" style="color:#76b852">
            <h2>需求详情</h2>
        </div>
        <div class="weui-cells">

            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">需求类型 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p><%=type%></p>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">需求名称 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p><%=detail.getServiceName()%></p>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">需求地址 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p><%=detail.getAddress()%></p>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">开始时间 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p>

                        <%
                            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            Timestamp timestampBegin = detail.getBeginTime();
                            Date dateBegin = new Date(timestampBegin.getTime());
                            Timestamp timestampEnd = detail.getEndTime();
                            Date dateEnd = new Date(timestampEnd.getTime());
                            out.print(bartDateFormat.format(dateBegin));
                        %>

                    </p>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">结束时间 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p>

                        <%
                            out.print(bartDateFormat.format(dateEnd));
                        %>

                    </p>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">需求单价 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p><%=detail.getPrice()%><%
                    if("volunteer".equals(detail.getServiceType())){
                        out.print("志愿者时间");
                    } else if("mutualAid".equals(detail.getServiceType())){
                        out.print("时间币");
                    } else{
                        out.print("元");
                    }
                %>/小时</p>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">预留电话 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p><%=detail.getUserPhone()%></p>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__hd">
                    <label class="weui-label">需求描述 ：</label>
                </div>
                <div class="weui-cell__bd">
                    <p><%=detail.getDescription()%></p>
                </div>
            </div>
        </div>

        <div class="weui-cell">
            <div class="weui-cell__bd"></div>
        </div>
        <div class="weui-btn-area">
            <a class="weui-btn weui-btn_primary" href="<%out.print("update?id="+detail.getId()+"&userID="+detail.getUserId());%>">修改</a>
        </div>

        <article class="weui-article">
            <section>
                <h2 class="title" style="color:#76b852">接受服务须知</h2>
                <section>
                    <p>
                        需要服务者申请您的服务后，您可以选择接受或拒绝<br/>
                        接受服务后不可取消，拒绝服务不会影响您任何信誉或评价<br/>
                        若有任何变动请及时与申请服务者联系
                    </p>
                </section>
            </section>
        </article>

    </div>

</div>
</body>
</html>

