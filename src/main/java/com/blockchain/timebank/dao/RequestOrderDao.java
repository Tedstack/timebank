package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RequestOrderEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RequestOrderDao extends CrudRepository<RequestOrderEntity, Long> {
    RequestOrderEntity findRequestOrderEntityById(long id);
    List<RequestOrderEntity> findRequestOrderEntitiesByRequestId(long id);
}
