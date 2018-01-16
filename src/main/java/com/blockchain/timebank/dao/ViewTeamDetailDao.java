package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewTeamDetailEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ViewTeamDetailDao extends CrudRepository<ViewTeamDetailEntity, Long> {
    List<ViewTeamDetailEntity> findAllByDeleted(boolean isDeleted);

    @Query("select t from ViewTeamDetailEntity t where t.name like ?1% and t.deleted=false")
    List<ViewTeamDetailEntity> findTeamByCondition(String teamName);
}
