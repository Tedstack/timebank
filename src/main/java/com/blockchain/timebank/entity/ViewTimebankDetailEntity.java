package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "view_timebank_detail", schema = "mydb", catalog = "")
public class ViewTimebankDetailEntity {
    private long id;
    private String type;
    private double total;
    private Timestamp createTime;
    private long createUserId;
    private String description;
    private String reason;
    private String createUserName;

    @Id
    @Column(name = "ID", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "Type", nullable = false, length = 30)
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Basic
    @Column(name = "Total", nullable = false, precision = 0)
    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    @Basic
    @Column(name = "CreateTime", nullable = true)
    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    @Basic
    @Column(name = "CreateUserID", nullable = false)
    public long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(long createUserId) {
        this.createUserId = createUserId;
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
    @Column(name = "Reason", nullable = true, length = 200)
    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @Basic
    @Column(name = "CreateUserName", nullable = false, length = 20)
    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ViewTimebankDetailEntity that = (ViewTimebankDetailEntity) o;

        if (id != that.id) return false;
        if (Double.compare(that.total, total) != 0) return false;
        if (createUserId != that.createUserId) return false;
        if (type != null ? !type.equals(that.type) : that.type != null) return false;
        if (createTime != null ? !createTime.equals(that.createTime) : that.createTime != null) return false;
        if (description != null ? !description.equals(that.description) : that.description != null) return false;
        if (reason != null ? !reason.equals(that.reason) : that.reason != null) return false;
        if (createUserName != null ? !createUserName.equals(that.createUserName) : that.createUserName != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = (int) (id ^ (id >>> 32));
        result = 31 * result + (type != null ? type.hashCode() : 0);
        temp = Double.doubleToLongBits(total);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        result = 31 * result + (int) (createUserId ^ (createUserId >>> 32));
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (reason != null ? reason.hashCode() : 0);
        result = 31 * result + (createUserName != null ? createUserName.hashCode() : 0);
        return result;
    }
}
