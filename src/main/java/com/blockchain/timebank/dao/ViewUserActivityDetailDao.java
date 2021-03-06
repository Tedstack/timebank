package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewUserActivityDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewUserActivityDetailDao extends CrudRepository<ViewUserActivityDetailEntity, Long> {
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByActivityIdAndAllow(long activityID, boolean isAllow);
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresent(long activityID, boolean isAllow, boolean isPresent);
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByUserIdAndStatusAndAllow(long userID, String status, boolean isAllow);
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresentAndStatus(long activityID, boolean isAllow, boolean isPresent ,String status);
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByUserIdAndAllowAndPresentAndStatus(long userID, boolean isAllow, boolean isPresent, String status);
    ViewUserActivityDetailEntity findViewUserActivityDetailEntityByUserIdAndActivityIdAndAllow(long userId,long activityId,boolean isAllow);
    List<ViewUserActivityDetailEntity> findAllByTeamId(long teamId);
}
