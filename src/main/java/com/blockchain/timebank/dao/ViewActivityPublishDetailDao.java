package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewActivityPublishDetailEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import java.sql.Timestamp;
import java.util.List;

@Repository
public interface ViewActivityPublishDetailDao extends CrudRepository<ViewActivityPublishDetailEntity, Long> {
    List<ViewActivityPublishDetailEntity> findAllByDeleted(boolean isDeleted);
    List<ViewActivityPublishDetailEntity> findViewActivityPublishDetailEntitiesByCreatorIdAndDeletedAndStatus(long CreatorId, boolean isDeleted, String status);
    List<ViewActivityPublishDetailEntity> findViewActivityPublishDetailEntitiesByCreatorIdAndDeletedAndStatusAndBeginTimeAfter(long CreatorId, boolean isDeleted, String status,Timestamp time);
//
//    @Query("")
//    List<ViewActivityPublishDetailEntity> findAllByCondition(String activityName,Timestamp upperTime, Timestamp lowerTime);
}
