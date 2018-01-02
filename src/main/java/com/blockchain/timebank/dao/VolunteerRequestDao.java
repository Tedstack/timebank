package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.VolunteerRequestEntity;
import org.springframework.data.repository.CrudRepository;

public interface VolunteerRequestDao extends CrudRepository<VolunteerRequestEntity, Long> {
    VolunteerRequestEntity findVolunteerRequestEntityById(long id);
}
