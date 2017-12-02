package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewTeamDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewTeamDetailDao extends CrudRepository<ViewTeamDetailEntity, Long> {
    List<ViewTeamDetailEntity> findAllByDeleted(boolean isDeleted);
}
