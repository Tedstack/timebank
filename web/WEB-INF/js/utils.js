function get_wx_config () {
    console.log(new Date().toLocaleTimeString());
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
            console.log(new Date().toLocaleTimeString());
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
function share(share_title,share_link,share_imgUrl,share_descr){
    wx.ready(function(){
        wx.checkJsApi({
            jsApiList: ['onMenuShareTimeline', 'onMenuShareAppMessage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
            success: function(res) {
                console.log(res);
            }
        });
        // wx.hideOptionMenu();
        wx.onMenuShareTimeline({
            title: share_title,
            link: 'http://www.i-linli.com/timebanktest/' + share_link,
            imgUrl: 'http://www.i-linli.com/timebanktest/img/'+share_imgUrl,
            success: function () {
                alert('分享到朋友圈成功');
                },
            cancel: function () {
                alert('你没有分享到朋友圈');
            }
        });

        wx.onMenuShareAppMessage({
            title: share_title,
            desc: '邻里智助————'+share_descr ,
            link: 'http://www.i-linli.com/timebanktest/' + share_link ,
            imgUrl: 'http://www.i-linli.com/timebanktest/img/'+share_imgUrl,
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
