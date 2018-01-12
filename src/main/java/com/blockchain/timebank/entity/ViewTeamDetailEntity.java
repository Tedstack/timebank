package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "view_team_detail", schema = "mydb", catalog = "")
public class ViewTeamDetailEntity {
    private long id;
    private String name;
    private Long creatorId;
    private String creatorUserName;
    private String creatorUserPhone;
    private String teamPhone;
    private Date createDate;
    private String description;
    private boolean isDeleted;
    private String headImg;
    private String address;

    @Id
    @Column(name = "ID", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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
    @Column(name = "CreatorID", nullable = true)
    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }

    @Basic
    @Column(name = "CreatorUserName", nullable = true, length = 20)
    public String getCreatorUserName() {
        return creatorUserName;
    }

    public void setCreatorUserName(String creatorUserName) {
        this.creatorUserName = creatorUserName;
    }

    @Basic
    @Column(name = "CreatorUserPhone", nullable = false, length = 20)
    public String getCreatorUserPhone() {
        return creatorUserPhone;
    }

    public void setCreatorUserPhone(String creatorUserPhone) {
        this.creatorUserPhone = creatorUserPhone;
    }

    @Basic
    @Column(name = "TeamPhone", nullable = false, length = 20)
    public String getTeamPhone() {
        return teamPhone;
    }

    public void setTeamPhone(String teamPhone) {
        this.teamPhone = teamPhone;
    }

    @Basic
    @Column(name = "CreateDate", nullable = false)
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
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
    @Column(name = "IsDeleted", nullable = false)
    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Basic
    @Column(name = "HeadImg", nullable = true, length = 100)
    public String getHeadImg() {
        return headImg;
    }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }

    @Basic
    @Column(name = "Address", nullable = true, length = 100)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ViewTeamDetailEntity that = (ViewTeamDetailEntity) o;

        if (id != that.id) return false;
        if (isDeleted != that.isDeleted) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (creatorId != null ? !creatorId.equals(that.creatorId) : that.creatorId != null) return false;
        if (creatorUserName != null ? !creatorUserName.equals(that.creatorUserName) : that.creatorUserName != null)
            return false;
        if (creatorUserPhone != null ? !creatorUserPhone.equals(that.creatorUserPhone) : that.creatorUserPhone != null)
            return false;
        if (teamPhone != null ? !teamPhone.equals(that.teamPhone) : that.teamPhone != null) return false;
        if (createDate != null ? !createDate.equals(that.createDate) : that.createDate != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;
        if (headImg != null ? !headImg.equals(that.headImg) : that.headImg != null) return false;
        if (address != null ? !address.equals(that.address) : that.address != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (creatorId != null ? creatorId.hashCode() : 0);
        result = 31 * result + (creatorUserName != null ? creatorUserName.hashCode() : 0);
        result = 31 * result + (creatorUserPhone != null ? creatorUserPhone.hashCode() : 0);
        result = 31 * result + (teamPhone != null ? teamPhone.hashCode() : 0);
        result = 31 * result + (createDate != null ? createDate.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (isDeleted ? 1 : 0);
        result = 31 * result + (headImg != null ? headImg.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        return result;
    }
}
