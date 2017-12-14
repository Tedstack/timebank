package com.blockchain.timebank.wxpay;

/**
 * 服务号相关信息
 * 支付相关参数
 */

public class ConfigUtil {

    public final static String APPID = "wx1c0cd113cada8f82";//服务号的应用号
    public final static String MCH_ID = "1491443062 ";//商户号
    public final static String API_KEY = "***";//API密钥
    public final static String SIGN_TYPE = "MD5";//签名加密方式
    public final static String NOTIFY_URL = "";//异步接收微信支付结果通知的回调地址，通知url必须为外网可访问的url，不能携带参数。
    public final static String TRADE_TYPE_JS = "JSAPI";

    public final static String UNIFIED_ORDER_URL = "https://api.mch.weixin.qq.com/pay/unifiedorder";//统一下单地址

   /* public static String getAPPID() {
        return APPID;
    }

    public static String getMchId() {
        return MCH_ID;
    }

    public static String getApiKey() {
        return API_KEY;
    }

    public static String getSignType() {
        return SIGN_TYPE;
    }

    public static String getNotifyUrl() {
        return NOTIFY_URL;
    }

    public static String getUnifiedOrderUrl() {
        return UNIFIED_ORDER_URL;
    }*/
}
