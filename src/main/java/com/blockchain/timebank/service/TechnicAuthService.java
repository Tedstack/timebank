package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.TechnicAuthEntity;

import java.util.List;

public interface TechnicAuthService {

    List<TechnicAuthEntity> findTechnicAuthEntitiesByUserId(long id);


    List<TechnicAuthEntity> findAll();

    TechnicAuthEntity findTechnicAuthEntityById(long id);

    TechnicAuthEntity saveTechnicAuthEntity(TechnicAuthEntity technicAuthEntity);

    boolean insertTechnicAuthEntity(TechnicAuthEntity technicAuthEntity) throws Exception;

    int findTechAuthCountByUserId(long id);
}
