package com.blockchain.timebank.weixin.util;

import com.alibaba.fastjson.JSONObject;
import com.blockchain.timebank.weixin.model.AccessToken;
import com.blockchain.timebank.weixin.model.JsapiTicket;

/**
 * Created by xu on 2017/7/10.
 */
public class TokenThread implements Runnable {
    public static String appId = Configs.APPID;

    public static String appSecret= Configs.APPSECRET;

    public static AccessToken accessToken = null;

    public static JsapiTicket jsapiTicket = null;

    public final static String js_api_ticket_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";


    public void run() {
        while (true) {//這裏就應該是死循環
            try {
                accessToken = this.getAccessToken();
                jsapiTicket = this.getJsapiTicket();
                if (null != accessToken) {
                    //System.out.println("TokenThread:"+accessToken.getAccessToken());
                    //System.out.println("TokenThread:"+jsapiTicket.getJsapiTicket());
                   // Thread.sleep(7000 * 1000); //获取到access_token 休眠7000秒
                    Thread.sleep(3600 * 1000); //获取到access_token 休眠3600秒

                } else {
                    Thread.sleep(1000 * 3); //获取的access_token为空 休眠3秒
                }
            } catch (Exception e) {
                //System.out.println("发生异常：" + e.getMessage());
                //e.printStackTrace();
                try {
                    Thread.sleep(1000 * 10); //发生异常休眠1秒
                } catch (Exception e1) {

                }
            }
        }
    }

    /**
     * 获取access_token
     * @return
     */
    private AccessToken getAccessToken(){
        NetWorkHelper netHelper = new NetWorkHelper();
        String Url = String.format("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s",this.appId,this.appSecret);
        String result = netHelper.getHttpsResponse(Url,"");
        //System.out.println("getAccessToken:"+result);

        //response.getWriter().println(result);
        JSONObject json = JSONObject.parseObject(result);
        //System.out.println("getAccessToken json:"+json);

        AccessToken token = new AccessToken();
        token.setAccessToken(json.getString("access_token"));
        token.setExpiresin(json.getInteger("expires_in"));
        return token;
    }

    /**
     * 获取jsapi_ticket
     * @return
     */
    private JsapiTicket getJsapiTicket(){
        NetWorkHelper netHelper = new NetWorkHelper();
        String Url = js_api_ticket_url.replace("ACCESS_TOKEN",this.getAccessToken().getAccessToken());
        String result = netHelper.getHttpsResponse(Url,"");
        //System.out.println("getJsapiTicket:"+result);
        JSONObject json = JSONObject.parseObject(result);
        //System.out.println(json);

        JsapiTicket jsapiTicket = new JsapiTicket();
        jsapiTicket.setJsapiTicket(json.getString("ticket"));
        jsapiTicket.setExpiresin(json.getInteger("expires_in"));

        return jsapiTicket;
    }

}
