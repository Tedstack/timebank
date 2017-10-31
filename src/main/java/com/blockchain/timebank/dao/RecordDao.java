package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RecordEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecordDao extends CrudRepository<RecordEntity, Long> {

    public RecordEntity findRecordEntityById(long ID);

    public List<RecordEntity> findByApplyUserId(long ID);

    public List<RecordEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID,String status);

    public List<RecordEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID,String status);
}
