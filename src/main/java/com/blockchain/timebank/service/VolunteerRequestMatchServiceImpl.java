package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ViewVolunteerRequestMatchDetailDao;
import com.blockchain.timebank.dao.VolunteerRequestMatchDao;
import com.blockchain.timebank.entity.OrderStatus;
import com.blockchain.timebank.entity.ViewVolunteerRequestMatchDetailEntity;
import com.blockchain.timebank.entity.VolunteerRequestMatchEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VolunteerRequestMatchServiceImpl implements VolunteerRequestMatchService {
    @Autowired
    VolunteerRequestMatchDao volunteerRequestMatchDao;

    @Autowired
    ViewVolunteerRequestMatchDetailDao viewVolunteerRequestMatchDetailDao;

    public void saveVolunteerRequestMatchEntity(VolunteerRequestMatchEntity volunteerRequestMatchEntity) {
        volunteerRequestMatchDao.save(volunteerRequestMatchEntity);
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserRequestToConfirm(long id) {
        return viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserRequestToServe(long id) {
        return viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingService);
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserRequestToPay(long id) {
        return viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserRequestCompleted(long id) {
        List<ViewVolunteerRequestMatchDetailEntity> matchDetailEntities = viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByRequestUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserApplyApplied(long id) {
        return viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.alreadyApply);
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserApplyToServe(long id) {
        return viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.waitingService);
    }

    public VolunteerRequestMatchEntity findVolunteerRequestMatchEntityById(long id) {
        return volunteerRequestMatchDao.findVolunteerRequestMatchEntityById(id);
    }

    public VolunteerRequestMatchEntity updateVolunteerRequestMatchEntity(VolunteerRequestMatchEntity volunteerRequestMatchEntity) {
        return volunteerRequestMatchDao.save(volunteerRequestMatchEntity);
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserApplyToPay(long id) {
        return viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.waitingPay);
    }

    public List<ViewVolunteerRequestMatchDetailEntity> findUserApplyCompleted(long id) {
        List<ViewVolunteerRequestMatchDetailEntity> matchDetailEntities = viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.alreadyRefuse);
        matchDetailEntities.addAll(viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntitiesByApplyUserIdAndStatus(id, OrderStatus.alreadyComplete));
        return matchDetailEntities;

    }

    public ViewVolunteerRequestMatchDetailEntity findViewVolunteerRequestMatchDetailEntityById(long id) {
        return viewVolunteerRequestMatchDetailDao.findViewVolunteerRequestMatchDetailEntityById(id);
    }
}
