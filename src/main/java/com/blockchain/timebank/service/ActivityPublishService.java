package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ActivityPublishEntity;

import java.util.List;

public interface ActivityPublishService {

    List<ActivityPublishEntity> findAllByDeleted(boolean isDeleted);

    List<ActivityPublishEntity> findAllWaitingApplyActivityPublishEntity();

    ActivityPublishEntity saveActivityPublishEntity(ActivityPublishEntity activityPublishEntity);

    ActivityPublishEntity findActivityPublishEntityByID(long ID);

    List<ActivityPublishEntity> findAllByTeamIdAndStatus(long teamId,String status);
}
