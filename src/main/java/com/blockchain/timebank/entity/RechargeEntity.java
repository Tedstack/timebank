package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "recharge", schema = "mydb", catalog = "")
public class RechargeEntity {
    private long id;
    private long userId;
    private String name;
    private String openId;
    private double timeCoin;
    private double totalAmount;
    private Date rechargeDate;
    private Date payDate;
    private String rechargeStatus;
    private String uuid;
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
    @Column(name = "userID", nullable = false)
    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "Name", nullable = true, length = 20)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "OpenID", nullable = true, length = 50)
    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    @Basic
    @Column(name = "TimeCoin", nullable = false, precision = 0)
    public double getTimeCoin() {
        return timeCoin;
    }

    public void setTimeCoin(double timeCoin) {
        this.timeCoin = timeCoin;
    }

    @Basic
    @Column(name = "TotalAmount", nullable = false, precision = 0)
    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Basic
    @Column(name = "RechargeDate", nullable = true)
    public Date getRechargeDate() {
        return rechargeDate;
    }

    public void setRechargeDate(Date rechargeDate) {
        this.rechargeDate = rechargeDate;
    }

    @Basic
    @Column(name = "PayDate", nullable = true)
    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    @Basic
    @Column(name = "RechargeStatus", nullable = true, length = 20)
    public String getRechargeStatus() {
        return rechargeStatus;
    }

    public void setRechargeStatus(String rechargeStatus) {
        this.rechargeStatus = rechargeStatus;
    }

    @Basic
    @Column(name = "UUID", nullable = true, length = 50)
    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
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

        RechargeEntity that = (RechargeEntity) o;

        if (id != that.id) return false;
        if (userId != that.userId) return false;
        if (Double.compare(that.timeCoin, timeCoin) != 0) return false;
        if (Double.compare(that.totalAmount, totalAmount) != 0) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (openId != null ? !openId.equals(that.openId) : that.openId != null) return false;
        if (rechargeDate != null ? !rechargeDate.equals(that.rechargeDate) : that.rechargeDate != null) return false;
        if (payDate != null ? !payDate.equals(that.payDate) : that.payDate != null) return false;
        if (rechargeStatus != null ? !rechargeStatus.equals(that.rechargeStatus) : that.rechargeStatus != null)
            return false;
        if (uuid != null ? !uuid.equals(that.uuid) : that.uuid != null) return false;
        if (extra != null ? !extra.equals(that.extra) : that.extra != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (openId != null ? openId.hashCode() : 0);
        temp = Double.doubleToLongBits(timeCoin);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(totalAmount);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (rechargeDate != null ? rechargeDate.hashCode() : 0);
        result = 31 * result + (payDate != null ? payDate.hashCode() : 0);
        result = 31 * result + (rechargeStatus != null ? rechargeStatus.hashCode() : 0);
        result = 31 * result + (uuid != null ? uuid.hashCode() : 0);
        result = 31 * result + (extra != null ? extra.hashCode() : 0);
        return result;
    }
}
