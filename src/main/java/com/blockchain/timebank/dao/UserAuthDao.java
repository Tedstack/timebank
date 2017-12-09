package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.UserAuthEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserAuthDao extends CrudRepository<UserAuthEntity, Long> {
    List<UserAuthEntity> findAllByUserId(long userId);
}
