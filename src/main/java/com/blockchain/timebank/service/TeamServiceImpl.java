package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TeamDao;
import com.blockchain.timebank.entity.TeamEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    TeamDao teamDao;
    @Transactional(readOnly=true)
    public List<TeamEntity> findAllTeamEntity() {
        return (List<TeamEntity>) teamDao.findAll();
    }

    public TeamEntity saveTeamEntity(TeamEntity teamEntity) {
        return teamDao.save(teamEntity);
    }
    @Transactional(readOnly=true)
    public TeamEntity findById(long Id) {
        return teamDao.findOne(Id);
    }

    public TeamEntity addTeamEntity(TeamEntity team){ return teamDao.save(team);}
    @Transactional(readOnly=true)
    public List<TeamEntity> findTeamsByCreatorId(long CreatorId) {
        return teamDao.findTeamEntitiesByCreatorIdAndDeleted(CreatorId,false);
    }
    @Transactional(readOnly=true)
    public TeamEntity findTeamByName(String teamName){return teamDao.findTeamEntityByNameAndDeleted(teamName,false);}
}
