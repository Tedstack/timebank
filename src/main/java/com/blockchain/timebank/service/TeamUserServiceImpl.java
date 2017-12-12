package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TeamUserDao;
import com.blockchain.timebank.entity.TeamUserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeamUserServiceImpl implements TeamUserService {

    @Autowired
    TeamUserDao teamUserDao;

    public TeamUserEntity addUserToTeam(TeamUserEntity teamUser) {
        return teamUserDao.save(teamUser);
    }
}
