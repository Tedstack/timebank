package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "view_activity_publish_detail", schema = "mydb", catalog = "")
public class ViewActivityPublishDetailEntity {
    private long id;
    private long teamId;
    private String name;
    private Timestamp beginTime;
    private Timestamp endTime;
    private String address;
    private int count;
    private Timestamp applyEndTime;
    private String description;
    private String status;
    private byte isPublic;
    private byte isDeleted;
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
    @Column(name = "IsPublic", nullable = false)
    public byte getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(byte isPublic) {
        this.isPublic = isPublic;
    }

    @Basic
    @Column(name = "IsDeleted", nullable = false)
    public byte getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(byte isDeleted) {
        this.isDeleted = isDeleted;
    }

    @Basic
    @Column(name = "teamName", nullable = false, length = 40)
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

        ViewActivityPublishDetailEntity that = (ViewActivityPublishDetailEntity) o;

        if (id != that.id) return false;
        if (teamId != that.teamId) return false;
        if (count != that.count) return false;
        if (isPublic != that.isPublic) return false;
        if (isDeleted != that.isDeleted) return false;
        if (managerUserId != that.managerUserId) return false;
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
        result = 31 * result + (int) (teamId ^ (teamId >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (beginTime != null ? beginTime.hashCode() : 0);
        result = 31 * result + (endTime != null ? endTime.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + count;
        result = 31 * result + (applyEndTime != null ? applyEndTime.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (int) isPublic;
        result = 31 * result + (int) isDeleted;
        result = 31 * result + (teamName != null ? teamName.hashCode() : 0);
        result = 31 * result + (int) (managerUserId ^ (managerUserId >>> 32));
        return result;
    }
}
