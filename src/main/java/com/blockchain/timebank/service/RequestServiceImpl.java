package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ViewRequestDetailDao;
import com.blockchain.timebank.dao.RequestDao;
import com.blockchain.timebank.entity.RequestEntity;
import com.blockchain.timebank.entity.ViewRequestDetailEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.*;

@Service
public class RequestServiceImpl implements RequestService {

    @Autowired
    private ViewRequestDetailDao viewRequestDetailDao;

    @Autowired
    private RequestDao requestDao;

    @Transactional(readOnly = true)
    public List<ViewRequestDetailEntity> findAllRequestDetailByType(String type) {
        return viewRequestDetailDao.findViewRequestDetailEntitiesByServiceTypeAndIsDeletedOrderByCreateTimeDesc(type, 0);
    }

    @Transactional()
    public void saveRequestEntity(RequestEntity requestEntity) {
        requestDao.save(requestEntity);
    }

    @Transactional(readOnly = true)
    public ViewRequestDetailEntity findDetailById(long id) {
        return viewRequestDetailDao.findViewRequestDetailEntityById(id);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestDetailEntity> findUserRequestPublished(long id) {
        return viewRequestDetailDao.findViewRequestDetailEntitiesByUserIdAndIsDeleted(id, 0);
    }

    @Transactional(readOnly = true)
    public RequestEntity findRequestById(long id) {
        return requestDao.findRequestEntityById(id);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestDetailEntity> findAllByCondition(String type, BigDecimal upperPrice, BigDecimal lowerPrice, Timestamp upperTime, Timestamp lowerTime, String[] serviceNameArr) {
        return viewRequestDetailDao.findViewRequestDetailEntityByConditionOrderByCreateTimeDesc(type, upperPrice, lowerPrice, upperTime, lowerTime, serviceNameArr);
    }

    @Transactional(readOnly = true)
    public long findTodayCountByUserId(long id) {
        long current = System.currentTimeMillis()+TimeZone.getDefault().getRawOffset();
        long start = current/(1000*3600*24)*(1000*3600*24)-TimeZone.getDefault().getRawOffset();
        long end = start+24*60*60*1000;
        return requestDao.countAllByUserIdAndCreateTimeBetween(id, new Timestamp(start), new Timestamp(end));
    }
}
