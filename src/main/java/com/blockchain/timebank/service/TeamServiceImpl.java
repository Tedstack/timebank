package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TeamDao;
import com.blockchain.timebank.entity.TeamEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    TeamDao teamDao;

    public List<TeamEntity> findAllTeamEntity() {
        return (List<TeamEntity>) teamDao.findAll();
    }

    public TeamEntity saveTeamEntity(TeamEntity teamEntity) {
        return teamDao.save(teamEntity);
    }

    public TeamEntity findById(long Id) {
        return teamDao.findOne(Id);
    }

    public List<TeamEntity> findTeamsByManagerUserId(long managerUserId) {
        return teamDao.findTeamsByManagerUserId(managerUserId);
    }

}
