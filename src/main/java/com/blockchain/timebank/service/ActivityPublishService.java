package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ActivityPublishEntity;

import java.sql.Timestamp;
import java.util.List;

public interface ActivityPublishService {

    List<ActivityPublishEntity> findAllByDeleted(boolean isDeleted);

    List<ActivityPublishEntity> findAllWaitingApplyActivityPublishEntity();

    ActivityPublishEntity saveActivityPublishEntity(ActivityPublishEntity activityPublishEntity);

    ActivityPublishEntity findActivityPublishEntityByID(long ID);

    List<ActivityPublishEntity> findAllByTeamIdAndStatus(long teamId,String status);

    List<ActivityPublishEntity> findAllByTeamIdAndStatusAndBeginTimeAfter(long teamId, String status, Timestamp time);

    List<ActivityPublishEntity> findAllByStatusAndBeginTimeAfter(String status, Timestamp time);

    List<ActivityPublishEntity> findAllByTeamId(long ID);
}
