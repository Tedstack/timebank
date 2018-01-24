package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RechargeTimebankEntity;
import org.springframework.data.repository.CrudRepository;

public interface RechargeTimebankDao extends CrudRepository<RechargeTimebankEntity,Long> {
}
