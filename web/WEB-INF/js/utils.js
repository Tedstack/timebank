function back_to(url){
        var state = {
            title: "",
            url: ""
        };
        history.pushState(state, '', '');

        window.addEventListener('popstate', function (e) {

            if (e.type === "popstate") {
                history.go(0);
                location.href = url;
            }
        }, false);
}

function normal_back(){

        var state = {
            title: "",
            url: ""
        };
        history.pushState(state, '', '');

        window.addEventListener('popstate', function (e) {

            if (e.type === "popstate") {
                history.go(-2);
            }
        }, false);


}

function get_wx_config () {
    $.ajax({
        url : "http://www.i-huzhu.com/timebanktest/scanGetConfigServlet",
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
                jsApiList : [ 'closeWindow', 'onMenuShareTimeline',
                    'onMenuShareAppMessage' ]
            });
        }
    });
}


function back_exit(){
    wx.ready(function () {
        var state = {
            title: "",
            url: ""
        };
        history.pushState(state, '', '');

        window.addEventListener('popstate', function (e) {
            if (e.type === "popstate") {
                if(confirm("确认退出？"))
                    wx.closeWindow();
                else{
                    history.pushState(state, '', '');
                }
            }
        }, false);
    });
}
//增加分享链接到微信朋友圈和分享给朋友
function share(title,link,desc){
    wx.ready(function(){
        // wx.hideOptionMenu();
        wx.onMenuShareTimeline({
            title: title,
            link: link,
            imgUrl: '',
            success: function () {
                // 用户确认分享后执行的回调函数
                alert('分享到朋友圈成功');
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
                alert('你没有分享到朋友圈');
            }
        });
        wx.onMenuShareAppMessage({
            title:title,
            desc: desc ,
            link: link ,
            imgUrl: '',
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