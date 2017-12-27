package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.*;
import com.blockchain.timebank.entity.PublishEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Service
public class PublishServiceImpl implements PublishService {

    @Autowired
    PublishDao publishDao;

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @Autowired
    UserDao userDao;

    @Autowired
    SelectServiceDao selectServiceDao;

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

    public PublishEntity findPublishEntityById(long ID) {
        return publishDao.findPublishEntityById(ID);
    }

    public List<ViewPublishDetailEntity> findAllByServiceType(String type){
        List<ViewPublishDetailEntity> list = viewPublishDetailDao.findAllByServiceType(type);
        return getAndSetHeadImgUrl(list);
    }

    public List<ViewPublishDetailEntity> findAllByCondition(String type, double upperPrice, double lowerPrice, Timestamp upperTime, Timestamp lowerTime, String[] serviceNameArr){
        List<ViewPublishDetailEntity> list = selectServiceDao.findPublishEntityByCondition(type, upperPrice, lowerPrice, upperTime, lowerTime, serviceNameArr);
        return getAndSetHeadImgUrl(list);
    }

    public List<ViewPublishDetailEntity> getAndSetHeadImgUrl(List<ViewPublishDetailEntity> list){
        for(ViewPublishDetailEntity viewPublishDetailEntity : list){
            long id = viewPublishDetailEntity.getUserId();
            UserEntity user = userDao.findUserEntityById(id);
            String openId = user.getOpenId();
            if("noID".equals(openId) || null == openId){
                viewPublishDetailEntity.setHeadImgUrl("user1.png");
            } else {
                viewPublishDetailEntity.setHeadImgUrl(openId+".jpg");
            }
        }
        return list;
    }
}
