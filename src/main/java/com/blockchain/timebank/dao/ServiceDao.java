package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ServiceEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ServiceDao extends CrudRepository<ServiceEntity, Long> {

    public ServiceEntity findById(long id);
}
