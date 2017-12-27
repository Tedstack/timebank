package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.TeamUserEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TeamUserDao extends CrudRepository<TeamUserEntity, Long> {
    List<TeamUserEntity> findByTeamId(long teamID);

    TeamUserEntity findByUserIdAndTeamIdAndDeleted(long userId,long teamId,boolean isDeleted);
}
