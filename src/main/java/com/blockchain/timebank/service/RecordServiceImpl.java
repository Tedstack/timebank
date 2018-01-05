package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RecordDao;
import com.blockchain.timebank.entity.PublishOrderEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    RecordDao recordDao;

    public List<PublishOrderEntity> findAll() {
        return (List<PublishOrderEntity>)recordDao.findAll();
    }

    public PublishOrderEntity saveRecordEntity(PublishOrderEntity publishOrderEntity) {
        return recordDao.save(publishOrderEntity);
    }

    public List<PublishOrderEntity> findByApplyUserId(long ID) {
        return recordDao.findByApplyUserId(ID);
    }

    public List<PublishOrderEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID, String status) {
        return recordDao.findRecordEntitiesByServiceUserIdAndStatus(serviceUserID,status);
    }

    public PublishOrderEntity updateRecordEntity(PublishOrderEntity publishOrderEntity) {
        return recordDao.save(publishOrderEntity);
    }

    public PublishOrderEntity findRecordEntityById(long ID) {
        return recordDao.findRecordEntityById(ID);
    }

    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID, String status) {
        return recordDao.findRecordEntitiesByApplyUserIdAndStatus(applyUserID,status);
    }

    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndServiceUserId(long applyUserID, long serviceUserID) {
        return recordDao.findRecordEntitiesByApplyUserIdAndServiceUserId(applyUserID,serviceUserID);
    }
}
