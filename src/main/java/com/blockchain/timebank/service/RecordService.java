package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.PublishOrderEntity;

import java.util.List;

public interface RecordService {

    public List<PublishOrderEntity> findAll();

    public PublishOrderEntity saveRecordEntity(PublishOrderEntity publishOrderEntity);

    public List<PublishOrderEntity> findByApplyUserId(long ID);

    public List<PublishOrderEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID, String status);

    public PublishOrderEntity updateRecordEntity(PublishOrderEntity publishOrderEntity);

    public PublishOrderEntity findRecordEntityById(long ID);

    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID, String status);

    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndServiceUserId(long applyUserID, long serviceUserID);
}
