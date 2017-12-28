package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ActivityPublishEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActivityPublishDao extends CrudRepository<ActivityPublishEntity, Long> {
    List<ActivityPublishEntity> findAllByDeleted(boolean isDeleted);

    List<ActivityPublishEntity> findByDeletedAndStatus(boolean isDeleted, String status);

    List<ActivityPublishEntity> findAllByTeamIdAndStatus(long teamId,String status);
}
