package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserDao;
import com.blockchain.timebank.entity.UserEntity;

import javax.annotation.Resource;

public class UserServiceImpl implements UserService {

    @Resource
    UserDao userDao;


    public UserEntity saveUserEntity(UserEntity userEntity) {
        return userDao.save(userEntity);
    }

    public UserEntity findUserEntityById(Long id) {
        return userDao.findOne(id);
    }

    public UserEntity updateUserEntity(UserEntity userEntity) {
        return userDao.save(userEntity);
    }

    public void deleteById(Long id) {
        userDao.delete(id);
    }

}
