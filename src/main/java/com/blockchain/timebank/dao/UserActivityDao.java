package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.UserActivityEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserActivityDao extends CrudRepository<UserActivityEntity, Long> {
    UserActivityEntity findUserActivityEntityByActivityIdAndUserId(long activityID, long userID);
    List<UserActivityEntity> findAllByActivityId(long activityId);
}
