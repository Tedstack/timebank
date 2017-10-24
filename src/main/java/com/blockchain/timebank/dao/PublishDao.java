package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.PublishEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PublishDao extends CrudRepository<PublishEntity, Long> {


}