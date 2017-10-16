package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TimeaccountDao;
import com.blockchain.timebank.entity.TimeaccountEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class TimeaccountServiceImpl implements TimeaccountService {


    @Autowired
    TimeaccountDao timeaccountDao;

    public TimeaccountEntity findTimeaccountByUserId(Long userId) {
        return null;
    }
}
