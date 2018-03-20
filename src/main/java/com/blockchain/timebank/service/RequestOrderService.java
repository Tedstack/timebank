package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.Evaluation_entity;
import com.blockchain.timebank.entity.ViewRequestOrderDetailEntity;
import com.blockchain.timebank.entity.RequestOrderEntity;

import java.util.List;

public interface RequestOrderService {
    RequestOrderEntity saveRequestOrderEntity(RequestOrderEntity requestOrderEntity);

    List<ViewRequestOrderDetailEntity> findUserRequestToConfirm(long id);

    List<ViewRequestOrderDetailEntity> findUserRequestToServe(long id);

    List<ViewRequestOrderDetailEntity> findUserRequestToPay(long id);

    List<ViewRequestOrderDetailEntity> findUserRequestCompleted(long id);

    List<ViewRequestOrderDetailEntity> findUserApplyApplied(long id);

    List<ViewRequestOrderDetailEntity> findUserApplyToServe(long id);

    RequestOrderEntity findRequestOrderEntityById(long id);

    RequestOrderEntity updateRequestOrderEntity(RequestOrderEntity requestOrderEntity);

    List<ViewRequestOrderDetailEntity> findUserApplyToPay(long id);

    List<ViewRequestOrderDetailEntity> findUserApplyCompleted(long id);

    List<RequestOrderEntity> findByRequestId(long id);

    ViewRequestOrderDetailEntity findRequestOrderDetailById(long id);

    List<Evaluation_entity> getEvaluationList(long userId);
}
