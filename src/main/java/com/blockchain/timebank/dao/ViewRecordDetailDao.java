package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewRecordDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewRecordDetailDao extends CrudRepository<ViewRecordDetailEntity, Long> {
    public List<ViewRecordDetailEntity> findViewRecordDetailEntitiesByServiceUserIdAndStatus(long serviceUserID,String status);

    public List<ViewRecordDetailEntity> findViewRecordDetailEntitiesByApplyUserIdAndStatus(long applyUserID,String status);

    public ViewRecordDetailEntity findViewRecordDetailEntityById(long ID);
}
