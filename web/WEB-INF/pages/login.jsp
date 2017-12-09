<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 炒饭君
  Date: 2017/10/15
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!-- code of function has been deleted -->
<!-- date:2017/10/14 hlb9978 -->
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="login/css/normalize.css"/>
    <link rel="stylesheet" type="text/css" href="login/css/htmleaf-demo.css">
    <style type="text/css">
        .login-page {
            width: 360px;
            padding: 8% 0 0;
            margin: auto;
        }

        .form {
            position: relative;
            z-index: 1;
            background: #FFFFFF;
            max-width: 360px;
            margin: 0 auto 100px;
            padding: 45px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
        }

        .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            margin: 0 0 15px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form button {
            font-family: "Microsoft YaHei", "Roboto", sans-serif;
            text-transform: uppercase;
            outline: 0;
            background: #4CAF50;
            width: 100%;
            border: 0;
            padding: 15px;
            color: #FFFFFF;
            font-size: 14px;
            -webkit-transition: all 0.3 ease;
            transition: all 0.3 ease;
            cursor: pointer;
        }

        .form button:hover, .form button:active, .form button:focus {
            background: #43A047;
        }

        .form .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 12px;
        }

        .form .message a {
            color: #4CAF50;
            text-decoration: none;
        }

        .form .register-form {
            display: none;
        }

        .container {
            position: relative;
            z-index: 1;
            max-width: 300px;
            margin: 0 auto;
        }

        .container:before, .container:after {
            content: "";
            display: block;
            clear: both;
        }

        .container .info {
            margin: 50px auto;
            text-align: center;
        }

        .container .info h1 {
            margin: 0 0 15px;
            padding: 0;
            font-size: 36px;
            font-weight: 300;
            color: #1a1a1a;
        }

        .container .info span {
            color: #4d4d4d;
            font-size: 12px;
        }

        .container .info span a {
            color: #000000;
            text-decoration: none;
        }

        .container .info span .fa {
            color: #EF3B3A;
        }

        body {
            background: #76b852; /* fallback for old browsers */
            background: -webkit-linear-gradient(right, #76b852, #8DC26F);
            background: -moz-linear-gradient(right, #76b852, #8DC26F);
            background: -o-linear-gradient(right, #76b852, #8DC26F);
            background: linear-gradient(to left, #76b852, #8DC26F);
            font-family: "Roboto", sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .shake_effect {
            -webkit-animation-name: shake;
            animation-name: shake;
            -webkit-animation-duration: 1s;
            animation-duration: 1s;
        }

        @-webkit-keyframes shake {
            from, to {
                -webkit-transform: translate3d(0, 0, 0);
                transform: translate3d(0, 0, 0);
            }

            10%, 30%, 50%, 70%, 90% {
                -webkit-transform: translate3d(-10px, 0, 0);
                transform: translate3d(-10px, 0, 0);
            }

            20%, 40%, 60%, 80% {
                -webkit-transform: translate3d(10px, 0, 0);
                transform: translate3d(10px, 0, 0);
            }
        }

        @keyframes shake {
            from, to {
                -webkit-transform: translate3d(0, 0, 0);
                transform: translate3d(0, 0, 0);
            }

            10%, 30%, 50%, 70%, 90% {
                -webkit-transform: translate3d(-10px, 0, 0);
                transform: translate3d(-10px, 0, 0);
            }

            20%, 40%, 60%, 80% {
                -webkit-transform: translate3d(10px, 0, 0);
                transform: translate3d(10px, 0, 0);
            }
        }

        p.center {
            color: #fff;
            font-family: "Microsoft YaHei";
        }
    </style>
</head>
<body>
<%
    String openID = (String) request.getAttribute("openID");
%>
<div class="htmleaf-container">
    <header class="htmleaf-header">
    </header>
    <div id="wrapper" class="login-page">
        <div id="login_form" class="form">
            <form class="login-form" action="${pageContext.request.contextPath}/user/login" method="post">
                <%
                    String error=(String)request.getAttribute("error");
                    if(error!=null && error.length()>0){
                %>
                        <div class="form-group has-error">
                            <label class="control-label"><i class="fa fa-times-circle-o"></i>&nbsp; ${error}</label>
                        </div>
                <%
                    }
                %>

                <%
                    String logout=(String)request.getAttribute("logout");
                    if(logout!=null && logout.length()>0){
                %>
                        <div class="form-group has-error">
                            <label class="control-label"><i class="fa fa-times-circle-o"></i>&nbsp; ${logout}</label>
                        </div>
                <%
                    }
                %>
                <input type="text" placeholder="手机号" id="phone" name="phone"/>
                <input type="password" placeholder="密码" id="password" name="password"/>
                <input type="hidden" name="openID" value="<%out.print(openID);%>"/>
                <button type="submit" id="login">登　录</button>
                <p class="message">还没有账户? <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxb0f6b07f01978a2a&redirect_uri=http%3A%2F%2Fwww.coocir.com%2Ftimebank%2Fregister&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect">立刻创建</a></p>
                <p class="message">以游客身份登录 <a href="${pageContext.request.contextPath}/index">查看</a></p>
            </form>
        </div>
    </div>
</div>

<script>window.jQuery || document.write('<script src="login/js/jquery-2.1.1.min.js"><\/script>')</script>
<script type="text/javascript">
</script>
</body>
</html>

<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<%--<html>--%>
<%--<head>--%>
<%--<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">--%>
<%--<title>Login page</title>--%>
<%--<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->--%>
<%--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
<%--<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->--%>
<%--<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">--%>
<%--<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->--%>
<%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>--%>
<%--<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.css" />--%>
<%--</head>--%>

<%--<body>--%>
<%--<div id="mainWrapper">--%>
<%--<div class="login-container">--%>
<%--<div class="login-card">--%>
<%--<div class="login-form">--%>
<%--<form action="/user/login" method="post" class="form-horizontal">--%>
<%--<c:if test="${param.error != null}">--%>
<%--<div class="alert alert-danger">--%>
<%--<p>Invalid username and password.</p>--%>
<%--</div>--%>
<%--</c:if>--%>
<%--<c:if test="${param.logout != null}">--%>
<%--<div class="alert alert-success">--%>
<%--<p>You have been logged out successfully.</p>--%>
<%--</div>--%>
<%--</c:if>--%>

<%--<%--%>
<%--String error=(String)request.getAttribute("error");--%>
<%--if(error!=null && error.length()>0){--%>
<%--%>--%>
<%--<div class="form-group has-error">--%>
<%--<label class="control-label"><i class="fa fa-times-circle-o"></i>&nbsp; ${error}</label>--%>
<%--</div>--%>
<%--<%--%>
<%--}--%>
<%--%>--%>

<%--<div class="input-group input-sm">--%>
<%--<label class="input-group-addon" for="username"><i class="fa fa-user"></i></label>--%>
<%--<input type="text" class="form-control" id="username" name="phone" placeholder="Enter Username" required>--%>
<%--</div>--%>
<%--<div class="input-group input-sm">--%>
<%--<label class="input-group-addon" for="password"><i class="fa fa-lock"></i></label>--%>
<%--<input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>--%>
<%--</div>--%>
<%--<div class="form-actions">--%>
<%--<input type="submit"--%>
<%--class="btn btn-block btn-primary btn-default" value="Log in">--%>
<%--</div>--%>
<%--</form>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>

<%--</body>--%>
<%--</html>--%>
