package com.blockchain.timebank.entity;

import javax.persistence.*;

@Entity
@Table(name = "timeaccount", schema = "mydb", catalog = "")
public class TimeaccountEntity {
    private long id;
    private long userId;
    private long serviceId;
    private double timeAccount;

    @Id
    @Column(name = "ID", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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
    @Column(name = "ServiceID", nullable = false)
    public long getServiceId() {
        return serviceId;
    }

    public void setServiceId(long serviceId) {
        this.serviceId = serviceId;
    }

    @Basic
    @Column(name = "TimeAccount", nullable = false, precision = 0)
    public double getTimeAccount() {
        return timeAccount;
    }

    public void setTimeAccount(double timeAccount) {
        this.timeAccount = timeAccount;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TimeaccountEntity that = (TimeaccountEntity) o;

        if (id != that.id) return false;
        if (userId != that.userId) return false;
        if (serviceId != that.serviceId) return false;
        if (Double.compare(that.timeAccount, timeAccount) != 0) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (userId ^ (userId >>> 32));
        result = 31 * result + (int) (serviceId ^ (serviceId >>> 32));
        temp = Double.doubleToLongBits(timeAccount);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        return result;
    }
}
