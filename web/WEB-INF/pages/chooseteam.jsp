<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/7
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>RateTest</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<div class="page">
    <div class="page__bd" style="height: 100%;">
        <div class="weui-panel weui-panel_access">
            <div class="weui-panel__hd">
                <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                    <p><img src="../img/返回.png" width="20" height="15"alt="">团体列表</p>
                </div>
            </div>
            <div class="weui-panel__bd">
                <div class="weui-cells weui-cells_checkbox">

                    <label class="weui-cell weui-check__label" for="s11">
                        <div class="weui-cell__hd">
                            <input type="checkbox" class="weui-check" name="checkbox1" value="1" id="s11">
                            <i class="weui-icon-checked"></i>
                        </div>
                        <div class="weui-cell__bd">
                            <p>团体1</p>
                        </div>
                    </label>

                    <label class="weui-cell weui-check__label" for="s12">
                        <div class="weui-cell__hd">
                            <input type="checkbox" name="checkbox1" class="weui-check" value="2" id="s12">
                            <i class="weui-icon-checked"></i>
                        </div>
                        <div class="weui-cell__bd">
                            <p>团体2</p>
                        </div>
                    </label>

                    <label class="weui-cell weui-check__label" for="s13">
                        <div class="weui-cell__hd">
                            <input type="checkbox" name="checkbox1" class="weui-check" value="3"id="s13">
                            <i class="weui-icon-checked"></i>
                        </div>
                        <div class="weui-cell__bd">
                            <p>团体3</p>
                        </div>
                    </label>

                    <label class="weui-cell weui-check__label" for="s14">
                        <div class="weui-cell__hd">
                            <input type="checkbox" name="checkbox1" class="weui-check" value="4"id="s14">
                            <i class="weui-icon-checked"></i>
                        </div>
                        <div class="weui-cell__bd">
                            <p>团体4</p>
                        </div>
                    </label>

                    <label class="weui-cell weui-check__label" for="s15">
                        <div class="weui-cell__hd">
                            <input type="checkbox" name="checkbox1" class="weui-check" value="5" id="s15">
                            <i class="weui-icon-checked"></i>
                        </div>
                        <div class="weui-cell__bd">
                            <p>团体5</p>
                        </div>
                    </label>

                </div>

            </div>
        </div>
        <div class="weui-cell">
            <div class="weui-cell__bd">
                <div class="weui-flex">
                    <div class="weui-flex__item"diaplay="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"display="none"></div>
                    <div class="weui-flex__item"><div class="weui-btn weui-btn_mini weui-btn_primary" id="btn">提交</div></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script>
    $(function() {
        $("#btn").on('click', function () {
            var obj = document.getElementsByName("checkbox1");
            var check_val = [];
            for(k in obj){
                if(obj[k].checked)
                    check_val.push(obj[k].value);
            }
            alert("被选择的团体为:团体"+check_val);
        });
    });
</script>
</html>
