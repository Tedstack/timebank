package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserActivityDao;
import com.blockchain.timebank.entity.UserActivityEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserActivityServiceImpl implements UserActivityService {

    @Autowired
    UserActivityDao userActivityDao;

    public UserActivityEntity addUserActivity(UserActivityEntity userActivityEntity) {
        return userActivityDao.save(userActivityEntity);
    }

    @Transactional(readOnly=true)
    public UserActivityEntity findUserFromActivity(long userID, long activityID) {
        UserActivityEntity userActivityEntity = userActivityDao.findUserActivityEntityByActivityIdAndUserId(activityID, userID);
        return userActivityEntity;
    }

    @Transactional(readOnly=true)
    public UserActivityEntity findUserActivityByID(long userActivityID) {
        return userActivityDao.findOne(userActivityID);
    }

    @Transactional(readOnly=true)
    public List<UserActivityEntity> findAllByActivityId(long activityId){
        return userActivityDao.findAllByActivityId(activityId);
    }

    public UserActivityEntity updateUserActivityEntity(UserActivityEntity userActivityEntity) {
        return userActivityDao.save(userActivityEntity);
    }
}
