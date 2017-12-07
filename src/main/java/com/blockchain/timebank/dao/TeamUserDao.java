package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.TeamUserEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamUserDao extends CrudRepository<TeamUserEntity, Long> {
}
