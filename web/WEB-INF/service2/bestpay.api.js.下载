// Platform:Android, IOS
// Version:2.0
// 翼支付html5访问本地数据api
var DEVICE_IS_IOS = /iP(ad|hone|od)/.test(navigator.userAgent);
function exec(service, action, args) {
	var json = {
		"service" : service,
		"action" : action
	};
	if(DEVICE_IS_IOS){
		var result_str = BestpayHtml5.callNative(JSON.stringify(json), JSON.stringify(args));
		var result = {};
		try{
			result = JSON.parse(result_str);
			var status = result.status;
			var message = result.message;
			return message;
		}catch(e){
			console.error(e.message);
			return null;
		}
	}else{
		var result_str = prompt(JSON.stringify(json), JSON.stringify(args));
		var result = {};
		try {
			result = JSON.parse(result_str);
		} catch (e) {
			console.error(e.message);
		}
		var status = result.status;
		var message = result.message;
		if (status == 0) {
			return message;
		} else {
			console.error("service:" + service + " action:" + action + " error:"
				+ message);
		}
	}

}

function exec_asyn(service, action, args, success, fail, cancel) {
	var json = {
		"service" : service,
		"action" : action
	};
	BestpayHtml5.callNative(JSON.stringify(json), JSON.stringify(args), success, fail, cancel);
}

/**
 * [Payment 支付]
 * @class Payment
 */
function BestPay_Payment(){};
BestPay_Payment.prototype = {
	/**
	 * 业管支付接口
	 * @method pay
	 * @param {[Json]} params 支付参数
	 * @param {[Function]} callback 支付成功回调
	 * @param {[Function]} fail 支付失败回调
	 * @example
	 * 	function pay_success(){
	 * 		alert("支付成功");
	 * 	}
	 * 	function pay_fail(){
	 * 		alert("支付失败");
	 * 	}
	 * 	Payment.pay(payJson, pay_success, pay_fail);
	 */
	pay : function(params, callback, fail) {
		var json = {
			'params' : params
		};
		return exec_asyn("Payment", "pay", json, callback, fail);
	},

	/**
	 * 网关支付接口
	 * @method onPay
	 * @param {[Json]} params	支付参数
	 * @param {[Function]} callback	支付成功回调
	 * @param {[Function]} fail	支付失败回调
	 * @example
	 * 	function pay_success(){
	 * 		alert("支付成功");
	 * 	}
	 * 	function pay_fail(){
	 * 		alert("支付失败");
	 * 	}
	 * 	Payment.onPay(payJson, pay_success, pay_fail);
	 */
	onPay : function(params, callback, fail) {
		var json = {
			'params' : params
		};
		return exec_asyn("Payment", "onPay",json, callback, fail);
	}
}

/**
 * [Scanner 扫码]
 * @class Scanner
 */
function BestPay_Scanner(){};
BestPay_Scanner.prototype = {
	/**
	 * 扫码（二维码、条码）
	 * @method scan
	 * @param {[Json]} params 自定义参数（暂时无用1.0.1）
	 * @param {[Function]} callback － 成功返回时执行的函数
	 * @param {[Function]} fail － 失败返回时执行的函数
	 * @return {[String]} 扫码后得到的字符串
	 * @example
	 * 	function success(bcode){
	 * 		alert("扫描结果：" + bcode);
	 * 	}
	 * 	function fail(msg){
	 * 		alert("扫描失败：" + msg);
	 * 	}
	 * 	Scanner.scan({}, success, fail);
	 * @memo REQUEST_CODE_SCANNER = 3928461；相机静候300秒后自动返回，超时扫码无效
	 */
	scan : function(params, callback, fail) {
		var json = {
			'params' : params
		};
		return exec_asyn("Scanner", "scan",json, callback, fail);
	}
};

/**
 * [User 用户信息]
 * @class User
 */
function BestPay_User(){}
BestPay_User.prototype  = {
	/**
	 * 获取用户产品号
	 * @method getProduct
	 * @return {[String]} 用户产品号，也就是电话号码
	 * @example
	 * 	var product = User.getProduct();
	 */
	getProduct : function() {
		return exec("User", "getProduct", {});
	},
	/**
	 * 获取用户地区码
	 * @method getLocation
	 * @return {[String]} 用户地区码
	 * @example
	 * 	var locationCode = User.getLocation();
	 */
	getLocation : function() {
		return exec("User", "getLocation", {});
	}
};


/**
 * [App H5应用]
 * @class App
 */
