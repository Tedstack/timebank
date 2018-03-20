package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.Evaluation_entity;
import com.blockchain.timebank.entity.PublishOrderEntity;
import com.blockchain.timebank.entity.ViewPublishOrderDetailEntity;

import java.util.List;

public interface RecordService {

    List<PublishOrderEntity> findAll();

    PublishOrderEntity saveRecordEntity(PublishOrderEntity publishOrderEntity);

    List<PublishOrderEntity> findByApplyUserId(long ID);

    List<PublishOrderEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID, String status);

    PublishOrderEntity updateRecordEntity(PublishOrderEntity publishOrderEntity);

    PublishOrderEntity findRecordEntityById(long ID);

    List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID, String status);

    List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndServiceUserId(long applyUserID, long serviceUserID);

    ViewPublishOrderDetailEntity findViewRecordDetailEntityById(long ID);

    List<Evaluation_entity> getEvaluationList(long userId);
}
