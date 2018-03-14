package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserActivityEntity;
import java.util.List;

public interface UserActivityService {
    UserActivityEntity addUserActivity(UserActivityEntity userActivityEntity);

    UserActivityEntity findUserFromActivity(long userID, long activityID);

    UserActivityEntity findUserActivityByID(long userActivityID);

    List<UserActivityEntity> findAllByActivityId(long activityID);

    UserActivityEntity updateUserActivityEntity(UserActivityEntity userActivityEntity);
}
