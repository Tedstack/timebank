package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "rechargeUser", schema = "mydb", catalog = "")
public class RechargeUserEntity {
    private long id;
    private long timebankId;
    private double rechargeValue;
    private Timestamp rechargeTime;
    private long operatorId;
    private long userId;
    private String reason;
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
    @Column(name = "TimebankID", nullable = false)
    public long getTimebankId() {
        return timebankId;
    }

    public void setTimebankId(long timebankId) {
        this.timebankId = timebankId;
    }

    @Basic
    @Column(name = "RechargeValue", nullable = false, precision = 0)
    public double getRechargeValue() {
        return rechargeValue;
    }

    public void setRechargeValue(double rechargeValue) {
        this.rechargeValue = rechargeValue;
    }

    @Basic
    @Column(name = "RechargeTime", nullable = true)
    public Timestamp getRechargeTime() {
        return rechargeTime;
    }

    public void setRechargeTime(Timestamp rechargeTime) {
        this.rechargeTime = rechargeTime;
    }

    @Basic
    @Column(name = "OperatorID", nullable = false)
    public long getOperatorId() {
        return operatorId;
    }

    public void setOperatorId(long operatorId) {
        this.operatorId = operatorId;
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
    @Column(name = "Reason", nullable = true, length = 200)
    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

        RechargeUserEntity that = (RechargeUserEntity) o;

        if (id != that.id) return false;
        if (timebankId != that.timebankId) return false;
        if (Double.compare(that.rechargeValue, rechargeValue) != 0) return false;
        if (operatorId != that.operatorId) return false;
        if (userId != that.userId) return false;
        if (rechargeTime != null ? !rechargeTime.equals(that.rechargeTime) : that.rechargeTime != null) return false;
        if (reason != null ? !reason.equals(that.reason) : that.reason != null) return false;
        if (extra != null ? !extra.equals(that.extra) : that.extra != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (timebankId ^ (timebankId >>> 32));
        temp = Double.doubleToLongBits(rechargeValue);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (rechargeTime != null ? rechargeTime.hashCode() : 0);
        result = 31 * result + (int) (operatorId ^ (operatorId >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (reason != null ? reason.hashCode() : 0);
        result = 31 * result + (extra != null ? extra.hashCode() : 0);
        return result;
    }
}
