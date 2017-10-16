package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.TimeaccountEntity;

public interface TimeaccountService {
    TimeaccountEntity findTimeaccountByUserId(Long userId);
}
