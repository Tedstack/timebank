package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserDao;
import com.blockchain.timebank.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;


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
