package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewUserActivityDetailEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ViewUserActivityDetailDao extends CrudRepository<ViewUserActivityDetailEntity, Long> {
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByActivityIdAndAllow(long activityID, boolean isAllow);
    List<ViewUserActivityDetailEntity> findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresent(long activityID, boolean isAllow, boolean isPresent);
}