function BestPay_App(){}
BestPay_App.prototype = {
	/**
	 * 截断返回键事件，用户在按下返回键的时触发js方法
	 * @method overrideBackPressed
	 * @param {[Boolean]} bound 是否截断
	 * @example
	 * 	App.overrideBackPressed(true);
	 */
	overrideBackPressed : function(bound) {
		var json = {
			"bound" : bound
		}
		return exec("App", "overrideBackPressed", json);
	},
	/**
	 * 设置硬键盘监听，当用户按下返回，菜单，搜索按键的时候，onKeyEvent回调函数会被触发。
	 * @method setKeyEventListener
	 * @param {[Function]} listener 监听方法
	 * @example
	 * 	App.setKeyEventListener(function(){
	 * 		if (event == 'backpress') {
	 * 			back();
	 * 		}
	 * 	});
	 */
	setKeyEventListener : function(listener) {
		App.listener = listener;
	},
	/**
	 * 按键事件监听，如setKeyEventListener设置了监听器，则当用户按下返回，菜单，搜索按键的时候，此函数会被触发
	 * @method onKeyEvent
	 * @param {[Function]} event 事件名称，如backpress、menupress、searchpress
	 */
	onKeyEvent : function(event) {
		if (typeof App.listener == 'function') {
			App.listener(event);
		}
	},
	/**
	 * 返回时执行函数
	 * @method execWhenReturnAndAppear
	 * @param {[String]} jsFunctionName js事件名称
	 * @example
	 * 	App.execWhenReturnAndAppear("toHome();");
	 */
	execWhenReturnAndAppear : function(jsFunctionName) {
		var json = {
			"execWhenReturnAndAppearJSFunc" : jsFunctionName
		}
		exec_asyn("App", "execWhenReturnAndAppear", json);
	},

	/**
	 * 获取客户端版本号， android: >= 3.x.x, ios: >= 2.5.x
	 * @method getClientVersion
	 * @return {[String]} 客户端版本号
	 * @example
	 * 	var clientVersion = App.getClientVersion();
	 */
	getClientVersion: function(){
		return exec("App", "getClientVersionName", {});
	},

	/**
	 * 获取应用ID
	 * @method getAppId
	 * @return {[String]} 当前运行的H5应用ID
	 * @example
	 * 	var appId = App.getAppId();
	 */
	getAppId : function() {
		return exec("App", "getAppId", {});
	},

	/**
	 * 获取子应用版本号
	 * @method getVersion
	 * @return {[String]} 当前运行的H5应用版本号
	 * @example
	 * 	var appVersion = App.getVersion();
	 */
	getVersion : function() {
		return exec("App", "getVersion", {});
	},

	/**
	 * 获取html5应用请求平台需要的key
	 * @method getSecurityKey
	 * @return {[String]} key, android的key值人MANIFEST.properties中获取，ios是写死的
	 * @example
	 * 	var securityKey = App.getSecurityKey();
	 *
	 */
	getSecurityKey : function() {
		return exec("App", "getSecurityKey", {});
	},

	/**
	 * 获取SessionKey
	 * @method getSessionKey
	 * @return {[String]} sessionKey
	 * @example
	 * 	var sessionKey = App.getSessionKey();
	 */
	getSessionKey : function() {
		return exec("App", "getSessionKey", {});
	},

	/**
	 * 验证SessionKey超时后调用自动登录函数
	 * @method autoLogin
	 * @param {[Function]} callback － 回调函数
	 * @return {"sessionKey":"EEDSSDSD"}。失败时sessionKey为""
	 * @example
	 * 	App.autoLogin(function(newSessionKey){
	 * 		if(newSessionKey == ""){
	 * 			alert("会话已过期，请重新登录");
	 * 		}
	 * 	});
	 */
	autoLogin : function(callback) {
		// return exec("App", "autoLogin", null);
		var json = {
			"productNo" : "",
			"location" : ""
		};
		exec_asyn("App", "autoLogin", json, callback);
	},

	/**
	 * 退出应用，html5渲染界面关闭
	 * @method exitApp
	 * @return
	 * @example
	 * 	App.exitApp();
	 */
	exitApp : function() {
		return exec("App", "exitApp", {});
	},

	/**
	 * 设置topbar文字标题
	 * @method setTitle
	 * @param {[String]} title 标题
	 * @example
	 * 	App.setTitle("通信缴费");
	 */
	setTitle : function(title) {
		var json = {
			"title" : title
		};
		exec("App", "setTitle", json);
	},

	/**
	 * 设置topbar右上角图片及事件，不建议使用，使用setTopRightBar代替
	 * @method setTopBarImage
	 * @param {[String]} imgUrl 应用图片相对路径
	 * @param {[String]} funcStr 回调JS函数字符串
	 * @param {[String]} text 文本内容
	 * @param {[String]} textAlign 文本位置[left, right, top, bottom]
	 * @example
	 * 	App.setTopBarImage("img/detail.png", "toDetailPage();");
	 */
	setTopBarImage:function(imgUrl, funcStr, text, textAlign){
		var json={"imageUrl": imgUrl,"callbackJS": funcStr, "text":text, "textAlign": textAlign};
		exec("App", "setTopBarImage", json);
	},
	/**
	 * 设置topbar右上角内容及事件 android: >=5.0.4, ios: >=5.0.4
	 * @method setTopRightBar
	 * @param {[Json]} args json参数，详见example
	 * @example
	 * 	App.setTopRightBar({
	 * 		type: "localImage",	//[text|localImage|remoteImage],		//类型，text为文本
	 * 		value: "img/detail.png"	//case type{ when text then:文本内容， when ...Image then:图片路径}
	 * 	});
	 *	document.addEventListener("topBarClick", function(){
	 *		alert("you're touched me.");
	 *	}, false);
	 */
	setTopRightBar:function(args){
		exec("App", "setTopRightBar", args);
	},
	/**
	 * 显示topbar右上角内容		 android: >=5.0.4, ios: >=5.0.4
	 * @method showTopRightBar
	 * @example
	 * 	App.showTopRightBar();
	 */
	showTopRightBar:function(){
		exec("App", "showTopRightBar", {});
	},
	/**
	 * 显示topbar右上角内容		 android: >=5.0.4, ios: >=5.0.4
	 * @method hideTopRightBar
	 * @example
	 * 	App.hideTopRightBar();
	 */
	hideTopRightBar:function(){
		exec("App", "hideTopRightBar", {});
	},
	/**
	 * 显示topbar右上角图片，不推荐使用，使用App.showTopRightBar 代替
	 * @method showTopBarImage
	 * @example
	 * 	App.showTopBarImage();
	 */
	showTopBarImage:function(){
		exec("App", "showTopBarImage", {});
	},

	/**
	 * 显示topbar右上角图片，不推荐使用，使用App.showTopRightBar 代替
	 * @method hideTopBarImage
	 * @example
	 * 	App.hideTopBarImage();
	 */
	hideTopBarImage: function(){
		exec("App", "hideTopBarImage", {});
	},

	/**
	 * 获取屏分辨率
	 * @method getScreen
	 * @return [X]x[Y]，android通过交互App.getScreen获取，ios直接返回window.screen.width & height
	 * @example
	 * 	App.getScreen();
	 */
	getScreen : function() {
		if(DEVICE_IS_IOS){
			return screen.width+"x"+screen.height;
		}
		return exec("App", "getScreen", {});
	},

	/**
	 * 跳到帐号充值页面，新版本建议用App.jumpToNView("04")代替
	 * @method jumpToAccountRecharge
	 * @param {[String]} location - 地区码信息
	 * @param {[String]} productNo - 当前充值的手机号码
	 * @param {[Function]} success - 成功回调函数
	 * @param {[Function]} fail - 成功回调函数
	 * @example
	 * 	var productNo = User.getProduct();
	 * 	var locationCode = User.getLocation();
	 * 	function success = function(){
	 * 		alert("充值成功");
	 * 	}
	 * 	function fail = function(){
	 * 		alert("充值失败");
	 * 	}
	 * 	App.jumpToAccountRecharge(productNo, locationCode, success, fail);
	 */
	jumpToAccountRecharge : function(productNo, location, success, fail) {
		var json = {
			"productNo" : productNo,
			"location" : location
		}
		exec_asyn("App", "jumpToAccountRecharge", json, success, fail);
	},

	/**
	 * 通过名称跳转到指定原生界面，新版推荐使用App.jumpToNView代替此方法
	 * @method jumpToNativeView
	 * @param {[String]} viewName 预定义的页面名称
	 * @param {[Json]} args bundle参数
	 * @param {[Function]} callback 调用成功返回时调用的函数
	 * @param {[Function]} fail 调用失败时执行的函数
	 * @example
	 * 	function success(){
	 * 		location.reload();
	 * 	}
	 * 	App.jumpToNativeView("RealnameVerifyEntranceActivity", {}, success);
	 */
	jumpToNativeView : function(viewName, args, callback, fail, cancel) {
		if (typeof args == 'undefined')
			args = {};
		var json = args;
		json["viewName"] = viewName;
		exec_asyn("App", "jumpToNativeView", json, callback, fail, cancel);
	},

	/**
	 * 通过编号跳转至指定原生界面 android，ios: >= 2015/12初版本
	 * @method jumpToNView
	 * @param {[String]} viewNo  预定义的页面编号
	 * @param {[Json]} args
	 * @param {[Function]]} success 调用成功返回时调用的函数
	 * @param {[Function]} fail 调用失败时执行的函数
	 * @param {[Function]} cancel 取消时执行的函数
	 * @example
	 * 	function success(){
	 * 		location.reload();
	 * 	}
	 * 	App.jumpToNativeView("01", {}, success);
	 * 	页面编号及参数列表：
	 * 		01：实名认证， 	参数：可空
	 * 		02：客服中心， 	参数：可空
	 * 		03：绑卡，		参数：{
	 * 								bindType: "", //绑定类型 [04：快捷卡， 05：提现， 06：信用卡还款， 07：转账， 08:理财]
	 * 								cardType: ""  //卡类型 [01:仅借记卡， 02：仅贷记卡， 03：借贷都支持]
	 * 							}
	 * 		04：充值，		参数：可空
	 * 		05：提现，		参数：可空
	 * 		06：分享			参数：{
	 * 								title: "",	//标题
	 * 								text: "",	//内容
	 * 								url: "",	//图片地址
	 * 								download:""	//页面链接
	 * 							}
	 * 		08：忘记支付密码
	 * 		09：登录		>= 5.0.5
	 * 		10：活动页跳转	参数：{
	 *								ACTION: "",	//[01：公告，03：新窗口打开]
	 *								URL: "",	//链接地址
	 *								MSGID: ""	//公告ID
	 * 							}
	 */
	jumpToNView: function (viewNo, args, success, fail, cancel){
		var json = {viewNo: viewNo, params: args};
		exec_asyn("App", "jumpToNView", json, success, fail, cancel);
	},

	/**
	 * 跳到绑卡页面，新版建议用App.jumpToNView("03")代替此方法
	 * @method jumpToBindCard
	 * @param {[String]} _from - 跳转来源
	 * @param {[Function]} callback - 调用成功返回时调用的函数
	 * @param {[Function]} fail - 调用失败时执行的函数
	 * @example
	 * 	function success(){
	 * 		alert("绑卡成功");
	 * 	}
	 * 	App.jumpToBindCard("activity525", success);
	 */
	jumpToBindCard : function(_from, callback, fail) {
		if(DEVICE_IS_IOS){
			App.jumpToNativeView("jiaofeizhushou", {}, callback, fail);
		}else{
			var json = {
				"frompage" : _from
			}
			exec_asyn("App", "jumpToBindCard", json,callback, fail);
		}
	},
	/**
	 * 检查客户端更新, 仅android支持， >= 4.5.x
	 * @method jumpToUpdate
	 * @param args
	 * @example
	 * 	App.jumpToUpdate();
	 */
	jumpToUpdate: function(args){
		exec("App", "jumptoUpdate", args);
	},

	/**
	 * 打开安全密码输入
	 * @method openSafeKeyBorad
	 * @param {[String]} len 密码长度，暂固定为6
	 * @param {[String]} title 弹出框标题，可空
	 * @param {[Function]} success_callback 密码输入完成确认后，回调此函数，并返回加密后的密码
	 * @param {[Function]} fail_callback 取消或加密失败时调用
	 * @example
	 * 	function success(pwd){
	 * 		if(pwd == ""){
	 * 			alert("密码不能为空");
	 * 		}
	 * 	}
	 * 	App.openSafeKeyBoard(6, "支付密码", success);
	 */
	openSafeKeyBoard:function(len,title,success_callback, fail_callback){
		len = len || 6;
		title = title || "";
		var _json = {len:len,title:title};
		exec_asyn("App", "openSafeKeyBoard", _json, success_callback, fail_callback);
	},

	/**
	 * 获取设备公共请求参数, android: >= 4.2.5, ios: >= 3.3.0
	 * @method getCommonRequestParams
	 * @return
	 * @example
	 * 	var comParams = App.getCommonRequestParams();
	 */
	getCommonRequestParams:function(){
		var crp = exec("App", "getCommonRequestParams", {});
		return crp;
	},

	/**
	 * 获取当前手机连接的网络类型(wifi | monet | unline)  android: >= 4.2.x, ios: >= 3.2.x
	 * @method getNetworkType
	 * @return {[String]} 当前手机连接的网络类型
	 * @example
	 * 	var networkType = App.getNetworkType();
	 */
	getNetworkType:function(){
		return exec("App", "getNetworkType", {});
	},

	/**
	 * 在新窗口中打开链接 android: >= 4.2.0, ios: >= 3.2.0
	 * @method openBrowser
	 * @param {[String]} url 打开网页的url地址
	 * @param {[Boolean]} inBrowser  >= 5.0.5  是否在浏览器中打开，为false时在App内部打开
	 * @example
	 * 	App.openBrowser("https://www.bestpay.com.cn", false);
	 */
	openBrowser:function(url, inBrowser){
		exec("App","openBrowser",{url:url, inBrowser: inBrowser});
	},

	/**
	 * 跳转到其他H5应用
	 * @method jumpToApp
	 * @param {[Json]} args json参数，见example
	 * @param {[Function]} success 调用成功时调用的参数
	 * @param {[Function]} fail 调用失败时调用的参数
	 * @example
	 * 	App.jumpToApp({
	 * 		appId: "281",	//H5应用ID
	 * 		toPage: "order_list"	//指定页面，可空，由H5应用约定，应用启动时会在url追加参数client_to_page，h5应用通过location.search获取并进行处理
	 *		appType: "2"     //应用类型，可空[1:内部应用，2：外部应用]
	 * 	});
	 * 	应用列表：
	 * 		1131：添益宝
	 * 		481：转账
	 * 		681：通信缴费
	 * 		801：缴费助手
	 * 		881：理财
	 * 		811：红包
	 * 		1991：缴水费
	 * 		1992：缴电费
	 * 		1993：缴燃气费
	 * 		861：甜橙信用
	 * 		182：交通罚款
	 * 		持续更新...
	 */
	jumpToApp: function(args, success, fail){
		var json = args || {};
		exec_asyn("App", "jumpToApp", json, success, fail);
	},
	/**
	 * 设置头部显示隐藏 android: >= 5.0.5
	 * @method setHeaderVisible
	 * @param {[Boolean]} isVisible 是否显示
	 * @example
	 * 	App.setHeaderVisible(false);
	 */
	setHeaderVisible:function(isVisible){
		exec("App","setHeaderVisible",{isVisible:isVisible});
	},
	/**
	 * 分享
	 * @method share
	 * @param {[Json]} args 	分享参数，详见example
	 * @example
	 *	var shareJson = {
	 *   	title: "",  //分享标题
	 *   	text: "",   //分享内容
	 *   	link: "",   //分享链接 
	 *   	imageUrl: ""    //分享图片
	 *	};
	 * 	App.share(shareJson);
	 */
	share:function(args){
		args.download = args.link;
		args.url = args.imageUrl;
		delete args["link"];
		delete args["imageUrl"];
		exec("App", "share", args);
	},
	/**
	 * 二维码分享
	 * @method shareQRCode
	 * @param {[Json]} args 	分享参数，详见example
	 * @example
	 *	var shareJson = {
	 *   	source: "redbag",   //调用来源 
	 *   	expand: {    //扩展参数
	 *   		link: "https://hb.bestpay.com/cn/",
	 *   		name: "陆飞",
	 *   		blessing: "恭喜发财，万事如意",
	 *   	}
	 *	};
	 * 	App.shareQRCode(shareJson);
	 */
	shareQRCode:function(args){
		exec("App", "shareQRCode", args);
	}
};

