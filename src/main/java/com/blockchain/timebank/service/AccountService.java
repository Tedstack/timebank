package com.blockchain.timebank.service;

import java.math.BigDecimal;

public interface AccountService {

    void payTimeVol(long recordID);

    void payTimeCoin(long recordID);

    void updateOrderToComplete(long recordID);

    void payRequestTimeVol(long matchID, BigDecimal price);

    void payRequestTimeCoin(long matchID, BigDecimal price);

    void updateRequestOrderToComplete(long recordID);

    void updateRechargeTimeCoin(String rechargeUuid,String sign);

}
