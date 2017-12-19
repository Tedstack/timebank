package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.TeamEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeamDao extends CrudRepository<TeamEntity, Long> {
    List<TeamEntity> findTeamEntitiesByManagerUserIdAndDeleted(long managerUserId,boolean isDeleted);
}
