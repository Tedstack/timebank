package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.RequestEntity;
import com.blockchain.timebank.entity.ViewRequestDetailEntity;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public interface RequestService {
    List<ViewRequestDetailEntity> findAllRequestDetailByType(String type);
    void saveRequestEntity(RequestEntity volunteerRequestEntity);
    ViewRequestDetailEntity findDetailById(long id);
    List<ViewRequestDetailEntity> findUserRequestPublished(long id);
    RequestEntity findRequestById(long id);
    List<ViewRequestDetailEntity> findAllByCondition(String type, BigDecimal upperPrice, BigDecimal lowerPrice, Timestamp upperTime, Timestamp lowerTime, String[] serviceNameArr);
}