/**
 [util native提供工具类]
 @class util
 */
function BestPay_Util(){}
BestPay_Util.prototype = {
	/**
	 * 实现base64编码
	 * @method base64Encode
	 * @params {[JSON]} data 要编码的json
	 * @return {[JSON]} result 编码成功的json
	 * @example
	 * 	var source = {name:'ztm';card:'6225'};
	 * 	var result = App.base64Encode(source);
	 * 	//result 为{name:"enRt";card:"NjIyNQ=="}
	 */
	base64Encode : function(jsonobj) {
		if (typeof (jsonobj) == "undefined" || typeof (jsonobj) != "object") {
			return false;
		} else {
			var _result = exec("UtilPlugin", "base64Encode", jsonobj);
			return DEVICE_IS_IOS ? _result : JSON.parse(_result);
		}
	},

	/**
	 * 实现base64解码
	 * @method base64Decode
	 * @params {[JSON]} data 要解码的json
	 * @return {[JSON]} result 解码成功的json
	 * @example
	 * 	var source = {name:"enRt";card:"NjIyNQ=="}
	 * 	var result = App.base64Decode(source);
	 * 	//result 为{name:'ztm';card:'6225'}
	 */
	base64Decode : function(jsonobj) {
		if (typeof (jsonobj) == "undefined" || typeof (jsonobj) != "object") {
			return false;
		} else {
			var _result = exec("UtilPlugin", "base64Decode", jsonobj);
			return DEVICE_IS_IOS ? _result : JSON.parse(_result);
		}
	}

};

