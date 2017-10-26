package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RecordDao;
import com.blockchain.timebank.entity.RecordEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("orderService")
public class RecordServiceImpl implements RecordService {

    @Autowired
    RecordDao recordDao;

    public List<RecordEntity> findByApplyUserId(long ID) {
        return recordDao.findByApplyUserId(ID);
    }
}
