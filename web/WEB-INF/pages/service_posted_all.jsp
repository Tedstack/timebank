<%@ page import="com.blockchain.timebank.entity.PublishEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.blockchain.timebank.entity.ServiceEntity" %>
<%@ page import="com.blockchain.timebank.entity.RecordEntity" %>
<%@ page import="com.blockchain.timebank.entity.UserEntity" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>WeUI</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="../css/weui.min.css" />
</head>
<body>
<!-- 使用 -->
<div class="weui-tab">
    <%
        List<PublishEntity> firstList1 = (List<PublishEntity>) request.getAttribute("firstList1");
        List<ServiceEntity> firstList2 = (List<ServiceEntity>) request.getAttribute("firstList2");

        List<RecordEntity> secondList1 = (List<RecordEntity>) request.getAttribute("secondList1");
        List<PublishEntity> secondList2 = (List<PublishEntity>) request.getAttribute("secondList2");
        List<UserEntity> secondList3 = (List<UserEntity>) request.getAttribute("secondList3");

        List<RecordEntity> thirdList1 = (List<RecordEntity>) request.getAttribute("thirdList1");
        List<UserEntity> thirdList2 = (List<UserEntity>) request.getAttribute("thirdList2");

        List<RecordEntity> fourthList1 = (List<RecordEntity>) request.getAttribute("fourthList1");
        List<UserEntity> fourthList2 = (List<UserEntity>) request.getAttribute("fourthList2");

        List<RecordEntity> fifthList1 = (List<RecordEntity>) request.getAttribute("fifthList1");
        List<UserEntity> fifthList3 = (List<UserEntity>) request.getAttribute("fifthList3");
    %>
    <div class="weui-tab__panel">
        <!--界面中的内容-->
        <div class="weui-tab">
            <div class="weui-navbar">
                <div class="weui-navbar__item weui-bar__item_on"id="navbar1">
                    已发布
                </div>
                <div class="weui-navbar__item"id="navbar2">
                    待确认
                </div>
                <div class="weui-navbar__item"id="navbar3">
                    待服务
                </div>
                <div class="weui-navbar__item"id="navbar4">
                    待支付
                </div>
                <div class="weui-navbar__item"id="navbar5">
                    已完成
                </div>
            </div>
            <br>
            <br>
            <!-- 已发布-->
            <div class="weui-panel__bd"id="untaken">
                <div class="page__bd">
                    <%
                        for (int i=0;i<firstList1.size();i++) {
                    %>
                    <div class="weui-form-preview">
                        <div class="weui-form-preview__hd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务名称</label>
                                <em class="weui-form-preview__value"><%out.print(firstList2.get(i).getName());%></em>
                            </div>
                        </div>
                        <div class="weui-form-preview__bd">
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务类别</label>
                                <span class="weui-form-preview__value"><%out.print(firstList2.get(i).getType());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">有效期</label>
                                <span class="weui-form-preview__value"><%out.print(firstList1.get(i).getBeginDate()+"-"+firstList1.get(i).getEndDate());%></span>
                            </div>
                            <div class="weui-form-preview__item">
                                <label class="weui-form-preview__label">服务范围</label>
                                <span class="weui-form-preview__value"><%out.print(firstList1.get(i).getAddress());%></span>
                            </div>
                        </div>
                        <div class="weui-panel__ft">
                            <a href=" " class="weui-cell weui-cell_access weui-cell_link">
                            <div class="weui-cell__bd">查看更多</div>
                            <span class="weui-cell__ft"></span>
                        </a>
                    </div>
                        <div class="weui-form-preview__ft">
                            <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:">修改</a>
                        </div>
                    </div>

                    <%}%>

                </div>
                <!--此处<br>-->
                <br>
            </div>
            <!--此处<br>-->


                <!--待确认-->
                <div class="weui-panel__bd"id="taken"  style="display:none">
                    <div class="page__bd">
                        <%
                            for (int i=0;i<secondList1.size();i++) {
                        %>
                        <div class="weui-form-preview">
                            <div class="weui-form-preview__hd">
                                <label class="weui-form-preview__label">服务价格</label>
                                <em class="weui-form-preview__value">时间币：<%out.print(secondList2.get(i).getPrice());%></em>
                            </div>
                            <div class="weui-form-preview__bd">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">申请人</label>
                                    <span class="weui-form-preview__value"><%out.print(secondList3.get(i).getName());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">开始时间</label>
                                    <span class="weui-form-preview__value"><%out.print(secondList1.get(i).getBeginTime());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">结束时间</label>
                                    <span class="weui-form-preview__value"><%out.print(secondList1.get(i).getEndTime());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">地理位置</label>
                                    <span class="weui-form-preview__value"><%out.print(secondList1.get(i).getApplyAddress());%></span>
                                </div>
                            </div>
                            <div class="weui-panel__ft">
                                <a href=" " class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>
                            </div>
                            <div class="weui-form-preview__ft">
                                <a class="weui-form-preview__btn weui-form-preview__btn_default" href="javascript:">拒绝</a>
                                <button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:">接受</button>
                            </div>
                        </div>

                        <%}%>
                    </div>
                    <br>
                </div>

                <!--待服务-->
                <div class="weui-panel__bd"id="unfinished" style="display:none">
                    <div class="page__bd">
                        <%
                            for (int i=0;i<thirdList1.size();i++) {
                        %>
                        <div class="weui-form-preview">
                            <div class="weui-form-preview__hd">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">服务对象</label>
                                    <em class="weui-form-preview__value"><%out.print(thirdList2.get(i).getName());%></em>
                                </div>
                            </div>
                            <div class="weui-form-preview__bd">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">开始时间</label>
                                    <span class="weui-form-preview__value"><%out.print(thirdList1.get(i).getBeginTime());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">结束时间</label>
                                    <span class="weui-form-preview__value"><%out.print(thirdList1.get(i).getEndTime());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">服务地点</label>
                                    <span class="weui-form-preview__value"><%out.print(thirdList1.get(i).getApplyAddress());%></span>
                                </div>
                            </div>
                            <div class="weui-panel__ft">
                                <a href=" " class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>
                            </div>
                            <div class="weui-form-preview__ft">
                                <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:">扫码开始</a>
                                <!--跳转到二维码接口-->
                            </div>
                        </div>

                        <%}%>
                    </div>
                    <br>
                </div>
                <!--待支付-->
                <div class="weui-panel__bd"id="unpaid"  style="display:none">
                    <div class="page__bd">
                        <%
                            for (int i=0;i<fourthList1.size();i++) {
                        %>
                        <div class="weui-form-preview">
                            <div class="weui-form-preview__hd">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">实际价格</label>
                                    <em class="weui-form-preview__value">时间币：<%out.print(fourthList1.get(i).getPayMoney());%></em>
                                </div>
                            </div>
                            <div class="weui-form-preview__bd">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">服务对象</label>
                                    <span class="weui-form-preview__value"><%out.print(fourthList2.get(i).getName());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">开始时间</label>
                                    <span class="weui-form-preview__value"><%out.print(fourthList1.get(i).getActualBeginTime());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">结束时间</label>
                                    <span class="weui-form-preview__value"><%out.print(fourthList1.get(i).getActualEndTime());%></span>
                                </div>
                            </div>
                            <div class="weui-panel__ft">
                                <a href=" " class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>
                            </div>
                            <div class="weui-form-preview__ft">
                                <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:">申诉</a>
                            </div>
                        </div>

                        <%}%>
                        <br>
                    </div>
                </div>
                <!--已完成-->
                <div class="weui-panel__bd"id="finished"  style="display:none">
                    <div class="page__bd">
                        <%
                            for (int i=0;i<fifthList1.size();i++) {
                        %>
                        <div class="weui-form-preview">
                            <div class="weui-form-preview__hd">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">订单状态</label>
                                    <em class="weui-form-preview__value"><%out.print(fifthList1.get(i).getStatus());%></em>
                                </div>
                            </div>
                            <div class="weui-form-preview__bd">
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">服务实收款</label>
                                    <span class="weui-form-preview__value"><%out.print(fifthList1.get(i).getPayMoney());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">服务对象</label>
                                    <span class="weui-form-preview__value"><%out.print(fifthList3.get(i).getName());%></span>
                                </div>
                                <div class="weui-form-preview__item">
                                    <label class="weui-form-preview__label">服务时间</label>
                                    <span class="weui-form-preview__value">
                                        <%
                                        if(fifthList1.get(i).getStatus().equals("已完成")){
                                            out.print(fifthList1.get(i).getActualBeginTime()+"-"+fifthList1.get(i).getActualEndTime());
                                        }else{
                                            out.print("未进行服务");
                                        }
                                        %>
                                    </span>
                                </div>
                                <div class="weui-panel__ft">
                                    <a href=" " class="weui-cell weui-cell_access weui-cell_link">
                                    <div class="weui-cell__bd">查看更多</div>
                                    <span class="weui-cell__ft"></span>
                                </a>
                            </div>
                            </div>
                        </div>

                        <%}%>
                        <br>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript" class="navbar js_show">
        $("#navbar1").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("#untaken").css('display','');
            $("#taken").css('display','none');
            $("#unfinished").css('display','none');
            $("#unpaid").css('display','none');
            $("#finished").css('display','none');
        });
        $("#navbar2").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("#untaken").css('display','none');
            $("#taken").css('display','');
            $("#unfinished").css('display','none');
            $("#unpaid").css('display','none');
            $("#finished").css('display','none');
        });
        $("#navbar3").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("#untaken").css('display','none');
            $("#taken").css('display','none');
            $("#unfinished").css('display','');
            $("#unpaid").css('display','none');
            $("#finished").css('display','none');
        });
        $("#navbar4").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("#untaken").css('display', 'none');
            $("#taken").css('display', 'none');
            $("#unfinished").css('display', 'none');
            $("#unpaid").css('display', '');
            $("#finished").css('display', 'none');
        });
        $("#navbar5").on('click', function () {
            $(this).addClass('weui-bar__item_on').siblings('.weui-bar__item_on').removeClass('weui-bar__item_on');
            $("#untaken").css('display', 'none');
            $("#taken").css('display', 'none');
            $("#unfinished").css('display', 'none');
            $("#unpaid").css('display', 'none');
            $("#finished").css('display', '');
        });
</script>
</body>
</html>