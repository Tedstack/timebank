package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RequestEntity;
import org.springframework.data.repository.CrudRepository;

public interface RequestDao extends CrudRepository<RequestEntity, Long> {
    RequestEntity findRequestEntityById(long id);
}
