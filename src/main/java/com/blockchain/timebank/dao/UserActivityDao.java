package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.UserActivityEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserActivityDao extends CrudRepository<UserActivityEntity, Long> {
    UserActivityEntity findUserActivityEntityByActivityIdAndUserIdAndAllow(long activityID, long userID,boolean isAllow);
}
