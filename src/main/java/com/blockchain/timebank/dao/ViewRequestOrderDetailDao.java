package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewRequestOrderDetailEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ViewRequestOrderDetailDao extends CrudRepository<ViewRequestOrderDetailEntity, Long> {
    List<ViewRequestOrderDetailEntity> findViewRequestOrderDetailEntitiesByRequestUserId(long id);
    List<ViewRequestOrderDetailEntity> findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(long id, String status);
    List<ViewRequestOrderDetailEntity> findViewRequestOrderDetailByApplyUserIdAndStatus(long id, String status);
    ViewRequestOrderDetailEntity findViewRequestOrderDetailById(long id);

}
