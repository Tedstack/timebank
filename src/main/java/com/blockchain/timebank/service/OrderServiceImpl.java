package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.OrderDao;
import com.blockchain.timebank.entity.OrderEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderDao orderDao;

    public List<OrderEntity> findByApplyUserId(long ID) {
        return orderDao.findByApplyUserId(ID);
    }
}
