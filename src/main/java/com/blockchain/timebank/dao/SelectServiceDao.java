package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Timestamp;
import java.util.List;

public interface SelectServiceDao extends JpaRepository<ViewPublishDetailEntity, Long> {
    /*@Query("select e from ViewPublishDetailEntity e where e.serviceType=?1 and e.serviceName in ?2 and e.beginDate between ?3 and ?4 and e.endDate between ?3 and ?4 and e.price between ?5 and ?6")
    public List<ViewPublishDetailEntity> findPublishEntityByCondition(String type,String[] serviceName, Timestamp upperTime, Timestamp lowerTime, double upperPrice, double lowerPrice);*/
    @Query("select e from ViewPublishDetailEntity e where e.isDelete=0 and e.serviceType=?1 and e.price <= ?2 and e.price >=?3 and e.endDate <= ?4 and e.endDate>= ?5 and e.beginDate <= ?4 and e.beginDate >= ?5 and e.serviceName in ?6")
    List<ViewPublishDetailEntity> findPublishEntityByCondition(String type, double upperPrice, double lowerPrice, Timestamp upperTime, Timestamp lowerTime, String[] serviceNameArr);
}



