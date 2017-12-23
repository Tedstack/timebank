package com.blockchain.timebank.wxpay;

import com.alibaba.fastjson.JSONObject;
import org.jdom.JDOMException;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by yang on 17-12-15.
 */
public class a_test {
    public static void main(String args[]) throws JDOMException, IOException, ParseException {
/*        String str1 = "<xml>\n" +
                "   <appid>wx2421b1c4370ec43b</appid>\n" +
                "   <attach>支付测试</attach>\n" +
                "   <body>JSAPI支付测试</body>\n" +
                "   <mch_id>10000100</mch_id>\n" +
                "   <detail><![CDATA[{ \"goods_detail\":[ { \"goods_id\":\"iphone6s_16G\", \"wxpay_goods_id\":\"1001\", \"goods_name\":\"iPhone6s 16G\", \"quantity\":1, \"price\":528800, \"goods_category\":\"123456\", \"body\":\"苹果手机\" }, { \"goods_id\":\"iphone6s_32G\", \"wxpay_goods_id\":\"1002\", \"goods_name\":\"iPhone6s 32G\", \"quantity\":1, \"price\":608800, \"goods_category\":\"123789\", \"body\":\"苹果手机\" } ] }]]></detail>\n" +
                "   <nonce_str>1add1a30ac87aa2db72f57a2375d8fec</nonce_str>\n" +
                "   <notify_url>http://wxpay.wxutil.com/pub_v2/pay/notify.v2.php</notify_url>\n" +
                "   <openid>oUpF8uMuAJO_M2pxb1Q9zNjWeS6o</openid>\n" +
                "   <out_trade_no>1415659990</out_trade_no>\n" +
                "   <spbill_create_ip>14.23.150.211</spbill_create_ip>\n" +
                "   <total_fee>1</total_fee>\n" +
                "   <trade_type>JSAPI</trade_type>\n" +
                "   <sign>0CB01533B8C1EF103065174F50BCA001</sign>\n" +
                "</xml>";

        Map map = WxPay.getPayMap(str1);

        Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, String> entry = it.next();
            System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
        }*/

//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String time = df.format(new Date()).replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
//        System.out.println(time);


        String returncode = "<xml>\n" +
                "   <return_code><![CDATA[SUCCESS]]></return_code>\n" +
                "   <return_msg><![CDATA[OK]]></return_msg>\n" +
                "   <appid><![CDATA[wx2421b1c4370ec43b]]></appid>\n" +
                "   <mch_id><![CDATA[10000100]]></mch_id>\n" +
                "   <nonce_str><![CDATA[IITRi8Iabbblz1Jc]]></nonce_str>\n" +
                "   <openid><![CDATA[oUpF8uMuAJO_M2pxb1Q9zNjWeS6o]]></openid>\n" +
                "   <sign><![CDATA[7921E432F65EB8ED0CE9755F0E86D72F]]></sign>\n" +
                "   <result_code><![CDATA[SUCCESS]]></result_code>\n" +
                "   <prepay_id><![CDATA[wx201411101639507cbf6ffd8b0779950874]]></prepay_id>\n" +
                "   <trade_type><![CDATA[JSAPI]]></trade_type>\n" +
                "</xml>";
//
//        Map map = WxPay.getPayMap(returncode);
//        Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
//        while (it.hasNext()) {
//            Map.Entry<String, String> entry = it.next();
//            System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
//        }

        //System.out.println(WxPay.getNonceStr().toUpperCase());
//        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String time = df.format(new Date()).replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
//        String out_trade_no ="1001" + "_" + time ;
//        System.out.println(out_trade_no);




/*        String miyao1 = MD5Util.MD5Encode("yuefukejiandECNU","");
        String miyao2 = MD5Util.MD5Encode("yuefukejiandECNU","");

        System.out.println(miyao1);
        System.out.println(miyao2);*/

/*        String miyao1 = MD5Util.MD5Encode("ae395a815ae2e7a9406cb29e3929e918","");
        String miyao2 = MD5Util.MD5Encode("yuefukejiandECNU","");

        System.out.println(miyao1);
        System.out.println(miyao2);*/

        String str0 = WxPay.unifiedOrderInfo("coinpay", "2017-12-21-1843", 200, "192.168.1.1", "asdasddqw1231cd");

        String str1 = "<xml>\n" +
                "   <appid>wx2421b1c4370ec43b</appid>\n" +
                "   <attach>支付测试</attach>\n" +
                "   <body>JSAPI支付测试</body>\n" +
                "   <mch_id>10000100</mch_id>\n" +
                "   <detail><![CDATA[{ \"goods_detail\":[ { \"goods_id\":\"iphone6s_16G\", \"wxpay_goods_id\":\"1001\", \"goods_name\":\"iPhone6s 16G\", \"quantity\":1, \"price\":528800, \"goods_category\":\"123456\", \"body\":\"苹果手机\" }, { \"goods_id\":\"iphone6s_32G\", \"wxpay_goods_id\":\"1002\", \"goods_name\":\"iPhone6s 32G\", \"quantity\":1, \"price\":608800, \"goods_category\":\"123789\", \"body\":\"苹果手机\" } ] }]]></detail>\n" +
                "   <nonce_str>1add1a30ac87aa2db72f57a2375d8fec</nonce_str>\n" +
                "   <notify_url>http://wxpay.wxutil.com/pub_v2/pay/notify.v2.php</notify_url>\n" +
                "   <openid>oUpF8uMuAJO_M2pxb1Q9zNjWeS6o</openid>\n" +
                "   <out_trade_no>1415659990</out_trade_no>\n" +
                "   <spbill_create_ip>14.23.150.211</spbill_create_ip>\n" +
                "   <total_fee>1</total_fee>\n" +
                "   <trade_type>JSAPI</trade_type>\n" +
                "   <sign>0CB01533B8C1EF103065174F50BCA001</sign>\n" +
                "</xml>";


//        Map map = XMLUtil.doXMLParse(str0);
//        System.out.println(map.get("appid2"));
//        Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
//        while (it.hasNext()) {
//            Map.Entry<String, String> entry = it.next();
//            System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
//        }

/*        //签名验证
        Map remap = XMLUtil.doXMLParse(returncode);
        remap.remove("sign");
        Collection<String> keyset = remap.keySet();
        List list = new ArrayList<String>(keyset);
        Collections.sort(list);
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i) + "=" + remap.get(list.get(i)));
        }

        String signs = (String) list.get(0) + "=" + remap.get(list.get(0));
        for (int i = 1; i < list.size(); i++) {
            signs = signs + "&" + list.get(i) + "=" + remap.get(list.get(i));
        }
        signs = signs + "&key=" + ConfigUtil.API_KEY;
        System.out.println("签名参数： " + signs);
        String sign = MD5Util.MD5Encode(signs,"").toUpperCase();
        System.out.println("签名是： " + sign);*/

//        Date date=new Date();
//        SimpleDateFormat temp=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//        String date1=temp.format(date);
//        Date date2=temp.parse(date1);
//        System.out.println("Date:" + date + "\n " + "format:" + date1 + "\n" + "date2:" + date2);

/*        String prePayXml = "<xml>\n" +
                "   <return_code><![CDATA[SUCCESS]]></return_code>\n" +
                "   <return_msg><![CDATA[OK]]></return_msg>\n" +
                "   <appid><![CDATA[wx2421b1c4370ec43b]]></appid>\n" +
                "   <mch_id><![CDATA[10000100]]></mch_id>\n" +
                "   <nonce_str><![CDATA[IITRi8Iabbblz1Jc]]></nonce_str>\n" +
                "   <openid><![CDATA[oUpF8uMuAJO_M2pxb1Q9zNjWeS6o]]></openid>\n" +
                "   <sign><![CDATA[7921E432F65EB8ED0CE9755F0E86D72F]]></sign>\n" +
                "   <result_code><![CDATA[SUCCESS]]></result_code>\n" +
                "   <prepay_id><![CDATA[wx201411101639507cbf6ffd8b0779950874]]></prepay_id>\n" +
                "   <trade_type><![CDATA[JSAPI]]></trade_type>\n" +
                "</xml>";

        Map payInfo = WxPay.getPayMap(prePayXml);
        JSONObject json = new JSONObject();
        Collection<String> keyset = payInfo.keySet();
        List list = new ArrayList<String>(keyset);
        for (int i = 0; i < list.size(); i++) {
            System.out.println(list.get(i) + "=" + payInfo.get(list.get(i)));
            json.put((String) list.get(i),payInfo.get(list.get(i)));
        }
        String res = json.toJSONString();
        System.out.println(res);*/


        String notifyXml = "<xml>\n" +
                "  <appid><![CDATA[wx2421b1c4370ec43b]]></appid>\n" +
                "  <attach><![CDATA[支付测试]]></attach>\n" +
                "  <bank_type><![CDATA[CFT]]></bank_type>\n" +
                "  <fee_type><![CDATA[CNY]]></fee_type>\n" +
                "  <is_subscribe><![CDATA[Y]]></is_subscribe>\n" +
                "  <mch_id><![CDATA[10000100]]></mch_id>\n" +
                "  <nonce_str><![CDATA[5d2b6c2a8db53831f7eda20af46e531c]]></nonce_str>\n" +
                "  <openid><![CDATA[oUpF8uMEb4qRXf22hE3X68TekukE]]></openid>\n" +
                "  <out_trade_no><![CDATA[1409811653]]></out_trade_no>\n" +
                "  <result_code><![CDATA[SUCCESS]]></result_code>\n" +
                "  <return_code><![CDATA[SUCCESS]]></return_code>\n" +
                "  <sign><![CDATA[B552ED6B279343CB493C5DD0D78AB241]]></sign>\n" +
                "  <sub_mch_id><![CDATA[10000100]]></sub_mch_id>\n" +
                "  <time_end><![CDATA[20140903131540]]></time_end>\n" +
                "  <total_fee>1</total_fee>\n" +
                "<coupon_fee><![CDATA[10]]></coupon_fee>\n" +
                "<coupon_count><![CDATA[1]]></coupon_count>\n" +
                "<coupon_type><![CDATA[CASH]]></coupon_type>\n" +
                "<coupon_id><![CDATA[10000]]></coupon_id>\n" +
                "<coupon_fee><![CDATA[100]]></coupon_fee>\n" +
                "  <trade_type><![CDATA[JSAPI]]></trade_type>\n" +
                "  <transaction_id><![CDATA[1004400740201409030005092168]]></transaction_id>\n" +
                "</xml>";
        System.out.println(checkPayResult(notifyXml));

    }



