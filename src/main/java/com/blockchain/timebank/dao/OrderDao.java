package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.OrderEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDao extends CrudRepository<OrderEntity, Long> {

    public List<OrderEntity> findByApplyUserId(long ID);
}
