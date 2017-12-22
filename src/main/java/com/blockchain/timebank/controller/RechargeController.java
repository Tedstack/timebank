package com.blockchain.timebank.controller;

import com.alibaba.fastjson.JSONObject;
import com.blockchain.timebank.entity.RechargeEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.RechargeService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.wxpay.WxPay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/recharge")
public class RechargeController {


    @Autowired
    UserService userService;

    @Autowired
    RechargeService rechargeService;


    //通过后台唤起支付
    @RequestMapping(value = "/rechargeAddSubmit", method = RequestMethod.POST)
    public String rechargeAddSubmit(ModelMap map, @RequestParam Integer totalAmount) throws IOException {
        UserEntity userEntity = getCurrentUser();
        Integer amount = totalAmount * 100;
        String prePayXml = rechargeService.getUnifiedMessage(userEntity.getOpenId(), amount, userEntity.getId());
        map.addAttribute("prePayInfo", prePayXml);

        //写数据库
/*        RechargeEntity rechargeEntity = new RechargeEntity();
        rechargeEntity.setRechargeDate();

        rechargeService.saveRechargeEntity(rechargeEntity)*/
        return "recharge_add";
    }

    /**
     * 通过前台唤起支付,从前台获取用户充值金额，然后再传到前台页面
     * 通过前台post请求到统一下单地址：“https://api.mch.weixin.qq.com/pay/unifiedorder
     * @param map
     * @param totalAmount
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/rechargeAdd", method = RequestMethod.GET)
    public String rechargeAddPost(ModelMap map, @RequestParam Integer totalAmount) throws IOException {
        UserEntity userEntity = getCurrentUser();
        Integer amount = totalAmount * 100;
        Long userID = userEntity.getId();

        String prePayXml = rechargeService.getUifiedInfo(userEntity.getOpenId(), amount, userID);
        map.addAttribute("prePayInfo", prePayXml);


        //以下预填数据库中充值信息
        Date date = new Date();
        SimpleDateFormat temp=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String reDate=temp.format(date);

        String rechaegeStatus = "submit";
        String uuID = WxPay.generateUUID();
        RechargeEntity rechargeEntity = new RechargeEntity();
        rechargeEntity.setUserId(userID);
        rechargeEntity.setTotalAmount(totalAmount);
        rechargeEntity.setRechargeDate(reDate);
        rechargeEntity.setRechargeStatus(rechaegeStatus);
        rechargeEntity.setUuid(uuID);

        return "recharge_Add";
    }


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


    //申请充值时间币页面action
    @RequestMapping(value = "/coins_recharge_submit_pre", method = RequestMethod.POST)
    @ResponseBody
    public String getRechargeInfo(ModelMap map, @RequestParam Integer totalAmount) throws IOException {
        UserEntity userEntity = getCurrentUser();
        Integer amount = totalAmount * 100;
        Long userID = userEntity.getId();

        String prePayXml = rechargeService.getUifiedInfo(userEntity.getOpenId(), amount, userID);
        map.addAttribute("prePayInfo", prePayXml);  //prePayInfo传给前台与微信后台交互

        //以下预填数据库中充值信息
        Date date = new Date();
        SimpleDateFormat temp=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String reDate=temp.format(date);

        String rechaegeStatus = "submit";
        String uuID = WxPay.generateUUID();
        RechargeEntity rechargeEntity = new RechargeEntity();
        rechargeEntity.setUserId(userID);
        rechargeEntity.setTotalAmount(totalAmount);
        rechargeEntity.setRechargeDate(reDate);
        rechargeEntity.setRechargeStatus(rechaegeStatus);
        rechargeEntity.setUuid(uuID);

        return prePayXml;
    }






    //申请充值时间币页面action

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
    public String getRechargeSubmit(ModelMap map, @RequestParam Integer totalAmount) throws IOException {
        UserEntity userEntity = getCurrentUser();
        Integer amount = totalAmount * 100;
        String prePayXml = rechargeService.getUnifiedMessage(userEntity.getOpenId(), amount, userEntity.getId());

        //以下预填数据库中充值信息
        Date date = new Date();
        SimpleDateFormat temp=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String reDate=temp.format(date);
        String rechaegeStatus = "submit";
        String uuID = WxPay.generateUUID();
        RechargeEntity rechargeEntity = new RechargeEntity();
        rechargeEntity.setUserId(userEntity.getId());
        rechargeEntity.setTotalAmount(totalAmount);
        rechargeEntity.setRechargeDate(reDate);
        rechargeEntity.setRechargeStatus(rechaegeStatus);
        rechargeEntity.setUuid(uuID);

        Map payInfo = WxPay.getPayMap(prePayXml);
        JSONObject json = new JSONObject();
        Collection<String> keyset = payInfo.keySet();
        List list = new ArrayList<String>(keyset);
        for (int i = 0; i < list.size(); i++) {
            //System.out.println(list.get(i) + "=" + payInfo.get(list.get(i)));
            json.put((String) list.get(i),payInfo.get(list.get(i)));
        }
        String re = json.toJSONString();

        return re;
    }


}
