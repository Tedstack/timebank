package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewPublishDetailDao extends CrudRepository<ViewPublishDetailEntity, Long>{

    public List<ViewPublishDetailEntity> findAllByServiceType(String serviceType);

    public List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByUserId(long userID);

}
