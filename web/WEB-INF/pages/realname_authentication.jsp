<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>实名认证</title>
    <link rel="stylesheet" href="https://res.wx.qq.com/open/libs/weui/0.3.0/weui.css" />
    <link rel="stylesheet" href="../css/weui.min.css" />
    <script src="../js/zepto/zepto.min.js"></script>
    <script src="../js/zepto/weui.min.js"></script>
    <script src="../js/scan/function.js"></script>
</head>
<body>
<div class="page">
    <form class="page__bd" style="height: 100%;"id="userForm">
        <br>
        <p>
            <label class="weui-form-preview__label">身份证正面</label>
            <input type="file" id="file1" name="file" value="()"/>
        </p>
        <br>
        <p>
            <label class="weui-form-preview__label">身份证反面</label>
            <input type="file" id="file2" name="file2" value="()"/>
        </p>
        <br>
        <p>
            <label class="weui-form-preview__label">身份证件号</label>
            <input class="weui-input" type="number" id="ID" name="idNum" placeholder="请输入身份证号">
        </p>

        <br>
        <div class="button-sp-area">
            <a href="javascript:;" class="weui-btn weui-btn_primary" type="button" id="button1">保存</a>
        </div>
    </form>
</div>

</body>

<%--<form id="userForm">--%>
    <%--<br>--%>
    <%--<p>--%>
        <%--<label class="weui-form-preview__label">身份证正面</label>--%>
        <%--<input type="file" id="file1" name="file" value="()"/>--%>
    <%--</p>--%>
    <%--<br>--%>
    <%--<p>--%>
        <%--<label class="weui-form-preview__label">身份证反面</label>--%>
        <%--<input type="file" id="file2" name="file2" value="()"/>--%>
    <%--</p>--%>
    <%--<br>--%>
    <%--<p>--%>
        <%--<label class="weui-form-preview__label">身份证件号</label>--%>
        <%--<input class="weui-input" type="number" id="ID" name="idNum" placeholder="请输入身份证号">--%>
    <%--</p>--%>

    <%--<br>--%>
    <%--<div class="button-sp-area">--%>
        <%--<a href="javascript:;" class="weui-btn weui-btn_primary" type="button" id="button1">保存</a>--%>
    <%--</div>--%>
<%--</form>--%>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    /* 保存 */
    $(function() {
        $("#button1").on('click', function () {
            var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
            var idnum=jQuery("input[id='ID']").val();
            if(jQuery("input[id='file1']").val()!==""){
                //未选择文件
                if(jQuery("input[id='file2']").val()!==""){
                   if(idnum!==""){
                       //进行身份证合法性验证
                       if(reg.test(idnum)){
                           showAlert("文件已上传，等待审核，请勿重复上传",post());
                       }
                       else{
                           showAlert("身份证号输入错误，请确定是否正确输入！");
                       }

                   }
                   else{
                       showAlert("请输入身份证号！");
                   }
                }
                else{
                    showAlert("请上传身份证背面照片！");
                }
            }
            else{
                showAlert("请上传身份证照片！");
            }
        });
        function post(){
            //[0]表示获取原生对象
            var formData = new FormData($("#userForm")[0]);
            $.ajax({
                url: 'http://www.coocir.com/timebank/user/uploadUserInfo',
                type: 'POST',
                data: formData,
                async: false,
                cache: false,
                contentType: false,// 告诉jQuery不要去设置Content-Type请求头
                processData: false,// 告诉jQuery不要去处理发送的数据
                beforeSend: function (XHR) {
                    dialogLoading = showLoading();
                },
                success: function (data) {
                    if(data=="upload success")
                    {
                        location.href="http://www.coocir.com/timebank/user/realnameNotification";
                    }
                    //...
                },
                error: function (data) {
                    if(data=="failure")
                    {
                        showAlert("很抱歉，上传信息失败，请稍后尝试！");
                    }
                    //...
                },
                complete: function (xhr, type) {
                    dialogLoading.hide();
                }
            });
        }
    });
</script>
</body>

</html>