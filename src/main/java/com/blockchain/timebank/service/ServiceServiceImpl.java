package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.ServiceDao;
import com.blockchain.timebank.entity.ServiceEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Service("serviceService")
public class ServiceServiceImpl implements ServiceService {

    @Autowired
    ServiceDao serviceDao;

    @Transactional
    public ServiceEntity saveServiceEntity(ServiceEntity serviceEntity) {
        return serviceDao.save(serviceEntity);
    }

    @Transactional(readOnly=true)
    public List<ServiceEntity> findAllServiceEntity() {
        return (List<ServiceEntity>) serviceDao.findAll();
    }

    @Transactional(readOnly=true)
    public ServiceEntity findFirstByTypeAndName(String type, String name) {
        return serviceDao.findFirstByTypeAndName(type, name);
    }

    @Transactional(readOnly=true)
    public List<String> findAllServiceType() {
        List<ServiceEntity> list_service = (List<ServiceEntity>) serviceDao.findAll();
        Set<String> service_type = new HashSet<String>();
        for (ServiceEntity service : list_service) service_type.add(service.getType());
        List<String> types = new ArrayList<String>();
        types.addAll(service_type);
        return types;
    }

    @Transactional(readOnly=true)
    public ServiceEntity findById(long id) {
        return serviceDao.findById(id);
    }


}
