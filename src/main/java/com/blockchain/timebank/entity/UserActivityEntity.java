package com.blockchain.timebank.entity;

import javax.persistence.*;

@Entity
@Table(name = "userActivity", schema = "mydb", catalog = "")
public class UserActivityEntity {
    private long id;
    private long activityId;
    private long userId;
    private byte isAllow;
    private byte isPresent;
    private Double rating;
    private String comment;
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
    public byte getIsAllow() {
        return isAllow;
    }

    public void setIsAllow(byte isAllow) {
        this.isAllow = isAllow;
    }

    @Basic
    @Column(name = "IsPresent", nullable = false)
    public byte getIsPresent() {
        return isPresent;
    }

    public void setIsPresent(byte isPresent) {
        this.isPresent = isPresent;
    }

    @Basic
    @Column(name = "Rating", nullable = true, precision = 0)
    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    @Basic
    @Column(name = "Comment", nullable = true, length = 100)
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
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
        if (rating != null ? !rating.equals(that.rating) : that.rating != null) return false;
        if (comment != null ? !comment.equals(that.comment) : that.comment != null) return false;
        if (extra != null ? !extra.equals(that.extra) : that.extra != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (activityId ^ (activityId >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (int) isAllow;
        result = 31 * result + (int) isPresent;
        result = 31 * result + (rating != null ? rating.hashCode() : 0);
        result = 31 * result + (comment != null ? comment.hashCode() : 0);
        result = 31 * result + (extra != null ? extra.hashCode() : 0);
        return result;
    }
}
