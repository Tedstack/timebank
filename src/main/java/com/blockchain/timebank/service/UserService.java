package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserEntity;
import org.springframework.security.core.userdetails.User;

import java.util.List;

public interface UserService {

    UserEntity saveUserEntity(UserEntity userEntity);

    UserEntity findUserEntityById(Long id);

    UserEntity findUserEntityByPhone(String phone);

    UserEntity findUserEntityByUserName(String userName);

    UserEntity findUserEntityByPhoneAndPassword(String phone, String password);

    UserEntity updateUserEntity(UserEntity userEntity);

    void deleteById(Long id);

    List<UserEntity> findAll();

    UserEntity findUserEntityByQrCode(String qrcCode);

    UserEntity findUserEntityByIdCard(String idCard);

    UserEntity findUserEntityByOpenID(String openID);

    void saveUserHeadImgUrl(UserEntity userEntity, String openId, String accessToken, String path);
}
