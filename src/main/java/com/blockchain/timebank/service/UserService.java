package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserEntity;

import java.util.List;

public interface UserService {

    UserEntity saveUserEntity(UserEntity userEntity);

    UserEntity findUserEntityById(Long id);

    UserEntity findUserEntityByPhone(String phone);

    UserEntity findUserEntityByPhoneAndPassword(String phone, String password);

    UserEntity updateUserEntity(UserEntity userEntity);

    void deleteById(Long id);

    List<UserEntity> findAll();

    UserEntity findUserEntityByQrCode(String qrcode);
}
