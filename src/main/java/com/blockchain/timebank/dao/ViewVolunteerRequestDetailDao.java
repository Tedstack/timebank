package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.ViewVolunteerRequestDetailEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ViewVolunteerRequestDetailDao extends CrudRepository<ViewVolunteerRequestDetailEntity, Long> {
    List<ViewVolunteerRequestDetailEntity> findAll();
}