/**
 * [Preference 键值对本地数据存储]
 * @class Preference
 */
function BestPay_Preference(){}
BestPay_Preference.prototype = {

	/**
	 * 存储
	 * @method put
	 * @param {[String]} key 键值
	 * @param value 存储的值
	 * @param prefname
	 * @example
	 * 	Preference.put("bestpay_transfer_version", "2.0.0");
	 */
	put : function(key, value, prefname) {
		var args = {
			"key" : key,
			"value" : value,
			"prefname" : prefname
		};
		exec("Preference", "put", args);
	},

	/**
	 * 取值
	 * @method get
	 * @param {[String]} key 键值
	 * @param {[String]} defValue 取得值
	 * @param prefname
	 * @example
	 * 	var verion = Preference.get("bestpay_transfer_version", "");
	 */
	get : function(key, defValue, prefname) {
		var args = {
			"key" : key,
			"defValue" : defValue,
			"prefname" : prefname
		};
		return exec("Preference", "get", args);
	}
};

/**
 *[Storage 本地数据库操作]
 *@class Storage
 */
function BestPay_Storage(){}
BestPay_Storage.prototype = {
	/**
	 * 执行sql
	 * @method execSQL
	 * @param {[String]} dbName 	数据库名
	 * @param sql 	sqlite sql
	 * @param {[Json]} params 	数组 where 数据
	 * @return 返回结果集的字符串，可转化成JSON数组格式。
	 * @example
	 * 	var sql = "select CARD_BIN,BANK_NAME,card_bit from t_bank where CARD_TYPE='1'";
	 * 	var result = Storage.execSQL("CardList.sqlite", sql, null);
	 */
	execSQL : function(dbName, sql, params) {
		var args = {
			"dbName" : dbName,
			"sql" : sql,
			"params" : params
		};

		var result = exec("Storage", "exeSQL", args);
		return DEVICE_IS_IOS ? JSON.stringify(result) : result;
	},

	/**
	 * 建数据库
	 * @method createDatabase
	 * @param {[String]} dbName 	数据库名
	 * @param {[String]} createSQL 	首次执行的创建语句
	 * @param {[String]} upgradSQL 	更新执行的语句
	 * @param {[String]} version 	版本号
	 * @return {[String]} like 'ok'
	 * @example
	 * 	var sql = "create table if not exists bestpay_table (_id integer primary key autoincrement, name text not null)";
	 *	var createResult = Storage.createDatabase("bestpay.db", sql, null, 1);
	 */
	createDatabase : function(dbName, createSQL, upgradSQL, version) {
		var args = {
			"dbName" : dbName,
			"createSQL" : createSQL,
			"upgradSQL" : upgradSQL,
			"version" : version
		};
		return exec("Storage", "createDatabase", args);
	},

	/**
	 * 批量插入
	 * @method batchInsert
	 * @params {String} db	数据库名
	 * @params {String} table	表名
	 * @params {String} columns	列名，以，号分隔
	 * @params {Array.JSON} args	Json数组
	 * @return {String} like 'ok'
	 * @example
	 * 	var list = [{k:"k1", v:"v1"}, {k:"k2", v:"v2"}];
	 * 	var result = Storage.batchInsert("bestpay.db", "bestpay_table", 'k,v', list);
	 */
	batchInsert : function(db, table, columns, data) {
		var args = {
			'dbName' : db,
			'tableName' : table,
			'columns' : columns,
			'data' : data
		};
		return exec("Storage", "batchInsert", args);
	}

};

