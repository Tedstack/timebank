package com.blockchain.timebank.service;

public interface AccountService {

    public void payTimeVol(long recordID);

    void payRequestTimeVol(long matchID);
}
