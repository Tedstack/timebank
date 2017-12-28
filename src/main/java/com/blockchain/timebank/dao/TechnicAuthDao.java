package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.TechnicAuthEntity;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface TechnicAuthDao extends CrudRepository<TechnicAuthEntity, Long> {
    TechnicAuthEntity findTechnicAuthEntityById(long id);

    List<TechnicAuthEntity> findTechnicAuthEntitiesByUserId(long id);

    List<TechnicAuthEntity> findTechnicAuthEntitiesByUserIdAndVerified(long id, boolean verified);

    List<TechnicAuthEntity> findAll();

    @Transactional
    @Modifying
    @Query(value = "INSERT INTO mydb.technicAuth(UserID, AuthID, TechName, TechLevel, TechID, TechPhoto1, TechPhoto2, TechPhoto3, IsVerified, IsDeleted, OutDated) VALUES (?,null,?,?,?,?,?,?, FALSE, FALSE, FALSE );", nativeQuery = true)
    void insertNewTechnicAuth(long userId, String techName, String techLevel, String techId, String techImg1, String techImg2, String techImg3);
}
