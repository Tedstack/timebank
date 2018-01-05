package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RequestOrderEntity;
import org.springframework.data.repository.CrudRepository;

public interface RequestOrderDao extends CrudRepository<RequestOrderEntity, Long> {
    RequestOrderEntity findVolunteerRequestMatchEntityById(long id);
}
