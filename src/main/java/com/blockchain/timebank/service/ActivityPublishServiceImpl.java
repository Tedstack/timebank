package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ActivityPublishDao;
import com.blockchain.timebank.entity.ActivityPublishEntity;
import com.blockchain.timebank.entity.ActivityStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@Service
public class ActivityPublishServiceImpl implements ActivityPublishService {

    @Autowired
    ActivityPublishDao activityPublishDao;

    @Transactional(readOnly=true)
    public List<ActivityPublishEntity> findAllByDeleted(boolean isDeleted) {
        return activityPublishDao.findAllByDeleted(isDeleted);
    }

    @Transactional(readOnly=true)
    public List<ActivityPublishEntity> findAllWaitingApplyActivityPublishEntity() {
        return (List<ActivityPublishEntity>)activityPublishDao.findByDeletedAndStatus(false, ActivityStatus.waitingForApply);
    }

    public ActivityPublishEntity saveActivityPublishEntity(ActivityPublishEntity activityPublishEntity) {
        return activityPublishDao.save(activityPublishEntity);
    }

    @Transactional(readOnly=true)
    public ActivityPublishEntity findActivityPublishEntityByID(long ID) {
        return activityPublishDao.findOne(ID);
    }

    @Transactional(readOnly=true)
    public List<ActivityPublishEntity> findAllByTeamIdAndStatus(long teamId,String status){return activityPublishDao.findAllByTeamIdAndStatus(teamId,status);}

    @Transactional(readOnly=true)
    public List<ActivityPublishEntity> findAllByTeamIdAndStatusAndBeginTimeAfter(long teamId, String status, Timestamp time){return activityPublishDao.findAllByTeamIdAndStatusAndBeginTimeAfter(teamId,status,time);}

    @Transactional(readOnly=true)
    public List<ActivityPublishEntity> findAllByStatusAndBeginTimeAfter(String status, Timestamp time){return activityPublishDao.findAllByStatusAndBeginTimeAfter(status,time);}

    @Transactional(readOnly=true)
    public List<ActivityPublishEntity> findAllByTeamId(long teamId){return activityPublishDao.findAllByTeamId(teamId);}
}
