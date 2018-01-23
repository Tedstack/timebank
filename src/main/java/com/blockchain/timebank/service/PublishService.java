package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.PublishEntity;
import com.blockchain.timebank.entity.TechnicAuthEntity;
import com.blockchain.timebank.entity.ViewPublishDetailEntity;

import java.sql.Timestamp;
import java.util.List;

public interface PublishService {
    PublishEntity savePublishEntity(PublishEntity publishEntity);

    List<PublishEntity> findAllPublishEntity();

    List<PublishEntity> findByUserID(long ID);

    PublishEntity findPublishEntityById(long ID);

    List<ViewPublishDetailEntity> findAllByServiceType(String type);

    List<ViewPublishDetailEntity> findAllByCondition(String type, double upperPrice, double lowerPrice, Timestamp upperTime, Timestamp lowerTime, String[] serviceNameArr);

    List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByServiceTypeAndIsDeleteOrderByCreateTime(String type);

    List<TechnicAuthEntity> findTechnicAuthEntitiesByUserId(long currentUserId);

    List<PublishEntity> findByUserIdAndCreateTimeAfter(long ID, Timestamp CreateTime);
}
