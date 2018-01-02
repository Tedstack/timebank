package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.TeamUserEntity;

import java.util.List;

public interface TeamUserService {
    TeamUserEntity addUserToTeam(TeamUserEntity teamUser);

    List<TeamUserEntity> findAll();

    TeamUserEntity findById(long id);

    TeamUserEntity findByUserIdAndTeamIdAndStatus(long userId,long teamID,String status);

    TeamUserEntity saveTeamUser(TeamUserEntity teamUserEntity);

    List<TeamUserEntity> findAllUsersOfOneTeam(long teamID);
}
