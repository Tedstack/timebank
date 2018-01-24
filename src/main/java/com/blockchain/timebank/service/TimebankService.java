package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.TimebankEntity;

import java.util.List;

public interface TimebankService {
    TimebankEntity saveTimebankEntity(TimebankEntity timebankEntity);

    TimebankEntity findTimebankEntityByType(String type);

    TimebankEntity findTimebankEntityByID(long timebankID);

    List<TimebankEntity> findAll();
}
