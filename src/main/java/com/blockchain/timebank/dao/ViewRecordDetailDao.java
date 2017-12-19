package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewRecordDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewRecordDetailDao extends CrudRepository<ViewRecordDetailEntity, Long> {
    List<ViewRecordDetailEntity> findViewRecordDetailEntitiesByServiceUserIdAndStatus(long serviceUserID,String status);

    List<ViewRecordDetailEntity> findViewRecordDetailEntitiesByApplyUserIdAndStatus(long applyUserID,String status);

    ViewRecordDetailEntity findViewRecordDetailEntityById(long ID);

    List<ViewRecordDetailEntity> findViewRecordDetailEntitiesByPublishIdAndStatus(long publishID,String status);
}
