package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.RechargeEntity;
import org.jdom.JDOMException;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public interface RechargeService {
    String getUnifiedMessage(String openId, Double totalAmount, String out_trade, HttpServletRequest request) throws IOException;

    RechargeEntity saveRechargeEntity(RechargeEntity rechargeEntity);

    String getUifiedInfo(String openId, Integer totalAmount, Long userId) throws IOException;

    String checkPayResult(String notifyXml) throws JDOMException, IOException;

    RechargeEntity findByUuid(String uuid);

}