/**
 *[File 文件操作]
 *@class File
 */
function BestPay_File(){}
BestPay_File.prototype = {
	SERVICE : "File",

	/**
	 * 拷贝文件
	 * @method copy
	 * @param {String} path	原文件路径名
	 * @param {String} newpath 目标路径名
	 * @return {String} like 'ok'
	 * @example
	 * 	File.copy("dir1/city.db", "dir2/city.db")
	 */
	copy : function(path, newpath) {
		var json = {
			"path" : path,
			"newpath" : newpath
		};

		return exec(File.SERVICE, "copy", json);
	},

	/**
	 * 判断文件是否存在
	 * @method exists
	 * @param {String} path	文件路径名
	 * @return {String} 'true'表示存在；'false'表示不存在
	 * @example
	 * 	if(!File.exists("dir1/city.db"){
	 * 		alert("数据库文件不存在");
	 * 	}
	 */
	exists : function(path) {
		var json = {
			file_path : path
		};

		return exec(File.SERVICE, "exists", json);
	},

	/**
	 * 删除文件
	 * @method remove
	 * @param {String} path	文件路径名
	 * @return {String} 'true'表示删除成功；'false'表示删除失败
	 * @example
	 * 	File.remove("dir1/city.db");
	 */
	remove : function(path) {
		var json = {
			"path" : path
		};
		var m_name = DEVICE_IS_IOS ? "delete" : "remove";
		return exec(File.SERVICE, m_name, json);
	}

};

