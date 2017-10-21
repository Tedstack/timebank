package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserEntity;

public interface UserService {

    UserEntity saveUserEntity(UserEntity userEntity);

    UserEntity findUserEntityById(Long id);

    UserEntity findUserEntityByPhone(String phone);

    UserEntity findUserEntityByPhoneAndPassword(String phone, String password);

    UserEntity updateUserEntity(UserEntity userEntity);

    void deleteById(Long id);
}
