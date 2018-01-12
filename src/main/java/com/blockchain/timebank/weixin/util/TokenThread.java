package com.blockchain.timebank.weixin.util;

import com.alibaba.fastjson.JSONObject;
import com.blockchain.timebank.weixin.model.AccessToken;
import com.blockchain.timebank.weixin.model.JsapiTicket;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

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
            //int count = 0;
            File file = null;
            FileWriter fw=null;
            try{
                file = new File("/home/ubuntu/logs/access_token_log.txt");
                fw = new FileWriter(file,true);
            }catch(Exception e){
                e.printStackTrace();
            }
            SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SimpleDateFormat format2 = new SimpleDateFormat("HH:mm");
            PrintWriter pw = new PrintWriter(fw);
            try {
                accessToken = this.getAccessToken();
                jsapiTicket = this.getJsapiTicket();
                long timestamp = new Date().getTime();
                long lastTokenTime =timestamp/3600000;
                pw.println(bartDateFormat.format(timestamp));
               /* if("00:00".equals(format2.format(timestamp))){
                    pw.println(bartDateFormat.format(new Date().getTime()));
                    count=0;
                }*/
                //count++;
                //pw.println("access_token获取第"+count+"次"+accessToken.getAccessToken());
                pw.println("access_token获取"+accessToken.getAccessToken());
                if (null != accessToken) {
                    pw.flush();
                    while(true){
                        Thread.sleep(60 * 1000);
                        if(new Date().getTime()/3600000 != lastTokenTime){
                            pw.println("睡眠已到时间,更新access_token");
                            break;
                        }
                    }

                } else {
                    pw.println("获取accessToken为空，线程睡3秒");
                    pw.flush();
                    Thread.sleep(1000 * 3); //获取的access_token为空 休眠3秒
                }
                pw.flush();
            } catch (Exception e) {
                //System.out.println("发生异常：" + e.getMessage());
                e.printStackTrace();
                pw.println("发生异常：" + e.getMessage());
                pw.flush();
                try {
                    Thread.sleep(1000 * 10); //发生异常休眠1秒
                    pw.println("获取accessToken失败，线程休眠10秒");
                    pw.flush();
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
        String Url = js_api_ticket_url.replace("ACCESS_TOKEN",accessToken.getAccessToken());
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
