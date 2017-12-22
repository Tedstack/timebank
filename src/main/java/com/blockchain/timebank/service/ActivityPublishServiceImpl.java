package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ActivityPublishDao;
import com.blockchain.timebank.entity.ActivityPublishEntity;
import com.blockchain.timebank.entity.ActivityStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityPublishServiceImpl implements ActivityPublishService {

    @Autowired
    ActivityPublishDao activityPublishDao;

    public List<ActivityPublishEntity> findAllByDeleted(boolean isDeleted) {
        return activityPublishDao.findAllByDeleted(isDeleted);
    }

    public List<ActivityPublishEntity> findAllWaitingApplyActivityPublishEntity() {
        return (List<ActivityPublishEntity>)activityPublishDao.findByDeletedAndStatus(false, ActivityStatus.waitingForApply);
    }

    public ActivityPublishEntity saveActivityPublishEntity(ActivityPublishEntity activityPublishEntity) {
        return activityPublishDao.save(activityPublishEntity);
    }

    public ActivityPublishEntity findActivityPublishEntityByID(long ID) {
        return activityPublishDao.findOne(ID);
    }
}
