package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.UserAuthEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserAuthDao extends CrudRepository<UserAuthEntity, Long> {
    UserAuthEntity findUserAuthEntityByPhone(String phone);
}
