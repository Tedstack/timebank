package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RechargeDao;
import com.blockchain.timebank.entity.RechargeEntity;
import com.blockchain.timebank.wxpay.WxPay;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
}
