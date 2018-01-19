package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RecordDao;
import com.blockchain.timebank.entity.PublishOrderEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    RecordDao recordDao;

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findAll() {
        return (List<PublishOrderEntity>)recordDao.findAll();
    }

    @Transactional
    public PublishOrderEntity saveRecordEntity(PublishOrderEntity publishOrderEntity) {
        return recordDao.save(publishOrderEntity);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findByApplyUserId(long ID) {
        return recordDao.findByApplyUserId(ID);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID, String status) {
        return recordDao.findRecordEntitiesByServiceUserIdAndStatus(serviceUserID,status);
    }

    @Transactional
    public PublishOrderEntity updateRecordEntity(PublishOrderEntity publishOrderEntity) {
        return recordDao.save(publishOrderEntity);
    }

    @Transactional(readOnly=true)
    public PublishOrderEntity findRecordEntityById(long ID) {
        return recordDao.findRecordEntityById(ID);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID, String status) {
        return recordDao.findRecordEntitiesByApplyUserIdAndStatus(applyUserID,status);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndServiceUserId(long applyUserID, long serviceUserID) {
        return recordDao.findRecordEntitiesByApplyUserIdAndServiceUserId(applyUserID,serviceUserID);
    }
}
