package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.OrderEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDao extends CrudRepository<OrderEntity, Long> {


}
