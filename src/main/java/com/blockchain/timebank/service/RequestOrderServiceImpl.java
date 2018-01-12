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

    public RequestOrderEntity saveRequestOrderEntity(RequestOrderEntity requestOrderEntity) {
        return requestOrderDao.save(requestOrderEntity);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestToConfirm(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestToServe(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingService);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestToPay(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    public List<ViewRequestOrderDetailEntity> findUserRequestCompleted(long id) {
        List<ViewRequestOrderDetailEntity> matchDetailEntities = viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyApplied(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyToServe(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.waitingService);
    }

    public RequestOrderEntity findRequestOrderEntityById(long id) {
        return requestOrderDao.findVolunteerRequestMatchEntityById(id);
    }

    public RequestOrderEntity updateRequestOrderEntity(RequestOrderEntity requestOrderEntity) {
        return requestOrderDao.save(requestOrderEntity);
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyToPay(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    public List<ViewRequestOrderDetailEntity> findUserApplyCompleted(long id) {
        List<ViewRequestOrderDetailEntity> matchDetailEntities = viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;

    }

    public ViewRequestOrderDetailEntity findRequestOrderDetailById(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailById(id);
    }
}
