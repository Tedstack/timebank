package com.blockchain.timebank.controller;

import com.alibaba.fastjson.JSONObject;
import com.blockchain.timebank.dao.RechargeDao;
import com.blockchain.timebank.entity.RechargeEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.AccountService;
import com.blockchain.timebank.service.RechargeService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.weixin.util.SignUtil;
import com.blockchain.timebank.weixin.util.TemplateUtil;
import com.blockchain.timebank.wxpay.ConfigUtil;
import com.blockchain.timebank.wxpay.WxPay;
import com.blockchain.timebank.wxpay.XMLUtil;
import org.apache.commons.logging.Log;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.jdom.JDOMException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("/recharge")
public class RechargeController {


    @Autowired
    UserService userService;

    @Autowired
    RechargeService rechargeService;

    @Autowired
    RechargeDao rechargeDao;

    @Autowired
    AccountService accountService;
    String uuid;

    private UserEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserEntity userEntity = userService.findUserEntityByPhone(userDetails.getUsername());
            return userEntity;
        } else {
            return null;
        }
    }


    //申请查看时间币余额页面   无需修改
    @RequestMapping(value = "/coins_balance", method = RequestMethod.GET)
    public String getCoinBalance(ModelMap map) {
        UserEntity user = getCurrentUser();
        map.addAttribute("TimeCoin", user.getTimeCoin());
        return "coins_balance";
    }


    //时间币充值页面

    @RequestMapping(value = "/coins_recharge", method = RequestMethod.GET)
    public String getRechargePage(ModelMap map) {
        return "coins_recharge";
    }


    /**
     * 获取充值金额，并组装好统一下单的XML，然后post到微信的统一下单地址;
     * 根据统一下单的结果，获取唤起支付所需的参数并组装成Json数据返回给前台。
     *
     * @param map
     * @param totalAmount
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/coins_recharge_submit", method = RequestMethod.POST)
    @ResponseBody
    public String getRechargeSubmit(ModelMap map, HttpServletRequest request, @RequestParam Double totalAmount) throws IOException {
        UserEntity userEntity = getCurrentUser();
        Double amount = totalAmount * 100 / ConfigUtil.RMB_TO_TIMECOIN;

        //以下预填数据库中充值信息
        Date date = new Date();
        SimpleDateFormat temp = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String reDate = temp.format(date);
        RechargeEntity rechargeEntity = new RechargeEntity();
        rechargeEntity.setUserId(userEntity.getId());
        rechargeEntity.setTotalAmount(totalAmount);
        rechargeEntity.setRechargeDate(reDate);
        //rechargeEntity.setRechargeStatus("submit");
        //rechargeEntity.setExtra("no");

        RechargeEntity rechargeEntity2 = rechargeService.saveRechargeEntity(rechargeEntity);
        rechargeEntity2.setUuid(rechargeEntity2.getId() + "-" + new SimpleDateFormat("yyyyMMddhhmmss").format(date));
        rechargeService.saveRechargeEntity(rechargeEntity);

        String prePayXml = rechargeService.getUnifiedMessage(userEntity.getOpenId(), amount, rechargeEntity.getUuid(), request);

        Map mp1 = WxPay.getPayMap(prePayXml);


        Map payInfo = WxPay.getPayMap(prePayXml);
        JSONObject json = new JSONObject();
        Collection<String> keyset = payInfo.keySet();
        List list = new ArrayList<String>(keyset);
        for (int i = 0; i < list.size(); i++) {
            //System.out.println(list.get(i) + "=" + payInfo.get(list.get(i)));
            json.put((String) list.get(i), payInfo.get(list.get(i)));
        }
        //String re = json.toJSONString();

        return json.toString();
    }


    //充值结果校验
    @RequestMapping(value = "/weixin_notify", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String getWeixinNotify(ModelMap map, HttpServletRequest request) {
        TreeMap<String, String> resMap = new TreeMap<String, String>();
        String retXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>" + "<return_msg><![CDATA[FAIL]]></return_msg>" + "</xml>";
        System.out.println(retXml);
        try {
            InputStream inputStream = request.getInputStream();
            String resXml = WxPay.convertStreamToString(inputStream);
            System.out.println("微信回调信息notify info----------------------" + resXml);
            String payStatus = rechargeService.checkPayResult(resXml);
            uuid = WxPay.getXmlPara(resXml, "out_trade_no");
            System.out.println("找记录的UUID是： " + uuid);

            RechargeEntity recharge = rechargeService.findByUuid(uuid);
            if (payStatus.equals("ok")) {
               // recharge.setRechargeStatus("success");
                retXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>" + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml>";







                /**
                 * 这里是充值成功后的事务处理：给用户增加时间币
                 * 此处最好修改成事务处理模式
                 *
                 */
               /* if (recharge.getExtra().equals("no")) {
                    UserEntity curUser = userService.findUserEntityById(recharge.getUserId());
                    Double amount = recharge.getTotalAmount();
                    Double coins = curUser.getTimeCoin();
                    coins = coins + amount;
                    curUser.setTimeCoin(coins);
                    recharge.setExtra("yes");
                    userService.saveUserEntity(curUser);
                }
*/
               //更新充值记录表和用户时间币字段
               accountService.updateRechargeTimeCoin(uuid,payStatus);







            } else {
                recharge.setRechargeStatus("failed");
            }
            rechargeService.saveRechargeEntity(recharge);


        } catch (IOException e) {
            e.printStackTrace();
        } catch (JDOMException e) {
            e.printStackTrace();
        }
        System.out.println("发给微信的信息：--------------------" + retXml);
        return retXml;
    }

    //发送模板消息通知
    @RequestMapping(value = "/send_template", method = RequestMethod.GET)
    public String send_template(ModelMap map){
        RechargeEntity recharge = rechargeService.findByUuid(uuid);
        UserEntity user = getCurrentUser();
        if("success".equals(recharge.getRechargeStatus())){
            boolean result = TemplateUtil.testTemplate(user,recharge);
            if(result)
                System.out.println("模板发送成功");
        }
        map.addAttribute("TimeCoin",user.getTimeCoin());
        return "coins_balance";
    }


}
