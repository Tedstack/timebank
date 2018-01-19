package com.blockchain.timebank.wxpay;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.Charset;
import java.util.*;
import java.util.logging.Logger;

/**
 * 支付实现
 */
public class WxPay {


    private static Logger logger = Logger.getLogger(WxPay.class.getName());

    /**
     * 统一下单
     * 如果无法获取用户IP，则使用   192.168.1.1
     *
     * @param body
     * @param out_trade_no
     * @param total_fee
     * @param IP
     * @param //notify_url
     * @param openid
     * @return
     * @throws IOException
     */
    public static String unifiedOrderInfo(String body, String out_trade_no, Integer total_fee, String IP, String openid) throws IOException {

        String nonce_str = getNonceStr().toUpperCase();//随机
        //组装请求参数,按照ASCII排序
        String sign = "appid=" + ConfigUtil.APPID +
                "&body=" + body +
                "&mch_id=" + ConfigUtil.MCH_ID +
                "&nonce_str=" + nonce_str +
                "&notify_url=" + ConfigUtil.NOTIFY_URL +
                "&openid=" + openid +
                "&out_trade_no=" + out_trade_no +
                "&spbill_create_ip=" + IP +
                "&total_fee=" + total_fee.toString() +
                "&trade_type=" + ConfigUtil.TRADE_TYPE_JS +
                "&key=" + ConfigUtil.API_KEY;//这个字段是用于之后MD5加密的，字段要按照ascii码顺序排序
        sign = MD5Util.MD5Encode(sign, "").toUpperCase();

        //组装包含openid用于请求统一下单返回结果的XML
        StringBuilder sb = new StringBuilder("");
        sb.append("<xml>");
        setXmlKV(sb, "appid", ConfigUtil.APPID);
        setXmlKV(sb, "body", body);
        setXmlKV(sb, "mch_id", ConfigUtil.MCH_ID);
        setXmlKV(sb, "nonce_str", nonce_str);
        setXmlKV(sb, "notify_url", ConfigUtil.NOTIFY_URL);
        setXmlKV(sb, "openid", openid);
        setXmlKV(sb, "out_trade_no", out_trade_no);
        setXmlKV(sb, "spbill_create_ip", IP);
        setXmlKV(sb, "total_fee", total_fee.toString());
        setXmlKV(sb, "trade_type", ConfigUtil.TRADE_TYPE_JS);
        setXmlKV(sb, "sign", sign);
        sb.append("</xml>");
        System.out.println("统一下单请求----test1----：" + sb);


        return new String(sb.toString().getBytes("utf-8"));
    }


    public static String unifiedOrder(String body, String out_trade_no, double total_fee, String IP, String openid) throws IOException {
        //设置访问路径
        HttpPost httppost = new HttpPost("https://api.mch.weixin.qq.com/pay/unifiedorder");

        String nonce_str = getNonceStr().toUpperCase();//随机
        //将用户输入的金额转化为分
        String amount = changeY2F(total_fee);
        //组装请求参数,按照ASCII排序
        String sign = "appid=" + ConfigUtil.APPID +
                "&body=" + body +
                "&mch_id=" + ConfigUtil.MCH_ID +
                "&nonce_str=" + nonce_str +
                "&notify_url=" + ConfigUtil.NOTIFY_URL +
                "&openid=" + openid +
                "&out_trade_no=" + out_trade_no +
                "&spbill_create_ip=" + IP +
                "&total_fee=" + amount +
                "&trade_type=" + ConfigUtil.TRADE_TYPE_JS +
                "&key=" + ConfigUtil.API_KEY;//这个字段是用于之后MD5加密的，字段要按照ascii码顺序排序
        sign = MD5Util.MD5Encode(sign, "").toUpperCase();

        //组装包含openid用于请求统一下单返回结果的XML
        StringBuilder sb = new StringBuilder("");
        sb.append("<xml>");
        setXmlKV(sb, "appid", ConfigUtil.APPID);
        setXmlKV(sb, "body", body);
        setXmlKV(sb, "mch_id", ConfigUtil.MCH_ID);
        setXmlKV(sb, "nonce_str", nonce_str);
        setXmlKV(sb, "notify_url", ConfigUtil.NOTIFY_URL);
        setXmlKV(sb, "openid", openid);
        setXmlKV(sb, "out_trade_no", out_trade_no);
        setXmlKV(sb, "spbill_create_ip", IP);
        setXmlKV(sb, "total_fee", amount);
        setXmlKV(sb, "trade_type", ConfigUtil.TRADE_TYPE_JS);
        setXmlKV(sb, "sign", sign);
        sb.append("</xml>");
        System.out.println("-----------------统一下单请求--------------：" + sb);

        StringEntity reqEntity = new StringEntity(new String(sb.toString().getBytes("UTF-8"), "ISO8859-1"));//这个处理是为了防止传中文的时候出现签名错误
        httppost.setEntity(reqEntity);
        CloseableHttpClient httpclient = HttpClients.createDefault();
        CloseableHttpResponse response = httpclient.execute(httppost);
        String strResult = EntityUtils.toString(response.getEntity(), Charset.forName("utf-8"));
        System.out.println("统一下单返回xml：" + strResult);

        return strResult;
    }


