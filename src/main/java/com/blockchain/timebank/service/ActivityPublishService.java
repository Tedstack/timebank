package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ActivityPublishEntity;

import java.util.List;

public interface ActivityPublishService {

    List<ActivityPublishEntity> findAllByDeleted(boolean isDeleted);

    List<ActivityPublishEntity> findAllActivityPublishEntity();

    ActivityPublishEntity saveActivityPublishEntity(ActivityPublishEntity activityPublishEntity);
}
