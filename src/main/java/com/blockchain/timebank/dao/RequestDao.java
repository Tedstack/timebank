package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RequestEntity;
import org.springframework.data.repository.CrudRepository;

import java.sql.Timestamp;

public interface RequestDao extends CrudRepository<RequestEntity, Long> {
    RequestEntity findRequestEntityById(long id);
    long countAllByUserIdAndCreateTimeBetween(long id, Timestamp start, Timestamp end);
}
