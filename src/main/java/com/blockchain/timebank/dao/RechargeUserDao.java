package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RechargeUserEntity;
import org.springframework.data.repository.CrudRepository;

public interface RechargeUserDao extends CrudRepository<RechargeUserEntity,Long> {
}
