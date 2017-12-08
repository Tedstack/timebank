<%--
  Created by IntelliJ IDEA.
  User: bobo9978
  Date: 2017/12/8
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动发布</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
<div class="weui-tab">
    <div class="weui-tab__panel">

        <div class="weui-panel__hd">
            <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                <p><img src="../img/返回.png" width="20" height="15"alt="">发布活动</p>
            </div>
        </div>
        <div class="weui-panel__bd">
                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__bd">
                        <p>活动主办方</p>
                    </div>
                    <div class="weui-cell__bd">
                        <select class="weui-select" name="serviceType">
                           <option value="2">团体1</option>
                            <option value="3">团体2</option>
                            <option value="4">团体3</option>
                        </select>
                    </div>
                </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动名称</p></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入服务名称"/>
                </div>
            </div>



                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>活动描述</p></div>
                    <div class="weui-cell__bd">
                        <div class="weui-cell__bd">
                            <textarea class="weui-textarea" name="description" placeholder="请输入描述" rows="3"></textarea>
                            <div class="weui-textarea-counter"><span>0</span>/200</div>
                        </div>
                    </div>
                </div>

                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>活动日期</p></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="beginDate" type="date" value=""/>
                    </div>
                </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动开始时间</p></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="beginDate" type="date" value=""/>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动结束时间</p></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="endDate" type="date" value=""/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>参与人数</p></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入参与人数"/>
                </div>
            </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>活动报酬</p></div>
                    <div class="weui-cell__bd">
                        <input class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入参与者报酬"/>
                    </div>
                </div>

                <div class="weui-cell weui-cell_select weui-cell_select-after">
                    <div class="weui-cell__bd">
                        <p>活动地点</p>
                    </div>
                    <div class="weui-cell__bd">
                        <%--黄浦区、徐汇区、长宁区、静安区、普陀区、虹口区、杨浦区、宝山区、闵行区、嘉定区、浦东新区、松江区、金山区、青浦区、奉贤区、崇明区--%>
                        <select class="weui-select" name="address">
                            <option value="黄浦区">黄浦区</option>
                            <option value="徐汇区">徐汇区</option>
                            <option value="长宁区">长宁区</option>
                            <option value="静安区">静安区</option>
                            <option value="普陀区">普陀区</option>
                            <option value="虹口区">虹口区</option>
                            <option value="杨浦区">杨浦区</option>
                            <option value="宝山区">宝山区</option>
                            <option value="闵行区">闵行区</option>
                            <option value="嘉定区">嘉定区</option>
                            <option value="浦东新区">浦东新区</option>
                            <option value="松江区">松江区</option>
                            <option value="金山区">金山区</option>
                            <option value="青浦区">青浦区</option>
                            <option value="奉贤区">奉贤区</option>
                            <option value="崇明区">崇明区</option>
                        </select>
                    </div>
                </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动详细地址</p></div>
                <div class="weui-cell__bd">
                    <input class="weui-input" name="price" type="number" pattern="[0-9]*" placeholder="请输入详细地址"/>
                </div>
            </div>
        </div>
            <div style="padding: 10px; margin-bottom: 20px;">
                <button type="submit" class="weui-btn weui-btn_primary">发布</button>
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

</script>

</body>
</html>
