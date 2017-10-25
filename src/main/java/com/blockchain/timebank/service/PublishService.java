package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.PublishEntity;

import java.util.List;

public interface PublishService {
    PublishEntity savePublishEntity(PublishEntity publishEntity);

    List<PublishEntity> findAllPublishEntity();

    public List<PublishEntity> findByUserID(long ID);
}
