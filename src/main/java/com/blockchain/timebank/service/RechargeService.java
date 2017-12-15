package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.RechargeEntity;

import java.io.IOException;

public interface RechargeService {
    String getUnifiedMessage(String openId, Integer totalAmount, Long userId) throws IOException;

    RechargeEntity saveRechargeEntity(RechargeEntity rechargeEntity);
}
