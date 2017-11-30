package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ActivityPublishEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ActivityPublishDao extends CrudRepository<ActivityPublishEntity, Long> {

}