/**
 *[Dialog android风格Dialog]
 *@class Dialog
 */
function BestPay_Dialog(){}
BestPay_Dialog.prototype = {
	/**
	 * 显示原生combobox
	 * @method showSingleChoiceDialog
	 * @param {[String]} title	标题
	 * @param {[Json]} list	单选列表数据 json数组格式
	 * @param check_item	缺省选择的项 0开始
	 * @param display_key	单选列表显示的key list json数组中的key
	 * @param {[Function]} callback 成功回调时调用的函数
	 * @example
	 * 	var list = [{k:"k1", v:"v1"}, {k:"k2", v:"v2"}]
	 * 	var checkedIndex = 0;
	 * 	function selected_callback(resIndex){
	 * 		checkedIndex = checkedIndex;
	 * 		$("#result").html(list[checkedIndex].v);
	 * 	}
	 * 	Dialog.showSingleChoiceDialog("请选择一项", list, checkedIndex, "v", selected_callback)
	 */
	showSingleChoiceDialog : function(title, list, check_item, display_key,callback) {
		var json = {
			"title" : title,
			"list" : list,
			"checkedItem" : check_item,
			"displayKey" : display_key
		};

		return exec_asyn("Dialog", "showSingleChoiceDialog", json, callback, null);
	},

	/**
	 * 显示原生confirm  IOS >= 5.0.4
	 * @method showSwitchDialog
	 * @param {[String]} title	标题
	 * @param {[String]} message	内容
	 * @param {[String]} postext	确定按钮文字
	 * @param {[String]} negtext	取消按钮文字
	 * @param {[Function]} callback 关闭对话框的回调，返回message，确定：OK，取消：CANCEL
	 * @example
	 * 	function callback(result){
	 * 		if("OK" == result){
	 * 			//delete
	 * 		}
	 * 	}
	 * 	Dialog.showSwitchDialog("提示", "确认删除？", "确定", "取消", callback);
	 */
	showSwitchDialog : function(title, message, postext, negtext, callback, fail) {
		var json = {
			"title" : title,
			"message" : message,
			"postext" : postext,
			"negtext" : negtext
		};
		return exec_asyn("Dialog", "showSwitchDialog", json,
			callback, fail);
	},

	/**
	 * 显示等待对话框
	 * @method showProgressDialog
	 * @param {[String]} title 	对话框标题，title和msg现已逐渐废弃
	 * @param {[String]} msg 	对话框内容
	 * @param {[Boolean]} canCancel 	是否支持手动取消  	>=5.0.6
	 * @return 动态分配的id，供关闭对话框
	 * @example
	 * 	var dialogId = Dialog.showProgressDialog();
	 */
	showProgressDialog : function(title, msg, canCancel) {
		if(DEVICE_IS_IOS){
			var msgJson = {
				"msg":msg,
			};
			return exec("showWaitDialog", "showProgressDialog", msgJson);
		}else{
			var json = {
				"title" : title,
				"message" : msg,
				"canCancel": canCancel
			};
			return exec("Dialog", "showProgressDialog", json);
		}
	},

	/**
	 * 关闭等待对话框
	 * @method dismissDialog
	 * @param {[String]} id	对话框id
	 * @example
	 * 	Dialog.dismissDialog(dialogId);
	 */
	dismissDialog : function(id) {
		var json = {
			'id' : id
		};
		return exec("Dialog", "dismissDialog", json);
	},


	/**
	 * 弹出消息对话框
	 * @method alert
	 * @param {[String]} msg
	 * @example
	 * 	Dialog.alert("系统繁忙，请重试...");
	 */
	alert : function(msg) {
		if(DEVICE_IS_IOS){
			var msgJson = {"msg":msg};
			exec("Dialog","alert",msgJson);
		}else{
			window.alert(msg);
		}
	},


	/**
	 * 关闭所有弹出的对话框，仅ios支持
	 * @method closeDialog
	 * @example
	 * 	Dialog.closeDialog();
	 */
	closeDialog:function(){
		exec("Dialog","closeDialog",{});
	}

};


