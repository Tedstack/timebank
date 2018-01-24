package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RechargeTimebankDao;
import com.blockchain.timebank.entity.RechargeTimebankEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RechargeTimebankServiceImpl implements RechargeTimebankService {
    @Autowired
    RechargeTimebankDao rechargeTimebankDao;

    public RechargeTimebankEntity saveRechargeTimebankEntity(RechargeTimebankEntity rechargeTimebankEntity) {
        return rechargeTimebankDao.save(rechargeTimebankEntity);
    }
}
