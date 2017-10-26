package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.PublishEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PublishDao extends CrudRepository<PublishEntity, Long> {

    public List<PublishEntity> findByUserId(long ID);

    public PublishEntity findPublishEntityById(long ID);
}
