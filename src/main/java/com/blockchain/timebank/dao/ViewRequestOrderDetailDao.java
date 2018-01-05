package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewRequestOrderDetailEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ViewRequestOrderDetailDao extends CrudRepository<ViewRequestOrderDetailEntity, Long> {
    List<ViewRequestOrderDetailEntity> findViewVolunteerRequestMatchDetailEntitiesByRequestUserId(long id);
    List<ViewRequestOrderDetailEntity> findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(long id, String status);
    List<ViewRequestOrderDetailEntity> findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(long id, String status);
    ViewRequestOrderDetailEntity findViewVolunteerRequestMatchDetailEntityById(long id);
}
