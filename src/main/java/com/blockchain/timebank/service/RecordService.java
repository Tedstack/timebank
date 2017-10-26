package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.RecordEntity;

import java.util.List;

public interface RecordService {

    public RecordEntity saveRecordEntity(RecordEntity recordEntity);

    public List<RecordEntity> findByApplyUserId(long ID);

    public List<RecordEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID,String status);
}
