package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserAuthDao;
import com.blockchain.timebank.entity.UserAuthEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserAuthServiceImpl implements UserAuthService {

    @Autowired
    UserAuthDao userAuthDao;

    public List<UserAuthEntity> findAllByUserId(long userId) {
        return userAuthDao.findAllByUserId(userId);
    }
}
