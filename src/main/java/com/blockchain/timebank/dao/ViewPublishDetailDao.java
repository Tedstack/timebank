package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewPublishDetailDao extends CrudRepository<ViewPublishDetailEntity, Long>{

    public List<ViewPublishDetailEntity> findAllByServiceTypeOrderByCreateTime(String serviceType);

    public List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByUserId(long userID);

    public List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByUserIdAndIsDelete(long userID,int isDelete);

    public List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByServiceTypeAndIsDelete(String serviceType,int isDelete);

}
