package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ViewRequestDetailDao;
import com.blockchain.timebank.dao.RequestDao;
import com.blockchain.timebank.entity.RequestEntity;
import com.blockchain.timebank.entity.ViewRequestDetailEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
public class RequestServiceImpl implements RequestService {

    @Autowired
    private ViewRequestDetailDao viewRequestDetailDao;

    @Autowired
    private RequestDao requestDao;

    public List<ViewRequestDetailEntity> findAllRequestDetailByType(String type) {
        return viewRequestDetailDao.findViewRequestDetailEntitiesByServiceTypeAndIsDeletedOrderByCreateTimeDesc(type, 0);
    }

    public void saveRequestEntity(RequestEntity requestEntity) {
        requestDao.save(requestEntity);
    }

    public ViewRequestDetailEntity findDetailById(long id) {
        return viewRequestDetailDao.findViewRequestDetailEntityById(id);
    }

    public List<ViewRequestDetailEntity> findUserRequestPublished(long id) {
        return viewRequestDetailDao.findViewRequestDetailEntitiesByUserIdAndIsDeleted(id, 0);
    }

    public RequestEntity findRequestById(long id) {
        return requestDao.findRequestEntityById(id);
    }

    public List<ViewRequestDetailEntity> findAllByCondition(String type, BigDecimal upperPrice, BigDecimal lowerPrice, Timestamp upperTime, Timestamp lowerTime, String[] serviceNameArr) {
        return viewRequestDetailDao.findViewRequestDetailEntityByConditionOrderByCreateTimeDesc(type, upperPrice, lowerPrice, upperTime, lowerTime, serviceNameArr);
    }
}
