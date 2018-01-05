package com.blockchain.timebank.entity;

import javax.persistence.*;

@Entity
@Table(name = "userActivity", schema = "mydb", catalog = "")
public class UserActivityEntity {
    private long id;
    private long activityId;
    private long userId;
    private boolean isAllow;
    private boolean isPresent;
    private Double managerRating;
    private String managerComment;
    private Double userRating;
    private String userComment;
    private String extra;

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
    @Column(name = "IsPresent", nullable = false)
    public boolean isPresent() {
        return isPresent;
    }

    public void setPresent(boolean present) {
        isPresent = present;
    }

    @Basic
    @Column(name = "ManagerRating", nullable = true, precision = 0)
    public Double getManagerRating() {
        return managerRating;
    }

    public void setManagerRating(Double managerRating) {
        this.managerRating = managerRating;
    }

    @Basic
    @Column(name = "ManagerComment", nullable = true, length = 100)
    public String getManagerComment() {
        return managerComment;
    }

    public void setManagerComment(String managerComment) {
        this.managerComment = managerComment;
    }

    @Basic
    @Column(name = "UserRating", nullable = true, precision = 0)
    public Double getUserRating() {
        return userRating;
    }

    public void setUserRating(Double userRating) {
        this.userRating = userRating;
    }

    @Basic
    @Column(name = "UserComment", nullable = true, length = 100)
    public String getUserComment() {
        return userComment;
    }

    public void setUserComment(String userComment) {
        this.userComment = userComment;
    }

    @Basic
    @Column(name = "Extra", nullable = true, length = 50)
    public String getExtra() {
        return extra;
    }

    public void setExtra(String extra) {
        this.extra = extra;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserActivityEntity that = (UserActivityEntity) o;

        if (id != that.id) return false;
        if (activityId != that.activityId) return false;
        if (userId != that.userId) return false;
        if (isAllow != that.isAllow) return false;
        if (isPresent != that.isPresent) return false;
        if (managerRating != null ? !managerRating.equals(that.managerRating) : that.managerRating != null)
            return false;
        if (managerComment != null ? !managerComment.equals(that.managerComment) : that.managerComment != null)
            return false;
        if (userRating != null ? !userRating.equals(that.userRating) : that.userRating != null) return false;
        if (userComment != null ? !userComment.equals(that.userComment) : that.userComment != null) return false;
        if (extra != null ? !extra.equals(that.extra) : that.extra != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (activityId ^ (activityId >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (isAllow ? 1 : 0);
        result = 31 * result + (isPresent ? 1 : 0);
        result = 31 * result + (managerRating != null ? managerRating.hashCode() : 0);
        result = 31 * result + (managerComment != null ? managerComment.hashCode() : 0);
        result = 31 * result + (userRating != null ? userRating.hashCode() : 0);
        result = 31 * result + (userComment != null ? userComment.hashCode() : 0);
        result = 31 * result + (extra != null ? extra.hashCode() : 0);
        return result;
    }
}
