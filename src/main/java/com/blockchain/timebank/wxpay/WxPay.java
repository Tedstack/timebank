package com.blockchain.timebank.wxpay;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.charset.Charset;
import java.util.*;
import java.util.logging.Logger;

/**
 * ֧��ʵ��
 */
public class WxPay {


    private static Logger logger = Logger.getLogger(WxPay.class.getName());

    /**
     * ͳһ�µ�
     * @param body
     * @param out_trade_no
     * @param total_fee
     * @param IP
     * @param //notify_url
     * @param openid
     * @return
     * @throws IOException
     */
    public static String unifiedOrder(String body,String out_trade_no,Integer total_fee,String IP,String openid) throws IOException {
        //���÷���·��
        HttpPost httppost = new HttpPost("https://api.mch.weixin.qq.com/pay/unifiedorder");

        String nonce_str = getNonceStr().toUpperCase();//���
        //��װ�������,����ASCII����
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
                "&key=" + ConfigUtil.API_KEY;//����ֶ�������֮��MD5���ܵģ��ֶ�Ҫ����ascii��˳������
        sign = MD5Util.MD5Encode(sign,"").toUpperCase();

        //��װ����openid��������ͳһ�µ����ؽ����XML
        StringBuilder sb = new StringBuilder("");
        sb.append("<xml>");
        setXmlKV(sb,"appid",ConfigUtil.APPID);
        setXmlKV(sb,"body",body);
        setXmlKV(sb,"mch_id",ConfigUtil.MCH_ID);
        setXmlKV(sb,"nonce_str",nonce_str);
        setXmlKV(sb,"notify_url",ConfigUtil.NOTIFY_URL);
        setXmlKV(sb,"openid",openid);
        setXmlKV(sb,"out_trade_no",out_trade_no);
        setXmlKV(sb,"spbill_create_ip",IP);
        setXmlKV(sb,"total_fee",total_fee.toString());
        setXmlKV(sb,"trade_type",ConfigUtil.TRADE_TYPE_JS);
        setXmlKV(sb,"sign",sign);
        sb.append("</xml>");
        System.out.println("ͳһ�µ�����" + sb);

        StringEntity reqEntity = new StringEntity(new String (sb.toString().getBytes("UTF-8"),"ISO8859-1"));//���������Ϊ�˷�ֹ�����ĵ�ʱ�����ǩ������
        httppost.setEntity(reqEntity);
        CloseableHttpClient httpclient = HttpClients.createDefault();
        CloseableHttpResponse response = httpclient.execute(httppost);
        String strResult = EntityUtils.toString(response.getEntity(), Charset.forName("utf-8"));
        System.out.println("ͳһ�µ�����xml��" + strResult);

        return strResult;
    }



    /**
     * ����ͳһ�µ�����Ԥ֧��������id��������Ϣ����ǩ����ƴװΪmap������΢��֧����
     * @param prePayInfoXml
     * @return
     */
    public static Map<String,Object> getPayMap(String prePayInfoXml){
        Map<String,Object> map = new HashMap<String,Object>();

        String prepay_id = getXmlPara(prePayInfoXml,"prepay_id");//ͳһ�µ�����xml��prepay_id
        String timeStamp = String.valueOf((System.currentTimeMillis()/1000));//1970�굽���ڵ�����
        String nonceStr = getNonceStr().toUpperCase();//��������ַ���
        String packageStr = "prepay_id=" + prepay_id;
        String signType = "MD5";
        String paySign =
                "appId=" + ConfigUtil.APPID +
                        "&nonceStr=" + nonceStr +
                        "&package=prepay_id=" + prepay_id +
                        "&signType=" + signType +
                        "&timeStamp=" + timeStamp +
                        "&key="+ ConfigUtil.API_KEY;//ע������Ĳ���Ҫ����ASCII�� ����
        paySign = MD5Util.MD5Encode(paySign,"").toUpperCase();//������MD5����

        map.put("appId",ConfigUtil.APPID);
        map.put("timeStamp",timeStamp);
        map.put("nonceStr",nonceStr);
        map.put("packageStr",packageStr);
        map.put("signType",signType);
        map.put("paySign",paySign);
        map.put("prepay_id",prepay_id);
        return map;
    }

    /**
     * ����XML �������Ϊpara�Ĳ���ֵ
     * @param xml
     * @param para
     * @return
     */
    public static String getXmlPara(String xml,String para){
        int start = xml.indexOf("<"+para+">");
        int end = xml.indexOf("</"+para+">");

        if(start < 0 && end < 0){
            return null;
        }
        return xml.substring(start + ("<"+para+">").length(),end).replace("<![CDATA[","").replace("]]>","");
    }