    /**
     * 根据统一下单返回预支付订单的id和其他信息生成签名并拼装为map（调用微信支付）
     *
     * @param prePayInfoXml
     * @return
     */
    public static Map<String, Object> getPayMap(String prePayInfoXml) {
        Map<String, Object> map = new HashMap<String, Object>();

        Date beijingDate = Calendar.getInstance(Locale.CHINA).getTime();  //确保获取正确的北京时间


        String prepay_id = getXmlPara(prePayInfoXml, "prepay_id");//统一下单返回xml中prepay_id
        //String timeStamp = String.valueOf((System.currentTimeMillis()/1000));//1970年到现在的秒数


        String timeStamp = String.valueOf(beijingDate.getTime() / 1000);   //确保获取正确的北京时间


        String nonceStr = getNonceStr().toUpperCase();//随机数据字符串
        String packageStr = "prepay_id=" + prepay_id;
        String signType = "MD5";
        String paySign =
                "appId=" + ConfigUtil.APPID +
                        "&nonceStr=" + nonceStr +
                        "&package=prepay_id=" + prepay_id +
                        "&signType=" + signType +
                        "&timeStamp=" + timeStamp +
                        "&key=" + ConfigUtil.API_KEY;//注意这里key之前的参数要根据ASCII码 排序
        paySign = MD5Util.MD5Encode(paySign, "").toUpperCase();//将数据MD5加密

        map.put("appId", ConfigUtil.APPID);
        map.put("timeStamp", timeStamp);
        map.put("nonceStr", nonceStr);
        map.put("packageStr", packageStr);
        map.put("signType", signType);
        map.put("paySign", paySign);
        map.put("prepay_id", prepay_id);
        return map;
    }

    /**
     * 解析XML 获得名称为para的参数值
     *
     * @param xml
     * @param para
     * @return
     */
    public static String getXmlPara(String xml, String para) {
        int start = xml.indexOf("<" + para + ">");
        int end = xml.indexOf("</" + para + ">");

        if (start < 0 && end < 0) {
            return null;
        }
        return xml.substring(start + ("<" + para + ">").length(), end).replace("<![CDATA[", "").replace("]]>", "");
    }

    /**
     * 获取ip地址
     *
     * @param request
     * @return
     */
    public static String getIpAddr(HttpServletRequest request) {
        InetAddress addr = null;
        try {
            addr = InetAddress.getLocalHost();
        } catch (UnknownHostException e) {
            return request.getRemoteAddr();
        }
        byte[] ipAddr = addr.getAddress();
        String ipAddrStr = "";
        for (int i = 0; i < ipAddr.length; i++) {
            if (i > 0) {
                ipAddrStr += ".";
            }
            ipAddrStr += ipAddr[i] & 0xFF;
        }
        return ipAddrStr;
    }


    /**
     * 修改订单状态，获取微信回调结果
     *
     * @param request
     * @return
     */
    public static String getNotifyResult(HttpServletRequest request) {
        String inputLine;
        String notifyXml = "";
        String resXml = "";
        try {
            while ((inputLine = request.getReader().readLine()) != null) {
                notifyXml += inputLine;
            }
            request.getReader().close();
        } catch (Exception e) {
            logger.info("xml获取失败：" + e);
            e.printStackTrace();
        }
        System.out.println("接收到的xml：" + notifyXml);
        logger.info("收到微信异步回调：");
        logger.info(notifyXml);


        if (notifyXml.equals(null)) {
            logger.info("xml为空：");
        }


        String appid = getXmlPara(notifyXml, "appid");
        ;
        String bank_type = getXmlPara(notifyXml, "bank_type");
        String cash_fee = getXmlPara(notifyXml, "cash_fee");
        String fee_type = getXmlPara(notifyXml, "fee_type");
        String is_subscribe = getXmlPara(notifyXml, "is_subscribe");
        String mch_id = getXmlPara(notifyXml, "mch_id");
        String nonce_str = getXmlPara(notifyXml, "nonce_str");
        String openid = getXmlPara(notifyXml, "openid");
        String out_trade_no = getXmlPara(notifyXml, "out_trade_no");
        String result_code = getXmlPara(notifyXml, "result_code");
        String return_code = getXmlPara(notifyXml, "return_code");
        String sign = getXmlPara(notifyXml, "sign");
        String time_end = getXmlPara(notifyXml, "time_end");
        String total_fee = getXmlPara(notifyXml, "total_fee");
        String trade_type = getXmlPara(notifyXml, "trade_type");
        String transaction_id = getXmlPara(notifyXml, "transaction_id");

        //根据返回xml计算本地签名
        String localSign =
                "appid=" + appid +
                        "&bank_type=" + bank_type +
                        "&cash_fee=" + cash_fee +
                        "&fee_type=" + fee_type +
                        "&is_subscribe=" + is_subscribe +
                        "&mch_id=" + mch_id +
                        "&nonce_str=" + nonce_str +
                        "&openid=" + openid +
                        "&out_trade_no=" + out_trade_no +
                        "&result_code=" + result_code +
                        "&return_code=" + return_code +
                        "&time_end=" + time_end +
                        "&total_fee=" + total_fee +
                        "&trade_type=" + trade_type +
                        "&transaction_id=" + transaction_id +
                        "&key=" + ConfigUtil.API_KEY;//注意这里的参数要根据ASCII码 排序
        localSign = MD5Util.MD5Encode(localSign, "").toUpperCase();//将数据MD5加密

        System.out.println("本地签名是：" + localSign);
        System.out.println("微信签名是：" + sign);
        logger.info("本地签名是：" + localSign);
        logger.info("微信支付签名是：" + sign);

        //本地计算签名与微信返回签名不同||返回结果为不成功
        if (!sign.equals(localSign) || !"SUCCESS".equals(result_code) || !"SUCCESS".equals(return_code)) {
            System.out.println("验证签名失败或返回错误结果码");
            logger.info("验证签名失败或返回错误结果码");
            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>" + "<return_msg><![CDATA[FAIL]]></return_msg>" + "</xml> ";
        } else {
            System.out.println("支付成功");
            logger.info("公众号支付成功，out_trade_no(订单号)为：" + out_trade_no);
            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>" + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
        }
        return resXml;
    }


