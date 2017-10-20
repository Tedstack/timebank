package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.UserEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao extends CrudRepository<UserEntity, Long> {

    UserEntity findUserEntityByPhone(String phone);
}
