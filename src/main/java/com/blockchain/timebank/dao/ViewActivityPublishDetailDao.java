package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewActivityPublishDetailEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ViewActivityPublishDetailDao extends CrudRepository<ViewActivityPublishDetailEntity, Long> {
    List<ViewActivityPublishDetailEntity> findAllByDeleted(boolean isDeleted);
}
