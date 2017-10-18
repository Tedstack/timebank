package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.TimeaccountEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TimeaccountDao extends CrudRepository<TimeaccountEntity, Long> {

}