    /**
     * ��ȡip��ַ
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
     * �޸Ķ���״̬����ȡ΢�Żص����
     * @param request
     * @return
     */
    public static String getNotifyResult(HttpServletRequest request){
        String inputLine;
        String notifyXml = "";
        String resXml = "";
        try {
            while ((inputLine = request.getReader().readLine()) != null){
                notifyXml += inputLine;
            }
            request.getReader().close();
        } catch (Exception e) {
            logger.info("xml��ȡʧ�ܣ�" + e);
            e.printStackTrace();
        }
        System.out.println("���յ���xml��" + notifyXml);
        logger.info("�յ�΢���첽�ص���");
        logger.info(notifyXml);
        if(notifyXml.isEmpty()){
            logger.info("xmlΪ�գ�");
        }

        String appid = getXmlPara(notifyXml,"appid");;
        String bank_type = getXmlPara(notifyXml,"bank_type");
        String cash_fee = getXmlPara(notifyXml,"cash_fee");
        String fee_type = getXmlPara(notifyXml,"fee_type");
        String is_subscribe = getXmlPara(notifyXml,"is_subscribe");
        String mch_id = getXmlPara(notifyXml,"mch_id");
        String nonce_str = getXmlPara(notifyXml,"nonce_str");
        String openid = getXmlPara(notifyXml,"openid");
        String out_trade_no = getXmlPara(notifyXml,"out_trade_no");
        String result_code = getXmlPara(notifyXml,"result_code");
        String return_code = getXmlPara(notifyXml,"return_code");
        String sign = getXmlPara(notifyXml,"sign");
        String time_end = getXmlPara(notifyXml,"time_end");
        String total_fee = getXmlPara(notifyXml,"total_fee");
        String trade_type = getXmlPara(notifyXml,"trade_type");
        String transaction_id = getXmlPara(notifyXml,"transaction_id");

        //���ݷ���xml���㱾��ǩ��
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
                        "&key=" + ConfigUtil.API_KEY;//ע������Ĳ���Ҫ����ASCII�� ����
        localSign = MD5Util.MD5Encode(localSign,"").toUpperCase();//������MD5����

        System.out.println("����ǩ���ǣ�" + localSign);
        logger.info("����ǩ���ǣ�" + localSign);
        logger.info("΢��֧��ǩ���ǣ�" + sign);

        //���ؼ���ǩ����΢�ŷ���ǩ����ͬ||���ؽ��Ϊ���ɹ�
        if(!sign.equals(localSign) || !"SUCCESS".equals(result_code) || !"SUCCESS".equals(return_code)){
            System.out.println("��֤ǩ��ʧ�ܻ򷵻ش�������");
            logger.info("��֤ǩ��ʧ�ܻ򷵻ش�������");
            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>" + "<return_msg><![CDATA[FAIL]]></return_msg>" + "</xml> ";
        }else{
            System.out.println("֧���ɹ�");
            logger.info("���ں�֧���ɹ���out_trade_no(������)Ϊ��" + out_trade_no);
            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>" + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
        }
        return resXml;
    }




    /**
     * �� Map ����� appid��mch_id��nonce_str��sign_type��sign <br>
     * �ú����������̻�������ͳһ�µ��Ƚӿڣ��������ں��������ȯ�ӿ�
     *
     * @param reqData
     * @return
     * @throws Exception
     */
    public Map<String, String> fillRequestData(Map<String, String> reqData) throws Exception {
        reqData.put("appid",ConfigUtil.APPID );
        reqData.put("mch_id",ConfigUtil.MCH_ID);
        reqData.put("nonce_str", this.generateUUID());
        reqData.put("sign_type", "MD5");
        SortedMap<String,String> sortData= (SortedMap<String, String>) new HashMap<String,String>(reqData);
        reqData.put("sign", PayCommonUtil.createSign("UTF-8",sortData));
        return reqData;
    }

    public static String generateUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 32);
    }




    /**
     * ����XML��ǩ
     * @param sb
     * @param Key
     * @param value
     * @return
     */
    public static StringBuilder setXmlKV(StringBuilder sb,String Key,String value){
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
     * ��ȡ32λ����ַ���
     * @return
     */
    public static String getNonceStr(){
        String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        Random rd = new Random();
        for(int i = 0 ; i < 32 ; i ++ ){
            sb.append(str.charAt(rd.nextInt(str.length())));
        }
        return sb.toString();
    }
}
