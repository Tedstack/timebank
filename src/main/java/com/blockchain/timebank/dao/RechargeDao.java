package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.RechargeEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface RechargeDao extends CrudRepository<RechargeEntity, Long> {
    RechargeEntity findByUuid(String uuid);
    List<RechargeEntity> findByUserId(long userId);
}
