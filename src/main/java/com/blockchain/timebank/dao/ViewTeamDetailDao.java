package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewTeamDetailEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ViewTeamDetailDao extends CrudRepository<ViewTeamDetailEntity, Long> {
}
