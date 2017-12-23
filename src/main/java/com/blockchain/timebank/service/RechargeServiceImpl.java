package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RechargeDao;
import com.blockchain.timebank.entity.RechargeEntity;
import com.blockchain.timebank.wxpay.ConfigUtil;
import com.blockchain.timebank.wxpay.MD5Util;
import com.blockchain.timebank.wxpay.WxPay;
import com.blockchain.timebank.wxpay.XMLUtil;
import org.jdom.JDOMException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.blockchain.timebank.wxpay.WxPay.getXmlPara;

@Service
public class RechargeServiceImpl implements RechargeService {

    @Autowired
    RechargeDao rechargeDao;

    public String getUnifiedMessage(String openId, Integer totalAmount, Long userId) throws IOException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date()).replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
        String out_trade_no = time + userId;
        String body = "TimeCoinRecharge";
        String ip = "192.168.1.1";      //当无法获取用户的ip时默认用此地址否则调用WxPay.
        String res = WxPay.unifiedOrder(body,out_trade_no,totalAmount,ip,openId);
        return res;
    }

    public RechargeEntity saveRechargeEntity(RechargeEntity rechargeEntity) {
        return rechargeDao.save(rechargeEntity);
    }


    /**
     * 前台JSAPI唤起支付，完成请求参数的组装
     * 如果通过后台java的请求无法唤起支付，则用此函数传递统一下单请求到前台，通过js唤起微信支付
     * @param openId
     * @param totalAmount
     * @param userId
     * @return
     * @throws IOException
     */
    public String getUifiedInfo(String openId, Integer totalAmount, Long userId) throws IOException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = df.format(new Date()).replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
        String out_trade_no = time + userId;
        String body = "TimeCoinRecharge";
        String ip = "192.168.1.1";      //当无法获取用户的ip时默认用此地址否则调用WxPay.



        String nonce_str = WxPay.getNonceStr().toUpperCase();//随机
        //组装请求参数,按照ASCII排序
        String sign = "appid=" + ConfigUtil.APPID +
                "&body=" + body +
                "&mch_id=" + ConfigUtil.MCH_ID +
                "&nonce_str=" + nonce_str +
                "&notify_url=" + ConfigUtil.NOTIFY_URL +
                "&openid=" + openId +
                "&out_trade_no=" + out_trade_no +
                "&spbill_create_ip=" + ip +
                "&total_fee=" + totalAmount.toString() +
                "&trade_type=" + ConfigUtil.TRADE_TYPE_JS +
                "&key=" + ConfigUtil.API_KEY;//这个字段是用于之后MD5加密的，字段要按照ascii码顺序排序
        sign = MD5Util.MD5Encode(sign,"").toUpperCase();

        //组装包含openid用于请求统一下单返回结果的XML
        StringBuilder sb = new StringBuilder("");
        sb.append("<xml>");
        WxPay.setXmlKV(sb,"appid",ConfigUtil.APPID);
        WxPay.setXmlKV(sb,"body",body);
        WxPay.setXmlKV(sb,"mch_id",ConfigUtil.MCH_ID);
        WxPay.setXmlKV(sb,"nonce_str",nonce_str);
        WxPay.setXmlKV(sb,"notify_url",ConfigUtil.NOTIFY_URL);
        WxPay.setXmlKV(sb,"openid",openId);
        WxPay.setXmlKV(sb,"out_trade_no",out_trade_no);
        WxPay.setXmlKV(sb,"spbill_create_ip",ip);
        WxPay.setXmlKV(sb,"total_fee",totalAmount.toString());
        WxPay.setXmlKV(sb,"trade_type",ConfigUtil.TRADE_TYPE_JS);
        WxPay.setXmlKV(sb,"sign",sign);
        sb.append("</xml>");
        String res = sb.toString();
        return res;
    }

    /**
     * 根据获取的回调XML，判断交易是否成功
     * @param notifyXml
     * @return
     * @throws JDOMException
     * @throws IOException
     */
    public String checkPayResult(String notifyXml) throws JDOMException, IOException {

        String wxsign = WxPay.getXmlPara(notifyXml, "sign");
        String result_code = WxPay.getXmlPara(notifyXml, "result_code");
        String return_code = WxPay.getXmlPara(notifyXml, "return_code");
        String resXml = "";

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
            resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>" + "<return_msg><![CDATA[FAIL]]></return_msg>" + "</xml> ";
        } else {
            System.out.println("支付成功");
            resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>" + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
        }

        return resXml;
    }
}
