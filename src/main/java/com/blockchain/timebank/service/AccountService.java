package com.blockchain.timebank.service;

public interface AccountService {

    void payTimeVol(long recordID);

    void payTimeCoin(long recordID);

    void updateOrderToComplete(long recordID);

    void payRequestTimeVol(long matchID);

    void payRequestTimeCoin(long matchID);

    void updateRequestOrderToComplete(long recordID);

    void updateRechargeTimeCoin(String rechargeUuid,String sign);

}
