package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.TeamEntity;

import java.util.List;

public interface TeamService {
    List<TeamEntity> findAllTeamEntity();

    TeamEntity addTeamEntity(TeamEntity teamEntity);

    TeamEntity saveTeamEntity(TeamEntity teamEntity);

    TeamEntity findById(long Id);

    TeamEntity findTeamByName(String name);

    List<TeamEntity> findTeamsByCreatorId(long CreatorId);
}
