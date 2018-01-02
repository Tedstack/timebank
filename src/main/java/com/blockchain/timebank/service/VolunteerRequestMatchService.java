package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ViewVolunteerRequestMatchDetailEntity;
import com.blockchain.timebank.entity.VolunteerRequestMatchEntity;

import java.util.List;

public interface VolunteerRequestMatchService {
    void saveVolunteerRequestMatchEntity(VolunteerRequestMatchEntity volunteerRequestMatchEntity);

    List<ViewVolunteerRequestMatchDetailEntity> findUserRequestToConfirm(long id);

    List<ViewVolunteerRequestMatchDetailEntity> findUserRequestToServe(long id);

    List<ViewVolunteerRequestMatchDetailEntity> findUserRequestToPay(long id);

    List<ViewVolunteerRequestMatchDetailEntity> findUserRequestCompleted(long id);

    List<ViewVolunteerRequestMatchDetailEntity> findUserApplyApplied(long id);

    List<ViewVolunteerRequestMatchDetailEntity> findUserApplyToServe(long id);

    VolunteerRequestMatchEntity findVolunteerRequestMatchEntityById(long id);

    VolunteerRequestMatchEntity updateVolunteerRequestMatchEntity(VolunteerRequestMatchEntity volunteerRequestMatchEntity);

    List<ViewVolunteerRequestMatchDetailEntity> findUserApplyToPay(long id);

    List<ViewVolunteerRequestMatchDetailEntity> findUserApplyCompleted(long id);

    ViewVolunteerRequestMatchDetailEntity findViewVolunteerRequestMatchDetailEntityById(long id);
}
