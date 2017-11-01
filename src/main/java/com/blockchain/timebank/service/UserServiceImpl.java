package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserDao;
import com.blockchain.timebank.entity.PublishEntity;
import com.blockchain.timebank.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    public UserEntity findUserEntityByPhone(String phone) {
        return userDao.findUserEntityByPhone(phone);
    }

    public UserEntity findUserEntityByPhoneAndPassword(String phone, String password) {
        return userDao.findUserEntityByPhoneAndPassword(phone,password);
    }

    public UserEntity updateUserEntity(UserEntity userEntity) {
        return userDao.save(userEntity);
    }

    public void deleteById(Long id) {
        userDao.delete(id);
    }


    public List<UserEntity> findAll(){
        return (List<UserEntity>)userDao.findAll();
    }

    public UserEntity findUserEntityByQrCode(String qrcode) {
        return userDao.findUserEntityByQrCode(qrcode);
    }

}
