package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserEntity;

public interface UserService {

    UserEntity saveUserEntity(UserEntity userEntity);

    UserEntity findUserEntityById(Long id);

    UserEntity updateUserEntity(UserEntity userEntity);

    void deleteById(Long id);
}
