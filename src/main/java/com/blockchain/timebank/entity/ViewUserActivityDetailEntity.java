package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Timestamp;

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
    private Double rating;
    private String comment;
    private long teamId;
    private String name;
    private Timestamp beginTime;
    private Timestamp endTime;
    private String address;
    private int count;
    private Timestamp applyEndTime;
    private String description;
    private String status;
    private String teamName;
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
    @Column(name = "TeamID", nullable = false)
    public long getTeamId() {
        return teamId;
    }

    public void setTeamId(long teamId) {
        this.teamId = teamId;
    }

    @Basic
    @Column(name = "Name", nullable = false, length = 40)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "BeginTime", nullable = false)
    public Timestamp getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Timestamp beginTime) {
        this.beginTime = beginTime;
    }

    @Basic
    @Column(name = "EndTime", nullable = true)
    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    @Basic
    @Column(name = "Address", nullable = false, length = 50)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Basic
    @Column(name = "Count", nullable = false)
    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Basic
    @Column(name = "ApplyEndTime", nullable = false)
    public Timestamp getApplyEndTime() {
        return applyEndTime;
    }

    public void setApplyEndTime(Timestamp applyEndTime) {
        this.applyEndTime = applyEndTime;
    }

    @Basic
    @Column(name = "Description", nullable = true, length = 200)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
    @Column(name = "TeamName", nullable = false, length = 40)
    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
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
        if (count != that.count) return false;
        if (managerUserId != that.managerUserId) return false;
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;
        if (userPhone != null ? !userPhone.equals(that.userPhone) : that.userPhone != null) return false;
        if (rating != null ? !rating.equals(that.rating) : that.rating != null) return false;
        if (comment != null ? !comment.equals(that.comment) : that.comment != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (beginTime != null ? !beginTime.equals(that.beginTime) : that.beginTime != null) return false;
        if (endTime != null ? !endTime.equals(that.endTime) : that.endTime != null) return false;
        if (address != null ? !address.equals(that.address) : that.address != null) return false;
        if (applyEndTime != null ? !applyEndTime.equals(that.applyEndTime) : that.applyEndTime != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (teamName != null ? !teamName.equals(that.teamName) : that.teamName != null) return false;

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
        result = 31 * result + (rating != null ? rating.hashCode() : 0);
        result = 31 * result + (comment != null ? comment.hashCode() : 0);
        result = 31 * result + (int) (teamId ^ (teamId >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (beginTime != null ? beginTime.hashCode() : 0);
        result = 31 * result + (endTime != null ? endTime.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + count;
        result = 31 * result + (applyEndTime != null ? applyEndTime.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (teamName != null ? teamName.hashCode() : 0);
        result = 31 * result + (int) (managerUserId ^ (managerUserId >>> 32));
        return result;
    }
}
