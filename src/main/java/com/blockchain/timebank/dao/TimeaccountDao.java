package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.UserEntity;
import org.springframework.data.repository.CrudRepository;

public interface TimeaccountDao extends CrudRepository<UserEntity, Long> {

}
