package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.TeamEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamDao extends CrudRepository<TeamEntity, Long> {

}
