<%@ page import ="com.blockchain.timebank.entity.RechargeEntity" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by YukiHan
  User: lenovo
  Date: 2018/1/22
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>充值明细</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
  <div class="weui-tab">
      <div class="weui-tab__panel">
          <div class="weui-panel">
              <% RechargeEntity rechargeEntity = (RechargeEntity)request.getAttribute("rechargeDetail");%>
              <div class="weui-cells">
                  <div class="weui-cell">
                      <div class="weui-cell__bd">
                          <p>订单编号：</p>
                      </div>
                      <div class="weui-cell__ft"><%=rechargeEntity.getUuid()%></div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__bd">
                          <p>服务名称：</p>
                      </div>
                      <div class="weui-cell__ft">微信充值</div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__bd">
                          <p>充值时间币：</p>
                      </div>
                      <div class="weui-cell__ft"><%=rechargeEntity.getTotalAmount()%></div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__bd">
                          <p>充值时间：</p>
                      </div>
                      <div class="weui-cell__ft">
                          <%
                              Timestamp beginTimestamp = rechargeEntity.getRechargeDate();
                              SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                              out.print(bartDateFormat.format(beginTimestamp));
                          %>
                      </div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__bd">充值状态：</div>
                      <div class="weui-cell__ft">
                          <%
                             if("success".equals(rechargeEntity.getRechargeStatus())){
                                 out.println("成功");
                             }
                             else{
                                 out.println("失败");
                             }
                          %>
                      </div>
                  </div>
              </div>
          </div>
      </div>
  </div>
</body>
</html>
