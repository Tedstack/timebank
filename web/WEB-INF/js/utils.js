function back_to(url){
    window.onload = function() {
        var detectBack = {

            initialize: function () {
                console.log('stat2e', window.addEventListener)
                //监听hashchange事件
                window.addEventListener('hashchange', function () {
                    console.log(111);
                    //为当前导航页附加一个tag
                    this.history.replaceState('hasHash', '', '');

                }, false);

                var state = {
                    title: "title",
                    url: "#"
                };
                history.pushState(state, 'title', '#');

                window.addEventListener('popstate', function (e) {

                    if (e.type === "popstate") {
                        //侦测是用户触发的后退操作, dosomething
                        //这里刷新当前url
                        location.href = url;
                    }
                }, false);
            }
        };

        detectBack.initialize();
    }
}