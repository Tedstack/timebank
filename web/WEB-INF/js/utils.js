function back_to(url){
    window.onpageshow = function() {
        var state = {
            title: "title",
            url: "#"
        };
        history.pushState(state, 'title', '#');

        window.addEventListener('popstate', function (e) {

            if (e.type === "popstate") {
                location.href = url;
            }
        }, false);
    }
}

function normal_back(){
    window.onpageshow = function() {

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
}

function back_exit(){
    window.onpageshow = function() {

        var state = {
            title: "title",
            url: "#"
        };
        history.pushState(state, 'title', '#');

        window.addEventListener('popstate', function (e) {

            if (e.type === "popstate") {
                if
                (confirm("您确定要关闭本页吗？")){
                    wx.closeWindow();
                }
                else{}
            }
        }, false);

    }
}
