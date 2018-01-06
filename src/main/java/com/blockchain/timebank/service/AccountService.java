package com.blockchain.timebank.service;

public interface AccountService {

    void payTimeVol(long recordID);

    void updateOrderToComplete(long recordID);

    void payRequestTimeVol(long matchID);
}
