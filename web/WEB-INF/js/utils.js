function get_wx_config () {
    wx.checkJsApi({
        jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
        success: function(res) {
            alert(res);
        }
    });
    $.ajax({
        url : "http://www.i-linli.com/timebanktest/scanGetConfigServlet",
        type : 'post',
        dataType : 'json',
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        async: true,
        data : {
            'url' : location.href.split('#')[0]
        },
        success : function(data) {
            wx.config({
                debug : false,
                appId : data.appId,
                timestamp : data.timestamp,
                nonceStr : data.nonceStr,
                signature : data.signature,
                jsApiList : ['onMenuShareTimeline', 'onMenuShareAppMessage']
            });
        }
    });
}

//增加分享链接到微信朋友圈和分享给朋友
function share(){
    wx.ready(function(){
        // wx.hideOptionMenu();
        wx.onMenuShareTimeline({
            title: '测试',
            link: 'http://www.i-linli.com/timebanktest/team/teamList',
            imgUrl: 'http://www.i-linli.com/timebanktest/img/activityImg/活动.png',
            success: function () {
                alert('分享到朋友圈成功');
                },
            cancel: function () {
                alert('你没有分享到朋友圈');
            }
        });

        wx.onMenuShareAppMessage({
            title: '测试',
            desc: '测试' ,
            link: 'http://www.i-linli.com/timebanktest/team/teamList' ,
            imgUrl: 'http://www.i-linli.com/timebanktest/img/activityImg/活动.png',
            trigger: function (res) {
                // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
            },
            success: function (res) {
                alert('分享给朋友成功');
                },
            cancel: function (res) {
                alert('你没有分享给朋友');
                },
            fail: function (res) {
                alert(JSON.stringify(res));
            }
        });
    });
}
function photoCompress(file,w,objDiv){
    var ready=new FileReader();
    ready.readAsDataURL(file);
    ready.onload=function(){
        var re=this.result;
        canvasDataURL(re,w,objDiv)
    }
}
function canvasDataURL(path, obj, callback) {
    var img = new Image();
    img.src = path;
    img.onload = function () {
        var that = this;
        // 默认按比例压缩
        var w = that.width,
            h = that.height,
            scale = w / h;
        w = obj.width || w;
        h = obj.height || (w / scale);
        var quality = 0.7;  // 默认图片质量为0.7
        //生成canvas
        var canvas = document.createElement('canvas');
        var ctx = canvas.getContext('2d');
        // 创建属性节点
        var anw = document.createAttribute("width");
        anw.nodeValue = w;
        var anh = document.createAttribute("height");
        anh.nodeValue = h;
        canvas.setAttributeNode(anw);
        canvas.setAttributeNode(anh);
        ctx.drawImage(that, 0, 0, w, h);
        // 图像质量
        if (obj.quality && obj.quality <= 1 && obj.quality > 0) {
            quality = obj.quality;
        }
        // quality值越小，所绘制出的图像越模糊
        var base64 = canvas.toDataURL('image/jpeg', quality);
        // 回调函数返回base64的值
        callback(base64);
    }
}
function convertBase64UrlToBlob(urlData){
    var arr = urlData.split(','), mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
    while(n--){
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], {type:mime});
}
