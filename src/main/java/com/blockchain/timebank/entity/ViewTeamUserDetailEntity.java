package com.blockchain.timebank.entity;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.sql.Date;

@Entity
@Table(name = "view_team_user_detail", schema = "mydb", catalog = "")
public class ViewTeamUserDetailEntity {
    private long id;
    private long teamId;
    private long userId;
    private String status;
    private boolean isManager;
    private Long creatorId;
    private String teamName;
    private String userName;
    private String userPhone;
    private String userSex;
    private Date userBirth;
    private String userHeadImg;
    private boolean teamDeleted;

    @Basic
    @Column(name = "ID", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "TeamID", nullable = false)
    public long getTeamId() {
        return teamId;
    }

    public void setTeamId(long teamId) {
        this.teamId = teamId;
    }

    @Basic
    @Column(name = "UserID", nullable = false)
    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "Status", nullable = false, length = 50)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Basic
    @Column(name = "IsManager", nullable = false)
    public boolean isManager() {
        return isManager;
    }

    public void setManager(boolean manager) {
        isManager = manager;
    }

    @Basic
    @Column(name = "CreatorID", nullable = true)
    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }

    @Basic
    @Column(name = "TeamName", nullable = false, length = 40)
    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    @Basic
    @Column(name = "UserName", nullable = true, length = 20)
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    @Column(name = "UserPhone", nullable = false, length = 20)
    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    @Basic
    @Column(name = "UserSex", nullable = true, length = 10)
    public String getUserSex() {
        return userSex;
    }

    public void setUserSex(String userSex) {
        this.userSex = userSex;
    }

    @Basic
    @Column(name = "UserBirth", nullable = true)
    public Date getUserBirth() {
        return userBirth;
    }

    public void setUserBirth(Date userBirth) {
        this.userBirth = userBirth;
    }

    @Basic
    @Column(name = "UserHeadImg", nullable = true, length = 255)
    public String getUserHeadImg() {
        return userHeadImg;
    }

    public void setUserHeadImg(String userHeadImg) {
        this.userHeadImg = userHeadImg;
    }

    @Basic
    @Column(name = "TeamDeleted", nullable = false)
    public boolean isTeamDeleted() {
        return teamDeleted;
    }

    public void setTeamDeleted(boolean teamDeleted) {
        this.teamDeleted = teamDeleted;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ViewTeamUserDetailEntity that = (ViewTeamUserDetailEntity) o;

        if (id != that.id) return false;
        if (teamId != that.teamId) return false;
        if (userId != that.userId) return false;
        if (isManager != that.isManager) return false;
        if (teamDeleted != that.teamDeleted) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (creatorId != null ? !creatorId.equals(that.creatorId) : that.creatorId != null) return false;
        if (teamName != null ? !teamName.equals(that.teamName) : that.teamName != null) return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;
        if (userPhone != null ? !userPhone.equals(that.userPhone) : that.userPhone != null) return false;
        if (userSex != null ? !userSex.equals(that.userSex) : that.userSex != null) return false;
        if (userBirth != null ? !userBirth.equals(that.userBirth) : that.userBirth != null) return false;
        if (userHeadImg != null ? !userHeadImg.equals(that.userHeadImg) : that.userHeadImg != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (teamId ^ (teamId >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (isManager ? 1 : 0);
        result = 31 * result + (creatorId != null ? creatorId.hashCode() : 0);
        result = 31 * result + (teamName != null ? teamName.hashCode() : 0);
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (userPhone != null ? userPhone.hashCode() : 0);
        result = 31 * result + (userSex != null ? userSex.hashCode() : 0);
        result = 31 * result + (userBirth != null ? userBirth.hashCode() : 0);
        result = 31 * result + (userHeadImg != null ? userHeadImg.hashCode() : 0);
        result = 31 * result + (teamDeleted ? 1 : 0);
        return result;
    }
}
