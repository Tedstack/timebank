package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewTeamUserDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewTeamUserDetailDao extends CrudRepository<ViewTeamUserDetailEntity, Long> {
    List<ViewTeamUserDetailEntity> findAllByTeamId(long teamId);
}