    public static String checkPayResult(String notifyXml) throws JDOMException, IOException {

        String wxsign = WxPay.getXmlPara(notifyXml, "sign");
        System.out.println("weixin签名  " + wxsign);
        String result_code = WxPay.getXmlPara(notifyXml, "result_code");
        String return_code = WxPay.getXmlPara(notifyXml, "return_code");
        //String resXml = "";
        String payStatus = "fail";
        //根据回调结果计算本地签名
        Map remap = XMLUtil.doXMLParse(notifyXml);
        remap.remove("sign");
        Collection<String> keyset = remap.keySet();
        List list = new ArrayList<String>(keyset);
        Collections.sort(list);
//        for (int i = 0; i < list.size(); i++) {
//            System.out.println(list.get(i) + "=" + remap.get(list.get(i)));
//        }
        String signs = list.get(0) + "=" + remap.get(list.get(0));
        for (int i = 1; i < list.size(); i++) {
            signs = signs + "&" + list.get(i) + "=" + remap.get(list.get(i));
        }
        signs = signs + "&key=" + ConfigUtil.API_KEY;
        System.out.println("回调签名参数： " + signs);
        String sign = MD5Util.MD5Encode(signs,"").toUpperCase();
        System.out.println("回调结果本地签名是： " + sign);


        //本地计算签名与微信返回签名不同||返回结果为不成功
        //本地计算签名与微信返回签名相同||返回结果为成功
        if (!sign.equals(wxsign) || !"SUCCESS".equals(result_code) || !"SUCCESS".equals(return_code)) {
            System.out.println("验证签名失败或返回错误结果码");
            //resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>" + "<return_msg><![CDATA[FAIL]]></return_msg>" + "</xml> ";
        } else {
            payStatus = "ok";
            System.out.println("支付成功");
            //resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>" + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
        }

        return payStatus;
    }


}
