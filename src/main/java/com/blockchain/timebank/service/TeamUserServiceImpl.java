package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TeamUserDao;
import com.blockchain.timebank.entity.TeamUserEntity;
import com.blockchain.timebank.entity.TeamUserStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TeamUserServiceImpl implements TeamUserService {

    @Autowired
    TeamUserDao teamUserDao;

    public TeamUserEntity addUserToTeam(TeamUserEntity teamUser) {
        return teamUserDao.save(teamUser);
    }

    @Transactional(readOnly=true)
    public List<TeamUserEntity> findAll() {
        return (List<TeamUserEntity>) teamUserDao.findAll();
    }

    @Transactional(readOnly=true)
    public TeamUserEntity findById(long id) {
        return teamUserDao.findOne(id);
    }

    public TeamUserEntity saveTeamUser(TeamUserEntity teamUserEntity) {
        return teamUserDao.save(teamUserEntity);
    }

    @Transactional(readOnly=true)
    public List<TeamUserEntity> findAllUsersOfOneTeam(long teamID) {
        return teamUserDao.findByTeamId(teamID);
    }

    @Transactional(readOnly=true)
    public TeamUserEntity findByUserIdAndTeamId(long userId,long teamId){return teamUserDao.findByUserIdAndTeamId(userId,teamId);}

    @Transactional(readOnly=true)
    public TeamUserEntity findByUserIdAndTeamIdAndStatusNot(long userId,long teamID,String status){return teamUserDao.findByUserIdAndTeamIdAndStatusNot(userId,teamID,status);}
}
