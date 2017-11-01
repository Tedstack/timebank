package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.RecordEntity;

import java.util.List;

public interface RecordService {

    public List<RecordEntity> findAll();

    public RecordEntity saveRecordEntity(RecordEntity recordEntity);

    public List<RecordEntity> findByApplyUserId(long ID);

    public List<RecordEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID,String status);

    public RecordEntity updateRecordEntity(RecordEntity recordEntity);

    public RecordEntity findRecordEntityById(long ID);

    public List<RecordEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID,String status);

    public List<RecordEntity> findRecordEntitiesByApplyUserIdAndServiceUserId(long applyUserID,long serviceUserID);
}
