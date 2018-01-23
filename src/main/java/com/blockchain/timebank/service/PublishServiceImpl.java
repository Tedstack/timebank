package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.*;
import com.blockchain.timebank.entity.PublishEntity;
import com.blockchain.timebank.entity.TechnicAuthEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

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

    @Autowired
    TechnicAuthDao technicAuthDao;

    @Transactional
    public PublishEntity savePublishEntity(PublishEntity publishEntity) {
        return publishDao.save(publishEntity);
    }

    @Transactional(readOnly=true)
    public List<PublishEntity> findAllPublishEntity() {
        List<PublishEntity> list = (List<PublishEntity>) publishDao.findAll();
        return list;
    }

    @Transactional(readOnly=true)
    public List<PublishEntity> findByUserID(long ID) {
        return publishDao.findByUserId(ID);
    }

    @Transactional(readOnly=true)
    public PublishEntity findPublishEntityById(long ID) {
        return publishDao.findPublishEntityById(ID);
    }

    @Transactional(readOnly=true)
    public List<ViewPublishDetailEntity> findAllByServiceType(String type){
        List<ViewPublishDetailEntity> list = viewPublishDetailDao.findAllByServiceTypeOrderByCreateTime(type);
        return getAndSetHeadImgUrl(list);
    }

    @Transactional(readOnly=true)
    public List<ViewPublishDetailEntity> findAllByCondition(String type, double upperPrice, double lowerPrice, Timestamp upperTime, Timestamp lowerTime, String[] serviceNameArr){
        List<ViewPublishDetailEntity> list = selectServiceDao.findPublishEntityByCondition(type, upperPrice, lowerPrice, upperTime, lowerTime, serviceNameArr);
        return getAndSetHeadImgUrl(list);
    }

    @Transactional(readOnly=true)
    public List<ViewPublishDetailEntity> getAndSetHeadImgUrl(List<ViewPublishDetailEntity> list){
        for(ViewPublishDetailEntity viewPublishDetailEntity : list){
            long id = viewPublishDetailEntity.getUserId();
            UserEntity user = userDao.findUserEntityById(id);
            String openId = user.getOpenId();
            if(user.getHeadImgUrl() != null && user.getHeadImgUrl().length()!=0){
                viewPublishDetailEntity.setHeadImgUrl(user.getHeadImgUrl());
            } else {
                viewPublishDetailEntity.setHeadImgUrl("../img/userAvatar/user1.png");
            }
        }
        return list;
    }

    @Transactional(readOnly=true)
    public List<ViewPublishDetailEntity> findViewPublishDetailEntitiesByServiceTypeAndIsDeleteOrderByCreateTime(String type){
        List<ViewPublishDetailEntity> list = viewPublishDetailDao.findViewPublishDetailEntitiesByServiceTypeAndIsDeleteOrderByCreateTime(type, 0);
        // List<ViewPublishDetailEntity> list = viewPublishDetailDao.findAllByServiceType(type);
        //倒序排列
        Collections.reverse(list);
        List<ViewPublishDetailEntity> overTimeList = new ArrayList<ViewPublishDetailEntity>();
        Date currentDate = new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
        String currentTime = sdf.format(currentDate);
        Iterator iterator = list.iterator();
        while(iterator.hasNext()){
            ViewPublishDetailEntity viewPublishDetailEntity = (ViewPublishDetailEntity)iterator.next();
            if(viewPublishDetailEntity.getEndDate().getTime() < new Date(currentTime).getTime()){
                iterator.remove();
                overTimeList.add(viewPublishDetailEntity);
            }
        }
        list.addAll(overTimeList);
        return list;
    }

    @Transactional(readOnly=true)
    public List<TechnicAuthEntity> findTechnicAuthEntitiesByUserId(long currentUserId){
        return technicAuthDao.findTechnicAuthEntitiesByUserId(currentUserId);
    }

    public List<PublishEntity> findByUserIdAndCreateTimeAfter(long ID, Timestamp CreateTime){
        return publishDao.findByUserIdAndCreateTimeAfter(ID, CreateTime);
    }
}
