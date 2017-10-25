package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.OrderEntity;

import java.util.List;

public interface OrderService {

    public List<OrderEntity> findByApplyUserId(long ID);
}
