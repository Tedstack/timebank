package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ServiceEntity;

import java.util.List;

public interface ServiceService {
    ServiceEntity saveServiceEntity(ServiceEntity serviceEntity);

    List<ServiceEntity> findAllServiceEntity();

    public ServiceEntity findById(long id);
}
