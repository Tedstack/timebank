package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ViewPublishDetailDao extends CrudRepository<ViewPublishDetailEntity, Long>{



}
