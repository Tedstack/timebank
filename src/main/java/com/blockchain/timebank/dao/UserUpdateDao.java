package com.blockchain.timebank.dao;

import com.blockchain.timebank.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface UserUpdateDao extends JpaRepository<UserEntity, Long> {
    @Transactional
    @Modifying
    @Query("update UserEntity u set u.headImgUrl = ?1 where u.id=?2")
    void updataUserHeadImgUrl(String headImgUrl,long id);
}
