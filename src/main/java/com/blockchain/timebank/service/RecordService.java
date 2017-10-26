package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.RecordEntity;

import java.util.List;

public interface RecordService {

    public List<RecordEntity> findByApplyUserId(long ID);
}
