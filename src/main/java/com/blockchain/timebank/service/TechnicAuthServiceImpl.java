package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.TechnicAuthDao;
import com.blockchain.timebank.entity.TechnicAuthEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TechnicAuthServiceImpl implements TechnicAuthService{
    @Autowired
    TechnicAuthDao technicAuthDao;

    public List<TechnicAuthEntity> findTechnicAuthEntitiesByUserId(long userId){ return technicAuthDao.findTechnicAuthEntitiesByUserId(userId); }

    public List<TechnicAuthEntity> findAll() { return technicAuthDao.findAll(); }

    public TechnicAuthEntity findTechnicAuthEntityById(long id) { return technicAuthDao.findTechnicAuthEntityById(id); }

    public TechnicAuthEntity saveTechnicAuthEntity(TechnicAuthEntity technicAuthEntity) { return technicAuthDao.save(technicAuthEntity); }

    public boolean insertTechnicAuthEntity(TechnicAuthEntity t) throws Exception {
        try{
            technicAuthDao.insertNewTechnicAuth(t.getUserId(), t.getTechName(), t.getTechLevel(), t.getTechId(), t.getTechPhoto1(), t.getTechPhoto2(), t.getTechPhoto3());
            return true;
        }
        catch (Exception e){
            throw e;
        }
    }

    public int findTechAuthCountByUserId(long id) {
        return technicAuthDao.findTechnicAuthEntitiesByUserIdAndVerified(id, true).size();
    }

}
