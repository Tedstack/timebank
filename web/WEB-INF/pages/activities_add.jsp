<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.blockchain.timebank.entity.TeamEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <title>活动发布</title>
    <link rel="stylesheet" href="../css/weui.css">
    <link rel="stylesheet" href="../css/weui-example.css">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link href="../css/mobile-main.css" rel="stylesheet" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
    <script src="../js/scan/configs.js"></script>
</head>
<body>

<div class="weui-tab">
    <form id="teamDetail" method="post">
    <div class="weui-tab__panel">
        <div class="weui-panel__hd">
            <div class="weui-flex__item"id="return" onclick="history.go(-1)" >
                <p><img src="../img/返回.png" width="20" height="15"alt="">发布活动</p>
            </div>
        </div>
        <div class="weui-cells_form weui-cells">
            <div class="weui-cell" style="margin-left: 130px;">
                <div class="weui-cell__bd">
                    <div class="weui-flex">
                        <div class="weui-flex__item weui-flex justify align">
                            <div class="weui-uploader">
                                <div class="weui-uploader__hd" style="margin-bottom: 0px;">
                                    <p class="weui-uploader__title" style="margin: 0 0 0 0;">添加活动封面</p>
                                </div>
                                <div class="weui-uploader__bd">
                                    <ul class="weui-uploader__files" id="files1" style="margin-bottom: 0px;"></ul>
                                    <div class="weui-uploader__input-box" style="width: 100px;height: 110px;">
                                        <input id="file1" name="file1" class="weui-uploader__input" type="file" accept="image/*">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="weui-panel__bd">
            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__bd">
                    <p>团队选择</p>
                </div>
                <div class="weui-cell__bd">
                    <select id="teamOptions" class="weui-select" name="teamId">
                        <c:forEach var="value" items="${teamList}">
                            <option value="${value.id}">
                                ${value.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__bd">
                    <p>活动类型</p>
                </div>
                <div class="weui-cell__bd">
                    <select id="activityType" class="weui-select" name="activityType">
                        <option value="志愿者">志愿者</option>
                        <option value="社区">社区</option>
                    </select>
                </div>
            </div>

            <div class="weui-cell weui-cell_select weui-cell_select-after">
                <div class="weui-cell__bd">
                    <p>是否公开</p>
                </div>
                <div class="weui-cell__bd">
                    <select id="isPublicOptions" class="weui-select" name="isPublicOptions">
                        <option value="true">公开</option>
                        <option value="false">不公开</option>
                    </select>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动名称</p></div>
                <div class="weui-cell__bd">
                    <input id="activityName" name="activityName" class="weui-input" type="text" placeholder="请输入活动名称"/>
                </div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动描述</p>
                </div>
                <div class="weui-cell__bd">
                    <div class="weui-cell__bd">
                        <textarea id="description" class="weui-textarea" name="description" placeholder="请输入描述" rows="3"></textarea>
                        <%--<div class="weui-textarea-counter"><span>0</span>/200</div>--%>
                    </div>
                </div>
            </div>

            <%
                Date nowDate = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                String nowTime = formatter.format(nowDate);
            %>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动开始时间</p>
                </div>
                <div class="weui-cell__bd">
                    <input id="beginTime" class="weui-input" name="beginTime" type="datetime-local" value="2018-1-1T12:00" min="<%out.print(nowTime);%>"/>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动结束时间</p>
                </div>
                <div class="weui-cell__bd">
                    <input id="endTime" class="weui-input" name="endTime" type="datetime-local" value="2018-1-1T12:00" min="<%out.print(nowTime);%>" />
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>申请加入活动截至时间</p>
                </div>
                <div class="weui-cell__bd">
                    <input id="applyEndTime" name="applyEndTime" class="weui-input" type="datetime-local" value="2018-1-1T12:00"  min="<%out.print(nowTime);%>"/>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>参与人数</p>
                </div>
                <div class="weui-cell__bd">
                    <input id="count" class="weui-input" name="count" type="number" pattern="[0-9]*" placeholder="请输入参与人数"/>
                </div>
            </div>

            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>活动详细地址</p>
                </div>
                <div class="weui-cell__bd">
                    <input id="address" class="weui-input" name="address" type="text" placeholder="请输入详细地址"/>
                </div>
            </div>
        </div>
        <div style="padding: 10px; margin-bottom: 20px;">
            <a href="javascript:;" id="submitBtn" class="weui-btn weui-btn_primary">发布</a>
        </div>
    </div>
    </form>
</div>

<!-- jQuery 3 -->
<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    var xmlHttpRequest;
    $(function(){
        if(window.XMLHttpRequest){
            xmlHttpRequest=new XMLHttpRequest();
        }else{
            xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttpRequest.open("GET","AjaxServlet",true);
    });

    var contextPath="${pageContext.request.contextPath}";

    $(function(){
        var tmpl = '<li class="weui-uploader__file" style="background-image:url(#url#)"></li>',
            $uploaderInput1 = $("#file1"),
            $uploaderFiles1 = $("#files1");
        $uploaderInput1.on("change", function(e){
            var src, url = window.URL || window.webkitURL || window.mozURL, files = e.target.files;
            for (var i = 0, len = files.length; i < len; ++i) {
                var file = files[i];

                if (url) {
                    src = url.createObjectURL(file);
                } else {
                    src = e.target.result;
                }

                $uploaderFiles1.append(tmpl.replace("#url#", src));
                $uploaderInput1.parent().hide();
            }
        });
        $uploaderFiles1.on("click", "li", function(){
            $galleryImg.attr("style", this.getAttribute("style"));
            $gallery.fadeIn(100);
        });
        $("#submitBtn").on('click',function () {
            var activityType=$("#activityType ").val();
            var activityName = $('#activityName').val();
            var description = $('#description').val();
            var beginTime = $('#beginTime').val();
            var endTime = $('#endTime').val();
            var applyEndTime = $('#applyEndTime').val();
            var count = $('#count').val();
            var address = $('#address').val();
            var formData = new FormData($("#teamDetail")[0]);
            if(activityName===""){
                showAlert("请填写活动名称");
                return;
            }

            if(description===""){
                showAlert("请填写活动描述");
                return;
            }

            if(beginTime===""){
                showAlert("请选择活动开始时间");
                return;
            }

            if(endTime===""){
                showAlert("请选择活动结束时间");
                return;
            }
            
            if(applyEndTime===""){
                showAlert("请选择申请加入活动结束时间");
                return;
            }

            if(count===""){
                showAlert("请填写参与人数");
                return;
            }else if(count==="0"){
                showAlert("参与人数不能为0");
                return;
            }

            if(address===""){
                showAlert("请填写活动地址");
                return;
            }

            if(activityType===""){
                showAlert("请循着活动类型");
                return;
            }

            if(beginTime>endTime){
                showAlert("活动结束时间不能早于活动开始时间");
                return;
            }

            if(applyEndTime>endTime){
                showAlert("申请加入活动时间不能晚于活动结束时间");
                return;
            }

            if(jQuery("input[id='file1']").val()===""){
                showAlert("请上传一张活动封面");
                return;
            }

            var targetUrl = "http://"+getDomainName()+contextPath+"/team/publishActivity";
            var targetUrl2 = "http://"+getDomainName()+contextPath+"/publish/activities_category";
            $.ajax({
                type: 'POST',
                cache: false,
                url: targetUrl,
                //dataType:'JSONP',
                // data: "teamId=" + teamID +"&activityType=" + activityType + "&isPublic=" + isPublic + "&activityName=" + activityName + "&description=" + description + "&beginTime=" + beginTime +"&endTime=" + endTime +"&applyEndTime=" + applyEndTime + "&count=" + count +"&address=" + address,
                data:formData,
                async: false,
                contentType: false,// 告诉jQuery不要去设置Content-Type请求头
                processData: false,
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data==="ok"){
                        showAlert("发布成功",function () {
                            goTo(targetUrl2);
                        });
                    }else{
                        showAlert("发布失败");
                    }
                },
                error: function (xhr, type) {
                    showAlert("发布失败");
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        });
    });
</script>

</body>
</html>
