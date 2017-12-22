package com.blockchain.timebank.entity;

import javax.persistence.*;

@Entity
@Table(name = "view_user_activity_detail", schema = "mydb", catalog = "")
public class ViewUserActivityDetailEntity {
    private long id;
    private long activityId;
    private long userId;
    private String userName;
    private String userPhone;
    private boolean isAllow;
    private boolean isPresent;
    private long teamId;
    private String status;
    private long managerUserId;

    @Id
    @Column(name = "ID", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "ActivityID", nullable = false)
    public long getActivityId() {
        return activityId;
    }

    public void setActivityId(long activityId) {
        this.activityId = activityId;
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
    @Column(name = "IsAllow", nullable = false)
    public boolean isAllow() {
        return isAllow;
    }

    public void setAllow(boolean allow) {
        isAllow = allow;
    }

    @Basic
    @Column(name = "IsPresent", nullable = false)
    public boolean isPresent() {
        return isPresent;
    }

    public void setPresent(boolean present) {
        isPresent = present;
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
    @Column(name = "Status", nullable = false, length = 50)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Basic
    @Column(name = "ManagerUserID", nullable = false)
    public long getManagerUserId() {
        return managerUserId;
    }

    public void setManagerUserId(long managerUserId) {
        this.managerUserId = managerUserId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ViewUserActivityDetailEntity that = (ViewUserActivityDetailEntity) o;

        if (id != that.id) return false;
        if (activityId != that.activityId) return false;
        if (userId != that.userId) return false;
        if (isAllow != that.isAllow) return false;
        if (isPresent != that.isPresent) return false;
        if (teamId != that.teamId) return false;
        if (managerUserId != that.managerUserId) return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;
        if (userPhone != null ? !userPhone.equals(that.userPhone) : that.userPhone != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (activityId ^ (activityId >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (userPhone != null ? userPhone.hashCode() : 0);
        result = 31 * result + (isAllow ? 1 : 0);
        result = 31 * result + (isPresent ? 1 : 0);
        result = 31 * result + (int) (teamId ^ (teamId >>> 32));
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (int) (managerUserId ^ (managerUserId >>> 32));
        return result;
    }
}
