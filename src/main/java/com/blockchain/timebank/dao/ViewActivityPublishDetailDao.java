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
    List<ViewActivityPublishDetailEntity> findViewActivityPublishDetailEntitiesByCreatorIdOrPublishUserIdAndDeletedAndStatus(long CreatorId, long publisherId,boolean isDeleted, String status);
    List<ViewActivityPublishDetailEntity> findViewActivityPublishDetailEntitiesByCreatorIdOrPublishUserIdAndDeletedAndStatusAndBeginTimeAfter(long CreatorId,long publisherId, boolean isDeleted, String status,Timestamp time);
    List<ViewActivityPublishDetailEntity> findAllByNameContainingAndDeletedAndBeginTimeAfterAndEndTimeBefore(String name,boolean isDeleted,Timestamp beginTime,Timestamp endTime);
}
