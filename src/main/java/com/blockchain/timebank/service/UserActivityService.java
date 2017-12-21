package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserActivityEntity;

public interface UserActivityService {
    UserActivityEntity addUserActivity(UserActivityEntity userActivityEntity);

    UserActivityEntity findUserFromActivity(long userID, long activityID);

    UserActivityEntity findUserActivityByID(long userActivityID);

    UserActivityEntity updateUserActivityEntity(UserActivityEntity userActivityEntity);
}
