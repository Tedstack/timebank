<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2018/1/2
  Time: 21:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>我的二维码</title>
</head>
<body>
<h1>QR CODER</h1>
<div style="margin:auto; position:relative; margin-left: 50%; left: -250px; width:500px;">
    <label for="qr_link">URL:</label>
    <input id="qr_link" type="text" value="http://you.ctrip.com" style="width:350px;" />
    <button id="qr_gen" value="Generate">Generate</button> <br />
    <div style="display:none">
        <input id="qr_capacity_l" name="qr_capacity" type="radio" value="L"/> <label for="qr_capacity_l">7%</label>
        <input id="qr_capacity_m" name="qr_capacity" type="radio" value="M"/> <label for="qr_capacity_m">15%</label>
        <input id="qr_capacity_q" name="qr_capacity" type="radio" value="Q"/> <label for="qr_capacity_q">25%</label>
        <input id="qr_capacity_h" name="qr_capacity" type="radio" value="H" checked/> <label for="qr_capacity_h">30%</label>
    </div>
</div>
<div id="qr_container" style="margin:auto; position:relative;"></div>
</body>
</html>
