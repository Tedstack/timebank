package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewPublishDetailDao extends CrudRepository<ViewPublishDetailEntity, Long>{

    List<ViewPublishDetailEntity> findAllByServiceTypeOrderByCreateTime(String serviceType);

    List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByUserId(long userID);

    List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByUserIdAndIsDelete(long userID,int isDelete);

    List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByServiceTypeAndIsDeleteOrderByCreateTime(String serviceType,int isDelete);

}
