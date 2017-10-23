package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ServiceEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ServiceDao extends CrudRepository<ServiceEntity, Long> {


}
