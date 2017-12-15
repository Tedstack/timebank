package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserAuthEntity;

import java.util.List;

public interface UserAuthService {
    UserAuthEntity saveUserAuthEntity(UserAuthEntity userAuthEntity);

    List<UserAuthEntity> findAll();

    UserAuthEntity findUserAuthEntityById(long id);

    UserAuthEntity findUserAuthEntityByPhone(String phone);

    List<String> getAllAuthoritiesFromJSONString(String authority);

    String getJSONStringFromAllAuthorities(String[] authorities);
}
