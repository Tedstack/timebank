package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "view_team_detail", schema = "mydb", catalog = "")
public class ViewTeamDetailEntity {
    private long id;
    private String name;
    private long managerUserId;
    private String managerUserName;
    private String managerUserPhone;
    private Date createDate;
    private String description;

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
    @Column(name = "ManagerUserID", nullable = false)
    public long getManagerUserId() {
        return managerUserId;
    }

    public void setManagerUserId(long managerUserId) {
        this.managerUserId = managerUserId;
    }

    @Basic
    @Column(name = "ManagerUserName", nullable = true, length = 20)
    public String getManagerUserName() {
        return managerUserName;
    }

    public void setManagerUserName(String managerUserName) {
        this.managerUserName = managerUserName;
    }

    @Basic
    @Column(name = "ManagerUserPhone", nullable = false, length = 20)
    public String getManagerUserPhone() {
        return managerUserPhone;
    }

    public void setManagerUserPhone(String managerUserPhone) {
        this.managerUserPhone = managerUserPhone;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ViewTeamDetailEntity that = (ViewTeamDetailEntity) o;

        if (id != that.id) return false;
        if (managerUserId != that.managerUserId) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (managerUserName != null ? !managerUserName.equals(that.managerUserName) : that.managerUserName != null)
            return false;
        if (managerUserPhone != null ? !managerUserPhone.equals(that.managerUserPhone) : that.managerUserPhone != null)
            return false;
        if (createDate != null ? !createDate.equals(that.createDate) : that.createDate != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (int) (managerUserId ^ (managerUserId >>> 32));
        result = 31 * result + (managerUserName != null ? managerUserName.hashCode() : 0);
        result = 31 * result + (managerUserPhone != null ? managerUserPhone.hashCode() : 0);
        result = 31 * result + (createDate != null ? createDate.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        return result;
    }
}
