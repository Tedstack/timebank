package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TeamUserDao;
import com.blockchain.timebank.entity.TeamUserEntity;
import com.blockchain.timebank.entity.TeamUserStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamUserServiceImpl implements TeamUserService {

    @Autowired
    TeamUserDao teamUserDao;

    public TeamUserEntity addUserToTeam(TeamUserEntity teamUser) {
        return teamUserDao.save(teamUser);
    }

    public List<TeamUserEntity> findAll() {
        return (List<TeamUserEntity>) teamUserDao.findAll();
    }

    public TeamUserEntity findById(long id) {
        return teamUserDao.findOne(id);
    }

    public TeamUserEntity saveTeamUser(TeamUserEntity teamUserEntity) {
        return teamUserDao.save(teamUserEntity);
    }

    public List<TeamUserEntity> findAllUsersOfOneTeam(long teamID) {
        return teamUserDao.findByTeamId(teamID);
    }

    public TeamUserEntity findByUserIdAndTeamIdAndStatus(long userId,long teamId,String status){return teamUserDao.findByUserIdAndTeamIdAndStatus(userId,teamId,status);}
}
