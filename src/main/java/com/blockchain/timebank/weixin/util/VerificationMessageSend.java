package com.blockchain.timebank.weixin.util;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.codec.binary.Base64;
import net.sf.json.JSONObject;
public class VerificationMessageSend {
    public static String EncodeByMD5(String str){
        return DigestUtils.md5Hex(str).toUpperCase();
    }
    public static String EncodeBase64(String str){
        return Base64.encodeBase64String(str.getBytes());
    }
    public  String sendPost(String Phone,String Param,String templateId) {
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");//设置日期格式  
        String date = df.format(new Date());
        String sig="f6c0072b1f57556749e19726b06c8cf4"+"ba97406df0b2137424f3230d973f96a1"+date;//Sid+token+date
        sig=VerificationMessageSend.EncodeByMD5(sig);
        String url="https://api.ucpaas.com/2014-06-30/Accounts/f6c0072b1f57556749e19726b06c8cf4/Messages/templateSMS?sig="+sig;
        System.out.println(url);
        String Auth="f6c0072b1f57556749e19726b06c8cf4"+":"+date;
        Auth=VerificationMessageSend.EncodeBase64(Auth);
        JSONObject temp= new JSONObject();
        temp.put("appId","db368dd1c22342d1941098db89ee7831");
        temp.put("param",Param);
        temp.put("templateId",templateId);
        temp.put("to",Phone);
        JSONObject requestBody=new JSONObject();
        requestBody.element("templateSMS",temp);
        System.out.println(requestBody);
        PrintWriter out=null;
        BufferedReader in=null;
        String result="";
        try{
            URL postUrl=new URL(url);
            URLConnection conn=postUrl.openConnection();
            conn.setRequestProperty("Host", "api.ucpaas.com");
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Content-Type", "application/json;charset=utf-8");
            conn.setRequestProperty("Authorization", Auth);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            out = new PrintWriter(conn.getOutputStream());
            out.print(requestBody);
            out.flush();
            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while((line = in.readLine())!=null)
                result += line;
        }catch(Exception e)
        {
            System.out.println("Post error "+e);
            e.printStackTrace();
        }
        finally{
            try{
                if(out!=null)
                    out.close();
                if(in!=null)
                    in.close();
            }catch(IOException e)
            {
                e.printStackTrace();
            }
        }
        return result;
    }
}
