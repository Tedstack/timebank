package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RechargeUserDao;
import com.blockchain.timebank.entity.RechargeUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RechargeUserServiceImpl implements RechargeUserService {
    @Autowired
    RechargeUserDao rechargeUserDao;

    public RechargeUserEntity saveRechargeUserEntity(RechargeUserEntity rechargeUserEntity) {
        return rechargeUserDao.save(rechargeUserEntity);
    }
}
