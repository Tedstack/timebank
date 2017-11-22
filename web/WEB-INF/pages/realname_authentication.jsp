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
<form id="userForm">
    <br>
    <p>
        <label class="weui-form-preview__label">身份证正面</label>
        <input type="file" name="file"/>
    </p>
    <br>
    <p>
        <label class="weui-form-preview__label">身份证反面</label>
        <input type="file" name="file2"/>
    </p>
    <br>
    <p>
        <label class="weui-form-preview__label">身份证件号</label>
        <input class="weui-input" type="number" name="idNum" placeholder="请输入身份证号">
    </p>

    <br>
    <div class="button-sp-area">
        <a href="javascript:;" class="weui-btn weui-btn_primary" type="button" onclick="save()">保存</a>
    </div>
</form>

<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
    /* 保存 */
    function save() {
        //[0]表示获取原生对象
        var formData = new FormData($("#userForm")[0]);

        //还可以手动添加自定义字段，如下：
        //formData.append("userPwd", "123456");

        $.ajax({
            url : 'http://www.hlb9978.com/user/uploadUserInfo',
            type : 'POST',
            data : formData,
            async : false,
            cache : false,
            contentType : false,// 告诉jQuery不要去设置Content-Type请求头
            processData : false,// 告诉jQuery不要去处理发送的数据
            beforeSend: function (XHR) {
                dialogLoading = showLoading();
            },
            success : function(data) {
                alert(data);
                //...
            },
            error : function(data) {
                alert(data);
                //...
            },
            complete: function (xhr, type) {
                dialogLoading.hide();
            }
        });
    }
</script>
</body>

</html>