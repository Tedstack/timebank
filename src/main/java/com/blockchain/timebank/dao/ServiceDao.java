package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ServiceEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceDao extends CrudRepository<ServiceEntity, Long> {

    ServiceEntity findById(long id);

    ServiceEntity findFirstByTypeAndName(String type, String name);

}
