package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ViewVolunteerRequestDetailEntity;
import com.blockchain.timebank.entity.VolunteerRequestEntity;

import java.util.List;

public interface VolunteerRequestService {
    List<ViewVolunteerRequestDetailEntity> findAllVolunteerRequestDetail();
    void saveVolunteerRequestEntity(VolunteerRequestEntity volunteerRequestEntity);
}
