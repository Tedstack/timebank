package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ViewRequestOrderDetailDao;
import com.blockchain.timebank.dao.RequestOrderDao;
import com.blockchain.timebank.entity.OrderStatus;
import com.blockchain.timebank.entity.ViewRequestOrderDetailEntity;
import com.blockchain.timebank.entity.RequestOrderEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RequestOrderServiceImpl implements RequestOrderService {
    @Autowired
    RequestOrderDao requestOrderDao;

    @Autowired
    ViewRequestOrderDetailDao viewRequestOrderDetailDao;

    public void saveVolunteerRequestMatchEntity(RequestOrderEntity requestOrderEntity) {
        requestOrderDao.save(requestOrderEntity);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestToConfirm(long id) {
        return viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestToServe(long id) {
        return viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingService);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestToPay(long id) {
        return viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestCompleted(long id) {
        List<ViewRequestOrderDetailEntity> matchDetailEntities = viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyApplied(long id) {
        return viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyToServe(long id) {
        return viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.waitingService);
    }

    public RequestOrderEntity findVolunteerRequestMatchEntityById(long id) {
        return requestOrderDao.findVolunteerRequestMatchEntityById(id);
    }

    public RequestOrderEntity updateVolunteerRequestMatchEntity(RequestOrderEntity requestOrderEntity) {
        return requestOrderDao.save(requestOrderEntity);
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyToPay(long id) {
        return viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyCompleted(long id) {
        List<ViewRequestOrderDetailEntity> matchDetailEntities = viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;

    }

    public ViewRequestOrderDetailEntity findViewVolunteerRequestMatchDetailEntityById(long id) {
        return viewRequestOrderDetailDao.findViewVolunteerRequestMatchDetailEntityById(id);
    }
}
