package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.ServiceEntity;

import java.util.List;

public interface ServiceService {
    ServiceEntity saveServiceEntity(ServiceEntity serviceEntity);

    List<ServiceEntity> findAllServiceEntity();

    ServiceEntity findById(long id);

    ServiceEntity findFirstByTypeAndName(String type, String name);

    List<String> findAllServiceType();
}
