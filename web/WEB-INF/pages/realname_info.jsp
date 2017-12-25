<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: Mihaly
  Date: 21/12/2017
  Time: 11:04
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的信息</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
</head>
<body>
<div class="container" style="height: 100%;">
    <%
        UserEntity userEntity = (UserEntity) request.getAttribute("user");
        String idNum = userEntity.getIdCard();
        String birth = idNum.substring(6, 14);
        int sexNum = Integer.parseInt(idNum.substring(16, 17));
        String sex;
        if (sexNum%2 == 1) sex = "男";
        else sex = "女";

        DateFormat idCardFormat = new SimpleDateFormat("yyyyMMdd");
        Date birthDate = idCardFormat.parse(birth);
        Calendar cal = Calendar.getInstance();
        int yearNow = cal.get(Calendar.YEAR);
        int monthNow = cal.get(Calendar.MONTH);
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
        cal.setTime(birthDate);
        int yearBirth = cal.get(Calendar.YEAR);
        int monthBirth = cal.get(Calendar.MONTH);
        int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
        int age = yearNow - yearBirth;
        if (monthNow <= monthBirth) {
            if (monthNow == monthBirth) {
                if (dayOfMonthNow < dayOfMonthBirth)
                    age--;
            } else {
                age--;
            }
        }
    %>
    <div class="page input js_show">
        <div class="page__bd">
            <div class="weui-cells__title">
                <p>实名认证信息</p>
            </div>
            <div class="weui-cells">
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>姓名</p>
                    </div>
                    <div class="weui-cell__ft">
                        <p><%out.print(userEntity.getName());%></p>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>年龄</p>
                    </div>
                    <div class="weui-cell__ft">
                        <p><%out.print(age);%></p>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>性别</p>
                    </div>
                    <div class="weui-cell__ft">
                        <p><%out.print(sex);%></p>
                    </div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>身份证号</p>
                    </div>
                    <div class="weui-cell__ft">
                        <p><%out.print(idNum.substring(0, 14) + "xxxx");%></p>
                    </div>
                </div>
            </div>
            <div class="weui-btn-area">
                <a href="${pageContext.request.contextPath}/user/" class="weui-btn weui-btn_primary">返回我的页面</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>

