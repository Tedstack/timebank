package com.blockchain.timebank.weixin.util;

import com.alibaba.fastjson.JSONObject;
import com.blockchain.timebank.weixin.model.AccessToken;
import com.blockchain.timebank.weixin.model.JsapiTicket;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by xu on 2017/7/10.
 */
public class TokenThread implements Runnable {
    public static String appId = Configs.APPID;

    public static String appSecret= Configs.APPSECRET;

   // public static AccessToken accessToken = null;

   // public static JsapiTicket jsapiTicket = null;
    public static String accessToken = null;

    public static String jsapiTicket = null;

  //  public final static String js_api_ticket_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";


    public void run() {
        while (true) {//這裏就應該是死循環
            SimpleDateFormat format = new SimpleDateFormat("mm");
            try {
                accessToken = this.getAccessToken();
                jsapiTicket = this.getJsapiTicket();
                if (null != accessToken) {
                    while(true){
                        Thread.sleep(60 * 1000);
                        if("04".equals(format.format(new Date()))){
                            break;
                        }
                    }

                } else {
                    Thread.sleep(1000 * 3); //获取的access_token为空 休眠3秒
                }
            } catch (Exception e) {
                e.printStackTrace();
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
  /*  private AccessToken getAccessToken(){
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

    *//**
     * 获取jsapi_ticket
     * @return
     *//*
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
    }*/
    //从进程中获取accessToken
    private String getAccessToken(){
        String url = "http://106.75.209.252:8686/access_token";
        String result = null;
        result = sendPost(url);
        return result;
    }
    //从进程中获取JsapiTicket
    private String getJsapiTicket(){
        String url = "http://106.75.209.252:8686/js_api_ticket";
        String result = null;
        result = sendPost(url);
        return result;
    }
    //发送http请求
    private String sendPost(String url) {
       PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            // 设置通用的请求属性
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            out = new PrintWriter(conn.getOutputStream());
            // 发送请求参数
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送 POST 请求出现异常！"+e);
            e.printStackTrace();
        }
        //使用finally块来关闭输出流、输入流
        finally{
            try{
                if(out!=null){
                    out.close();
                }
                if(in!=null){
                    in.close();
                }
            }
            catch(IOException ex){
                ex.printStackTrace();
            }
        }
        return result;
    }

}
