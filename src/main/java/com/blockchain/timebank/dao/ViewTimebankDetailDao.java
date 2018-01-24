package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewTeamDetailEntity;
import com.blockchain.timebank.entity.ViewTimebankDetailEntity;
import org.springframework.data.repository.CrudRepository;

public interface ViewTimebankDetailDao extends CrudRepository<ViewTimebankDetailEntity,Long> {
    ViewTimebankDetailEntity findViewTimebankDetailEntityById(long ID);
}
