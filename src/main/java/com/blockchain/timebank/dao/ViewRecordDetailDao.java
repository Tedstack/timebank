package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewPublishOrderDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewRecordDetailDao extends CrudRepository<ViewPublishOrderDetailEntity, Long> {
    List<ViewPublishOrderDetailEntity> findViewRecordDetailEntitiesByServiceUserIdAndStatus(long serviceUserID, String status);

    List<ViewPublishOrderDetailEntity> findViewRecordDetailEntitiesByApplyUserIdAndStatus(long applyUserID, String status);

    ViewPublishOrderDetailEntity findViewRecordDetailEntityById(long ID);

    List<ViewPublishOrderDetailEntity> findViewRecordDetailEntitiesByPublishIdAndStatus(long publishID, String status);
}
