package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.TimebankEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TimebankDao extends CrudRepository<TimebankEntity,Long> {
    TimebankEntity findTimebankEntityByType(String type);

    TimebankEntity findTimebankEntityById(long id);
}