    /**
     * 向 Map 中添加 appid、mch_id、nonce_str、sign_type、sign <br>
     * 该函数适用于商户适用于统一下单等接口，不适用于红包、代金券接口
     *
     * @param reqData
     * @return
     * @throws Exception
     */
    public Map<String, String> fillRequestData(Map<String, String> reqData) throws Exception {
        reqData.put("appid", ConfigUtil.APPID);
        reqData.put("mch_id", ConfigUtil.MCH_ID);
        reqData.put("nonce_str", this.generateUUID());
        reqData.put("sign_type", "MD5");
        SortedMap<String, String> sortData = (SortedMap<String, String>) new HashMap<String, String>(reqData);
        reqData.put("sign", PayCommonUtil.createSign("UTF-8", sortData));
        return reqData;
    }

    public static String generateUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 32);
    }


    /**
     * 插入XML标签
     *
     * @param sb
     * @param Key
     * @param value
     * @return
     */
    public static StringBuilder setXmlKV(StringBuilder sb, String Key, String value) {
        sb.append("<");
        sb.append(Key);
        sb.append(">");

        sb.append(value);

        sb.append("</");
        sb.append(Key);
        sb.append(">");

        return sb;
    }

    /**
     * 获取32位随机字符串
     *
     * @return
     */
    public static String getNonceStr() {
        String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random rd = new Random();
        for (int i = 0; i < 32; i++) {
            sb.append(str.charAt(rd.nextInt(str.length())));
        }
        return sb.toString();
    }


    /**
     * 获取微信回调结果
     *
     * @param request
     * @return
     */
    public static String getPayResult(HttpServletRequest request) {
        String inputLine;
        String notifyXml = "";
        try {
            while ((inputLine = request.getReader().readLine()) != null) {
                notifyXml += inputLine;
            }
            request.getReader().close();
        } catch (Exception e) {
            logger.info("回调xml获取失败：" + e);
            e.printStackTrace();
        }
        System.out.println("接收到的xml：" + notifyXml);
        logger.info("收到微信异步回调：");
        logger.info(notifyXml);


        if (notifyXml.equals(null)) {
            logger.info("回调xml为空：");
        }
        return notifyXml;
    }




    //convertStreamToString
    public static String convertStreamToString(InputStream is) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();

        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return sb.toString();
    }

    /*
    * 将用户输入的金额转换为分
    * @ return total_fee
    * */
    private  static String changeY2F(double total_fee) {
        String amount = Double.toString(total_fee);
        String currency = amount.replaceAll("\\$|\\￥|\\,", ""); // 处理包含, ￥
        // 或者$的金额
        int index = currency.indexOf(".");
        int length = currency.length();
        Long amLong = 0l;
        if (index == -1) {
            amLong = Long.valueOf(currency + "00");
        } else if (length - index >= 3) {
            amLong = Long.valueOf((currency.substring(0, index + 3)).replace(".", ""));
        } else if (length - index == 2) {
            amLong = Long.valueOf((currency.substring(0, index + 2)).replace(".", "") + 0);
        } else {
            amLong = Long.valueOf((currency.substring(0, index + 1)).replace(".", "") + "00");
        }
        return amLong.toString();
    }

}
