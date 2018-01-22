package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ViewRequestOrderDetailDao;
import com.blockchain.timebank.dao.RequestOrderDao;
import com.blockchain.timebank.entity.OrderStatus;
import com.blockchain.timebank.entity.ViewRequestOrderDetailEntity;
import com.blockchain.timebank.entity.RequestOrderEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RequestOrderServiceImpl implements RequestOrderService {
    @Autowired
    RequestOrderDao requestOrderDao;

    @Autowired
    ViewRequestOrderDetailDao viewRequestOrderDetailDao;

    @Transactional()
    public RequestOrderEntity saveRequestOrderEntity(RequestOrderEntity requestOrderEntity) {
        return requestOrderDao.save(requestOrderEntity);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserRequestToConfirm(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserRequestToServe(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingService);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserRequestToPay(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserRequestCompleted(long id) {
        List<ViewRequestOrderDetailEntity> matchDetailEntities = viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewRequestOrderDetailDao.findViewRequestOrderDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserApplyApplied(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserApplyToServe(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.waitingService);
    }

    @Transactional(readOnly = true)
    public RequestOrderEntity findRequestOrderEntityById(long id) {
        return requestOrderDao.findRequestOrderEntityById(id);
    }

    @Transactional()
    public RequestOrderEntity updateRequestOrderEntity(RequestOrderEntity requestOrderEntity) {
        return requestOrderDao.save(requestOrderEntity);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserApplyToPay(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    @Transactional(readOnly = true)
    public List<ViewRequestOrderDetailEntity> findUserApplyCompleted(long id) {
        List<ViewRequestOrderDetailEntity> matchDetailEntities = viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;

    }

    @Transactional(readOnly = true)
    public List<RequestOrderEntity> findByRequestId(long id) {
        return requestOrderDao.findRequestOrderEntitiesByRequestId(id);
    }

    @Transactional(readOnly = true)
    public ViewRequestOrderDetailEntity findRequestOrderDetailById(long id) {
        return viewRequestOrderDetailDao.findViewRequestOrderDetailById(id);
    }
}
