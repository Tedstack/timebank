package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserAuthEntity;

import java.util.List;

public interface UserAuthService {
    List<UserAuthEntity> findAllByUserId(long userId);
}
