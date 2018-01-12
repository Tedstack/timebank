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
    private String userHeadImg;
    private boolean isAllow;
    private boolean isPresent;
    private Double managerRating;
    private String managerComment;
    private Double userRating;
    private String userComment;
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
    private Long creatorId;

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
    @Column(name = "UserHeadImg", nullable = true, length = 255)
    public String getUserHeadImg() {
        return userHeadImg;
    }

    public void setUserHeadImg(String userHeadImg) {
        this.userHeadImg = userHeadImg;
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
    @Column(name = "CreatorID", nullable = true)
    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
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
        if (userName != null ? !userName.equals(that.userName) : that.userName != null) return false;
        if (userPhone != null ? !userPhone.equals(that.userPhone) : that.userPhone != null) return false;
        if (userHeadImg != null ? !userHeadImg.equals(that.userHeadImg) : that.userHeadImg != null) return false;
        if (managerRating != null ? !managerRating.equals(that.managerRating) : that.managerRating != null)
            return false;
        if (managerComment != null ? !managerComment.equals(that.managerComment) : that.managerComment != null)
            return false;
        if (userRating != null ? !userRating.equals(that.userRating) : that.userRating != null) return false;
        if (userComment != null ? !userComment.equals(that.userComment) : that.userComment != null) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (beginTime != null ? !beginTime.equals(that.beginTime) : that.beginTime != null) return false;
        if (endTime != null ? !endTime.equals(that.endTime) : that.endTime != null) return false;
        if (address != null ? !address.equals(that.address) : that.address != null) return false;
        if (applyEndTime != null ? !applyEndTime.equals(that.applyEndTime) : that.applyEndTime != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (teamName != null ? !teamName.equals(that.teamName) : that.teamName != null) return false;
        if (creatorId != null ? !creatorId.equals(that.creatorId) : that.creatorId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (activityId ^ (activityId >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (userName != null ? userName.hashCode() : 0);
        result = 31 * result + (userPhone != null ? userPhone.hashCode() : 0);
        result = 31 * result + (userHeadImg != null ? userHeadImg.hashCode() : 0);
        result = 31 * result + (isAllow ? 1 : 0);
        result = 31 * result + (isPresent ? 1 : 0);
        result = 31 * result + (managerRating != null ? managerRating.hashCode() : 0);
        result = 31 * result + (managerComment != null ? managerComment.hashCode() : 0);
        result = 31 * result + (userRating != null ? userRating.hashCode() : 0);
        result = 31 * result + (userComment != null ? userComment.hashCode() : 0);
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
        result = 31 * result + (creatorId != null ? creatorId.hashCode() : 0);
        return result;
    }
}
