function back_to(url){
        var state = {
            title: "title",
            url: "#"
        };
        history.pushState(state, 'title', '#');

        window.addEventListener('popstate', function (e) {

            if (e.type === "popstate") {
                history.go(0);
                location.href = url;
            }
        }, false);
}

function normal_back(){

        var state = {
            title: "title",
            url: "#"
        };
        history.pushState(state, 'title', '#');

        window.addEventListener('popstate', function (e) {

            if (e.type === "popstate") {
                history.go(-2);
            }
        }, false);


}

$(document).ready(function () {
    $.ajax({
        url : "http://www.i-linli.com/timebanktest/scanGetConfigServlet",
        type : 'post',
        dataType : 'json',
        contentType : "application/x-www-form-urlencoded; charset=utf-8",
        async: false,
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
                jsApiList : [ 'closeWindow' ]
            });
        }
    });
});


function back_exit(){
    
    var state = {
        title: "title",
        url: "#"
    };
    history.pushState(state, 'title', '#');

    window.addEventListener('popstate', function (e) {
        if (e.type === "popstate") {
            wx.closeWindow();

        }
    }, false);


}