/**
 *[Toast Toast提示]
 *@class Toast
 */
function BestPay_Toast(){}
BestPay_Toast.prototype = {
	LENGTH_LONG : 1,
	LENGTH_SHORT : 0,

	/**
	 * [makeText 显示toast消息]
	 * @method makeText
	 * @param text {[String]} 文本消息
	 * @param duration {[String]} 消息显示持续时间，单位为秒   ios >= 5.0.1
	 * @example
	 * 	Toast.makeText("短信发送成功", 3);
	 */
	makeText : function(text, duration) {
		var json = {
			"text" : text,
			"duration" : duration
		}
		exec("Toast", "makeText", json);
	}
};

/**
 *[Contacts 通讯录]
 *@class Contacts
 */
function BestPay_Contacts(){}
BestPay_Contacts.prototype = {

	/**
	 * 打开通讯录联系人
	 * @method openContacts
	 * @param {[Function]} success 选择联系人后的回调，返回联系人号码
	 * @param {[Function]} fail 失败回调
	 * @example
	 * 	function success(phone_no){
	 *		alert(phone_no)
	 * 	}
	 * 	Contacts.openContacts(success)
	 */
	openContacts : function(success, fail) {
		exec_asyn("Contacts", "openContacts", {}, success, fail);
	},

	/**
	 * 打电话
	 * @method tel
	 * @param tel {[String]} 电话号码
	 * @example
	 * 	Contacts.tel("13222322343");
	 */
	tel : function(tel){
		var json = {'tel' : tel}
		return exec("Contacts", "call", json);
	},

	/**
	 * 获取通讯录联系人列表 >= 5.0.4(同步)， >=5.0.8(异步)
	 * @method getContacts
	 * @return 通讯录联系人列表
	 * @example
	 * 	Contacts.getContacts(function(phoneList){
	 *		//phoneList[{name:"路飞", num:"13737378888"},...]
	 *	}, function(){});
	 *	
	 */
	getContacts:function(success, fail){
		exec_asyn("Contacts","getContacts", {}, success, fail);
	}
};

/**
 *[MessageDigest 摘要算法]
 *@class MessageDigest
 */
function BestPay_MessageDigest(){}
BestPay_MessageDigest.prototype = {

	/**
	 * 摘要计算
	 * @method digest
	 * @param {[String]} algorithm	算法名
	 * @param source	文本资源
	 * @return 计算后的文本
	 * @example
	 * 	var sig = MessageDigest.digest("md5", "abcd")
	 */
	digest : function(algorithm, source) {
		var json = {
			"algorithm" : algorithm,
			"source" : source
		}
		return exec("MessageDigest", "digest", json);
	}


};

/**
 * [Security 安全模块,算法实现由native决定，秘钥也在native中。所有应用只提供一套算法]
 * @class Security
 */
function BestPay_Security(){}
BestPay_Security.prototype = {
	/**
	 * [encrypt des算法加密文本]
	 * @method encrypt
	 * @param source 需要加密的文本
	 * @return 加密后的文本
	 * @example
	 * 	var es = Security.encrypt("xxx");
	 */
	encrypt : function(source) {
		var json = {
			"source" : source
		}
		return exec("Security", "encrypt", json);
	},


	/**
	 * [decrypt des算法解密十六进制字符串]
	 * @method decrypt
	 * @param source 需要解密的文本
	 * @return 解密后的文本
	 * @example
	 * 	var ori = Security.decrypt("xxx");
	 */
	decrypt : function(encryptedData) {
		var json = {
			"encryptedData" : encryptedData
		}
		return exec("Security", "decrypt", json);
	},


	/**
	 * [pinkeyEncrypt]
	 * @method pinkeyEncrypt
	 * @param source 文本资源
	 * @param salt
	 * @return 加密结果
	 * @example
	 *	var pe = Security.pinkeyEncrypt("xxx", "news");
	 */
	pinkeyEncrypt : function(source, salt) {
		var json = {
			"source" : source,
			"salt" : salt
		}
		return exec("Security", "pinkeyEncrypt", json);
	}

};

/**
 * [Camera 相机模块]
 * @class Camera
 */
function BestPay_Camera(){};
BestPay_Camera.prototype.chooseImage = function(args, success, fail){
	/**
	 * 拍照或从相册中选择照片		>= 5.0.5
	 * @method chooseImage
	 * @param args json参数，见example
	 * @example
	 *	bp.chooseImage({
     * 		dataType: 'dataURL',    //结果数据格式:dataURL: base64编码的图片数据；
     * 		imageFormat: 'jpg', //图片格式：jpg / png
     *  	quality: 75,    //jpg的图片质量, 取值1到100
     * 		maxWidth: 500,  //图片的最大宽度. 过大将被等比缩小
     * 		maxHeight: 500, //图片的最大高度. 过大将被等比缩小
     * 		allowEdit: true //是否允许编辑(框选). 为true时，拍照时会有一个方形的选框
	 *	}, function(result){    //成功选择图片后的回调
     *		image = document.getElementById('myImage');
     *		image.src = "data:image/jpeg;base64," + result;
	 *	});
	 */
	exec_asyn("Camera", "chooseImage", args, success, fail)
}

