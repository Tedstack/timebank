package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ActivityPublishDao;
import com.blockchain.timebank.entity.ActivityPublishEntity;
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

    public List<ActivityPublishEntity> findAllActivityPublishEntity() {
        return (List<ActivityPublishEntity>)activityPublishDao.findAll();
    }

    public ActivityPublishEntity saveActivityPublishEntity(ActivityPublishEntity activityPublishEntity) {
        return activityPublishDao.save(activityPublishEntity);
    }
}
