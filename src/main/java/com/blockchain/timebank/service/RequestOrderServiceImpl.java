package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ViewRequestOrderDetailDao;
import com.blockchain.timebank.dao.RequestOrderDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.util.MySortList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
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

    @Transactional(readOnly = true)
    public List<Evaluation_entity> getEvaluationList(long userId) {
        List<ViewRequestOrderDetailEntity> requestlist = viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(userId,OrderStatus.alreadyComplete);
        List<Evaluation_entity> recordlist = new ArrayList<Evaluation_entity>();
        Iterator<ViewRequestOrderDetailEntity> iter2 = requestlist.iterator();
        while(iter2.hasNext()){
            ViewRequestOrderDetailEntity record2 = iter2.next();
            if(null != record2.getRate() || null != record2.getComment()){
                Evaluation_entity entity = new Evaluation_entity();
                entity.setClassify("request");
                entity.setId(record2.getRequestId());
                entity.setService_name(record2.getServiceName());
                entity.setRating(record2.getRate());
                entity.setService_type(record2.getServiceType());
                entity.setComment(record2.getComment());
                entity.setEndTime(record2.getActualEndTime());
                recordlist.add(entity);
            }
        }
        if(recordlist.size()>0){
            MySortList<Evaluation_entity> msList = new MySortList<Evaluation_entity>();
            msList.sortByMethod(recordlist,"getEndTime",true);
        }
        return recordlist;
    }
}
