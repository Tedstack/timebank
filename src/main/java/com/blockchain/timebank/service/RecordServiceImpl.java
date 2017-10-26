package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RecordDao;
import com.blockchain.timebank.entity.RecordEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    RecordDao recordDao;

    public RecordEntity saveRecordEntity(RecordEntity recordEntity) {
        return recordDao.save(recordEntity);
    }

    public List<RecordEntity> findByApplyUserId(long ID) {
        return recordDao.findByApplyUserId(ID);
    }

    public List<RecordEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID, String status) {
        return recordDao.findRecordEntitiesByServiceUserIdAndStatus(serviceUserID,status);
    }
}
