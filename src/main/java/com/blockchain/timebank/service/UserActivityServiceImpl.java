package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserActivityDao;
import com.blockchain.timebank.entity.UserActivityEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserActivityServiceImpl implements UserActivityService {

    @Autowired
    UserActivityDao userActivityDao;

    public UserActivityEntity addUserActivity(UserActivityEntity userActivityEntity) {
        return userActivityDao.save(userActivityEntity);
    }

    public UserActivityEntity findUserFromActivity(long userID, long activityID) {
        UserActivityEntity userActivityEntity = userActivityDao.findUserActivityEntityByActivityIdAndUserIdAndAllow(activityID, userID,true);
        return userActivityEntity;
    }

    public UserActivityEntity findUserActivityByID(long userActivityID) {
        return userActivityDao.findOne(userActivityID);
    }

    public UserActivityEntity updateUserActivityEntity(UserActivityEntity userActivityEntity) {
        return userActivityDao.save(userActivityEntity);
    }
}
