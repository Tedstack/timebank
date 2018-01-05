package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ViewRequestOrderDetailEntity;
import com.blockchain.timebank.entity.RequestOrderEntity;

import java.util.List;

public interface RequestOrderService {
    void saveVolunteerRequestMatchEntity(RequestOrderEntity requestOrderEntity);

    List<ViewRequestOrderDetailEntity> findUserRequestToConfirm(long id);

    List<ViewRequestOrderDetailEntity> findUserRequestToServe(long id);

    List<ViewRequestOrderDetailEntity> findUserRequestToPay(long id);

    List<ViewRequestOrderDetailEntity> findUserRequestCompleted(long id);

    List<ViewRequestOrderDetailEntity> findUserApplyApplied(long id);

    List<ViewRequestOrderDetailEntity> findUserApplyToServe(long id);

    RequestOrderEntity findVolunteerRequestMatchEntityById(long id);

    RequestOrderEntity updateVolunteerRequestMatchEntity(RequestOrderEntity requestOrderEntity);

    List<ViewRequestOrderDetailEntity> findUserApplyToPay(long id);

    List<ViewRequestOrderDetailEntity> findUserApplyCompleted(long id);

    ViewRequestOrderDetailEntity findViewVolunteerRequestMatchDetailEntityById(long id);
}
