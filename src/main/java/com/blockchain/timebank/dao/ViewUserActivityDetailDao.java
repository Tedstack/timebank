package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewUserActivityDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewUserActivityDetailDao extends CrudRepository<ViewUserActivityDetailEntity, Long> {
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByActivityIdAndAllow(long activityID, boolean isAllow);
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresent(long activityID, boolean isAllow, boolean isPresent);
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByUserIdAndStatus(long userID, String status);
}
