package com.blockchain.timebank.entity;

import javax.persistence.*;

@Entity
@Table(name = "view_user_activity_detail", schema = "mydb", catalog = "")
public class ViewUserActivityDetailEntity {
    private long id;
    private long activityId;
    private long userId;
    private boolean isAllow;
    private long teamId;
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
    @Column(name = "IsAllow", nullable = false)
    public boolean isAllow() {
        return isAllow;
    }

    public void setAllow(boolean allow) {
        isAllow = allow;
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
        if (teamId != that.teamId) return false;
        if (managerUserId != that.managerUserId) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (activityId ^ (activityId >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (isAllow ? 1 : 0);
        result = 31 * result + (int) (teamId ^ (teamId >>> 32));
        result = 31 * result + (int) (managerUserId ^ (managerUserId >>> 32));
        return result;
    }
}
