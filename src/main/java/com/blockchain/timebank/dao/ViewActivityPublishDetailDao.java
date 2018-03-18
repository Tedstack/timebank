package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewActivityPublishDetailEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

@Repository
public interface ViewActivityPublishDetailDao extends CrudRepository<ViewActivityPublishDetailEntity, Long> {
    List<ViewActivityPublishDetailEntity> findAllByDeleted(boolean isDeleted);
    List<ViewActivityPublishDetailEntity> findViewActivityPublishDetailEntitiesByCreatorIdOrPublishUserIdAndDeletedAndStatus(long CreatorId, long publisherId,boolean isDeleted, String status);
    List<ViewActivityPublishDetailEntity> findViewActivityPublishDetailEntitiesByDeletedAndStatusAndBeginTimeAfterAndCreatorIdOrPublishUserId(boolean isDeleted, String status,Timestamp time,long CreatorId,long publisherId);
    List<ViewActivityPublishDetailEntity> findAllByNameContainingAndDeletedAndBeginTimeAfterAndEndTimeBefore(String name,boolean isDeleted,Timestamp beginTime,Timestamp endTime);
    @Query("select a from ViewActivityPublishDetailEntity a where (a.publishUserId=?1 or a.creatorId=?1) and a.deleted=false and a.status=?2 and a.beginTime>?3")
    List<ViewActivityPublishDetailEntity> findAllByConditionWithTime(long userId, String status, Timestamp beginTime);

    @Query("select a from ViewActivityPublishDetailEntity a where (a.publishUserId=?1 or a.creatorId=?1) and a.deleted=false and a.status=?2")
    List<ViewActivityPublishDetailEntity> findAllByCondition(long userId, String status);
}
