package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewVolunteerRequestMatchDetailEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ViewVolunteerRequestMatchDetailDao  extends CrudRepository<ViewVolunteerRequestMatchDetailEntity, Long> {
    List<ViewVolunteerRequestMatchDetailEntity> findViewVolunteerRequestMatchDetailEntitiesByRequestUserId(long id);
    List<ViewVolunteerRequestMatchDetailEntity> findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(long id, String status);
    List<ViewVolunteerRequestMatchDetailEntity> findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(long id, String status);
    ViewVolunteerRequestMatchDetailEntity findViewVolunteerRequestMatchDetailEntityById(long id);
}
