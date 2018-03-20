package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RecordDao;
import com.blockchain.timebank.dao.ViewRecordDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.util.MySortList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    RecordDao recordDao;

    @Autowired
    ViewRecordDetailDao viewRecordDetailDao;

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findAll() {
        return (List<PublishOrderEntity>)recordDao.findAll();
    }

    @Transactional
    public PublishOrderEntity saveRecordEntity(PublishOrderEntity publishOrderEntity) {
        return recordDao.save(publishOrderEntity);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findByApplyUserId(long ID) {
        return recordDao.findByApplyUserId(ID);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findRecordEntitiesByServiceUserIdAndStatus(long serviceUserID, String status) {
        return recordDao.findRecordEntitiesByServiceUserIdAndStatus(serviceUserID,status);
    }

    @Transactional
    public PublishOrderEntity updateRecordEntity(PublishOrderEntity publishOrderEntity) {
        return recordDao.save(publishOrderEntity);
    }

    @Transactional(readOnly=true)
    public PublishOrderEntity findRecordEntityById(long ID) {
        return recordDao.findRecordEntityById(ID);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndStatus(long applyUserID, String status) {
        return recordDao.findRecordEntitiesByApplyUserIdAndStatus(applyUserID,status);
    }

    @Transactional(readOnly=true)
    public List<PublishOrderEntity> findRecordEntitiesByApplyUserIdAndServiceUserId(long applyUserID, long serviceUserID) {
        return recordDao.findRecordEntitiesByApplyUserIdAndServiceUserId(applyUserID,serviceUserID);
    }

    @Transactional(readOnly=true)
    public ViewPublishOrderDetailEntity findViewRecordDetailEntityById(long ID){
        return viewRecordDetailDao.findViewRecordDetailEntityById(ID);
    }

    @Transactional(readOnly=true)
    public List<Evaluation_entity> getEvaluationList(long userId){
        List<ViewPublishOrderDetailEntity> servicelist = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(userId,OrderStatus.alreadyComplete);
        List<Evaluation_entity> recordlist = new ArrayList<Evaluation_entity>();
        Iterator<ViewPublishOrderDetailEntity> iter1 = servicelist.iterator();
        while(iter1.hasNext()){
            ViewPublishOrderDetailEntity record = iter1.next();
            if(null != record.getRating() || null != record.getComment()){
                Evaluation_entity entity = new Evaluation_entity() ;
                entity.setClassify("service");
                entity.setId(record.getPublishId());
                entity.setService_name(record.getServiceName());
                entity.setRating(record.getRating());
                entity.setService_type(record.getServiceType());
                entity.setComment(record.getComment());
                entity.setEndTime(record.getActualEndTime());
                recordlist.add(entity);
            }
        }
        if(recordlist.size()>0){
            MySortList<Evaluation_entity> msList = new MySortList<Evaluation_entity>();
            msList.sortByMethod(recordlist,"getEndTime",true);
        }
        return recordlist;
    }
}
