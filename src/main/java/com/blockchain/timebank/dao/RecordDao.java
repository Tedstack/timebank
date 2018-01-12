package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.PublishOrderEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecordDao extends CrudRepository<PublishOrderEntity, Long> {

    public PublishOrderEntity findRecordEntityById(long ID);

    public List<PublishOrderEntity> findByApplyUserId(long ID);

    public List<PublishOrderEntity> findByPublishId(long ID);

    public List<PublishOrderEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID, String status);

    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID, String status);

    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndServiceUserId(long applyUserID, long serviceUserID);
}