window.Payment = new BestPay_Payment();
window.Scanner = new BestPay_Scanner();
window.User = new BestPay_User();
window.App = new BestPay_App();
window.util = new BestPay_Util();
window.Preference = new BestPay_Preference();
window.Storage = new BestPay_Storage();
window.File = new BestPay_File();
window.Dialog = new BestPay_Dialog();
window.Toast = new BestPay_Toast();
window.Contacts = new BestPay_Contacts();
window.MessageDigest = new BestPay_MessageDigest();
window.Security = new BestPay_Security();
window.Camera = new BestPay_Camera();

/**
 * Html5与Android同步交互接口
 * 在本应用中，prompt被拦截（DroidHtml5中的WebServerChromeClient中的onJsPrompt方法），
 * Android本地代码会拦截该对话框，取得JavaScript数据，解析处理数据后，将结果返回给JavaScript。
 *
 * @params {String} service 使用的Service，即后台IPlugin的实现类 @params {String} action
 * 在IPlugin中执行哪个方法 @params {JSON} args 传递给该方法的参数。如果不需要参数则设置为null
 */
var BestpayHtml5 = {
	idCounter : 0,
	INPUT_CMDS : {},
	INPUT_ARGS : {},
	OUTPUT_RESULTS : {},
	RESULT_CODE: false,
	backEvent: null,
	topBarClickEvent: null,
	CALL_STATUS:{
		SUCCESS: 0,
		FAIL: 1,
		CANCEL:2
	},
	CALLBACK_SUCCESS : function(result) {
		console.log("success:" + result);
		return;
	},
	CALLBACK_FAIL : function(result) {
		console.log("fail:" + result);
		return;
	},
	CALLBACK_CANCEL: function(result){
		console.log("cancel:" + result);
	},
	callNative : function(cmd, args, success, fail, cancel) {
		var key = "ID_" + (++this.idCounter);
    	if (typeof success == 'function') this.CALLBACK_SUCCESS[key] = success;
    	if (typeof fail == 'function') this.CALLBACK_FAIL[key] = fail;
    	if (typeof cancel == 'function') this.CALLBACK_CANCEL[key] = cancel;
		if(DEVICE_IS_IOS){
			this.INPUT_CMDS[key] = cmd;
			this.INPUT_ARGS[key] = args;
		}else{
			window.nintf.setCmds(cmd, key);
			window.nintf.setArgs(args, key);
		}

		var iframe = document.createElement("IFRAME");
		iframe.setAttribute("src", "bestpayhtml://ready?id=" + key);
		document.documentElement.appendChild(iframe);
		iframe.parentNode.removeChild(iframe);
		iframe = null;

		console.log("return this.OUTPUT_RESULTS:" + this.OUTPUT_RESULTS[key]);
		BestpayHtml5.RESULT_CODE = -1;
		return this.OUTPUT_RESULTS[key]; //同步调用时返回值
	},
	getInputCmd : function(key) {
		return this.INPUT_CMDS[key];
	},
	getInputArgs : function(key) {
		return this.INPUT_ARGS[key];
	},

	callBackJs : function(result, key) {
        this.OUTPUT_RESULTS[key] = result;
        var obj = JSON.parse(result);
        var message = obj.message;
        if(typeof message == "object"){
        	message = JSON.stringify(message)
        }else{
        	message = "'" + message + "'"
        }
        var status = obj.status;
        this.RESULT_CODE = status;
        if(status == this.CALL_STATUS.SUCCESS){
            if (typeof this.CALLBACK_SUCCESS[key] == "function"){
                setTimeout("BestpayHtml5.CALLBACK_SUCCESS['" + key + "'](" + message + ")",0);
            }
        }else if( status == BestpayHtml5.CALL_STATUS.FAIL){
            if (typeof this.CALLBACK_FAIL[key] == "function"){
                setTimeout("BestpayHtml5.CALLBACK_FAIL['" + key + "'](" + message + ")",0);
            }
        }else if( status == BestpayHtml5.CALL_STATUS.CANCEL){
            if (typeof this.CALLBACK_FAIL[key] == "function"){
                setTimeout("BestpayHtml5.CALLBACK_CANCEL['" + key + "'](" + message + ")",0);
            }
        }
	},
	init: function(){
		this.topBarClickEvent = this.getEvent("topBarClick");
	},
	getEvent: function(ename, canBubble, cancelable){
		var ev = document.createEvent("CustomEvent");
		ev.initCustomEvent(ename, canBubble, cancelable, {});
		return ev;
	},
	fireEvent: function(eventObj){
		try{
			document.dispatchEvent(eventObj);
		}catch(ex){
			console.log("dispatchEvent error." + ex)
		}
	}
};
BestpayHtml5.init();