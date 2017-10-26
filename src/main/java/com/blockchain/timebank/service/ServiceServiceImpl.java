package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ServiceDao;
import com.blockchain.timebank.entity.ServiceEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ServiceServiceImpl implements ServiceService {

    @Autowired
    ServiceDao serviceDao;

    public ServiceEntity saveServiceEntity(ServiceEntity serviceEntity) {
        return serviceDao.save(serviceEntity);
    }

    public List<ServiceEntity> findAllServiceEntity() {
        return (List<ServiceEntity>) serviceDao.findAll();
    }

    public ServiceEntity findFirstByTypeAndName(String type, String name) {
        return serviceDao.findFirstByTypeAndName(type, name);
    }
}
