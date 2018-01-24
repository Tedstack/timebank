package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TimebankDao;
import com.blockchain.timebank.entity.TimebankEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TimebankServiceImpl implements TimebankService {
    @Autowired
    private TimebankDao timebankDao;

    public TimebankEntity saveTimebankEntity(TimebankEntity timebankEntity) {
        return timebankDao.save(timebankEntity);
    }

    public TimebankEntity findTimebankEntityByType(String type) {
        return timebankDao.findTimebankEntityByType(type);
    }

    public TimebankEntity findTimebankEntityByID(long timebankID) {
        return timebankDao.findTimebankEntityById(timebankID);
    }

    public List<TimebankEntity> findAll() {
        return (List<TimebankEntity>) timebankDao.findAll();
    }
}
