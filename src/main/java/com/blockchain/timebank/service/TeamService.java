package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.TeamEntity;

import java.util.List;

public interface TeamService {
    List<TeamEntity> findAllTeamEntity();

    TeamEntity saveTeamEntity(TeamEntity teamEntity);
}
