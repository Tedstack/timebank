package com.blockchain.timebank.service;

public interface TimebankAccountService {
    boolean createNewCurrency(String type, double total, String description, String reason);

    boolean rechargeCurrency(long timebankID, double rechargeValue ,String rechargeReason);

    boolean rechargeCurrencyToUser(String userPhone, long timebankID ,double rechargeValue ,String rechargeReason);
}
