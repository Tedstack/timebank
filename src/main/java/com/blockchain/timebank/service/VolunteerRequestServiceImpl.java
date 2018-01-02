package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ViewVolunteerRequestDetailDao;
import com.blockchain.timebank.dao.VolunteerRequestDao;
import com.blockchain.timebank.entity.ViewVolunteerRequestDetailEntity;
import com.blockchain.timebank.entity.VolunteerRequestEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VolunteerRequestServiceImpl implements VolunteerRequestService {

    @Autowired
    private ViewVolunteerRequestDetailDao viewVolunteerRequestDetailDao;

    @Autowired
    private VolunteerRequestDao volunteerRequestDao;

    public List<ViewVolunteerRequestDetailEntity> findAllVolunteerRequestDetail() {
        return viewVolunteerRequestDetailDao.findAll();
    }

    public void saveVolunteerRequestEntity(VolunteerRequestEntity volunteerRequestEntity) {
        volunteerRequestDao.save(volunteerRequestEntity);
    }

    public ViewVolunteerRequestDetailEntity findDetailById(long id) {
        return viewVolunteerRequestDetailDao.findViewVolunteerRequestDetailEntityById(id);
    }

    public List<ViewVolunteerRequestDetailEntity> findUserRequestPublished(long id) {
        return viewVolunteerRequestDetailDao.findViewVolunteerRequestDetailEntitiesByUserId(new Long(id));
    }

    public VolunteerRequestEntity findRequestById(long id) {
        return volunteerRequestDao.findVolunteerRequestEntityById(id);
    }
}
