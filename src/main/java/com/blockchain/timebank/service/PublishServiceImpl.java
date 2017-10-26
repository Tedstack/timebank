package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.PublishDao;
import com.blockchain.timebank.entity.PublishEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PublishServiceImpl implements PublishService {

    @Autowired
    PublishDao publishDao;

    public PublishEntity savePublishEntity(PublishEntity publishEntity) {
        return publishDao.save(publishEntity);
    }

    public List<PublishEntity> findAllPublishEntity() {
        List<PublishEntity> list = (List<PublishEntity>) publishDao.findAll();
        return list;
    }

    public List<PublishEntity> findByUserID(long ID) {
        return publishDao.findByUserId(ID);
    }
}
