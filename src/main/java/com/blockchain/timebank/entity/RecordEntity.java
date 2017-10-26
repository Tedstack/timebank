package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "record", schema = "mydb", catalog = "")
public class RecordEntity {
    private long id;
    private long applyUserId;
    private long serviceUserId;
    private long publishId;
    private String applyAddress;
    private String applyUserName;
    private String applyUserPhone;
    private int payWay;
    private Timestamp beginTime;
    private Timestamp endTime;
    private Timestamp actualBeginTime;
    private Timestamp actualEndTime;
    private Double payMoney;
    private String status;

    @Id
    @Column(name = "ID", nullable = false)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "ApplyUserID", nullable = false)
    public long getApplyUserId() {
        return applyUserId;
    }

    public void setApplyUserId(long applyUserId) {
        this.applyUserId = applyUserId;
    }

    @Basic
    @Column(name = "ServiceUserID", nullable = false)
    public long getServiceUserId() {
        return serviceUserId;
    }

    public void setServiceUserId(long serviceUserId) {
        this.serviceUserId = serviceUserId;
    }

    @Basic
    @Column(name = "PublishID", nullable = false)
    public long getPublishId() {
        return publishId;
    }

    public void setPublishId(long publishId) {
        this.publishId = publishId;
    }

    @Basic
    @Column(name = "ApplyAddress", nullable = false, length = 100)
    public String getApplyAddress() {
        return applyAddress;
    }

    public void setApplyAddress(String applyAddress) {
        this.applyAddress = applyAddress;
    }

    @Basic
    @Column(name = "ApplyUserName", nullable = false, length = 20)
    public String getApplyUserName() {
        return applyUserName;
    }

    public void setApplyUserName(String applyUserName) {
        this.applyUserName = applyUserName;
    }

    @Basic
    @Column(name = "ApplyUserPhone", nullable = false, length = 20)
    public String getApplyUserPhone() {
        return applyUserPhone;
    }

    public void setApplyUserPhone(String applyUserPhone) {
        this.applyUserPhone = applyUserPhone;
    }

    @Basic
    @Column(name = "PayWay", nullable = false)
    public int getPayWay() {
        return payWay;
    }

    public void setPayWay(int payWay) {
        this.payWay = payWay;
    }

    @Basic
    @Column(name = "BeginTime", nullable = true)
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
    @Column(name = "ActualBeginTime", nullable = true)
    public Timestamp getActualBeginTime() {
        return actualBeginTime;
    }

    public void setActualBeginTime(Timestamp actualBeginTime) {
        this.actualBeginTime = actualBeginTime;
    }

    @Basic
    @Column(name = "ActualEndTime", nullable = true)
    public Timestamp getActualEndTime() {
        return actualEndTime;
    }

    public void setActualEndTime(Timestamp actualEndTime) {
        this.actualEndTime = actualEndTime;
    }

    @Basic
    @Column(name = "PayMoney", nullable = true, precision = 0)
    public Double getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(Double payMoney) {
        this.payMoney = payMoney;
    }

    @Basic
    @Column(name = "Status", nullable = false, length = 50)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RecordEntity that = (RecordEntity) o;

        if (id != that.id) return false;
        if (applyUserId != that.applyUserId) return false;
        if (serviceUserId != that.serviceUserId) return false;
        if (publishId != that.publishId) return false;
        if (payWay != that.payWay) return false;
        if (applyAddress != null ? !applyAddress.equals(that.applyAddress) : that.applyAddress != null) return false;
        if (applyUserName != null ? !applyUserName.equals(that.applyUserName) : that.applyUserName != null)
            return false;
        if (applyUserPhone != null ? !applyUserPhone.equals(that.applyUserPhone) : that.applyUserPhone != null)
            return false;
        if (beginTime != null ? !beginTime.equals(that.beginTime) : that.beginTime != null) return false;
        if (endTime != null ? !endTime.equals(that.endTime) : that.endTime != null) return false;
        if (actualBeginTime != null ? !actualBeginTime.equals(that.actualBeginTime) : that.actualBeginTime != null)
            return false;
        if (actualEndTime != null ? !actualEndTime.equals(that.actualEndTime) : that.actualEndTime != null)
            return false;
        if (payMoney != null ? !payMoney.equals(that.payMoney) : that.payMoney != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (applyUserId ^ (applyUserId >>> 32));
        result = 31 * result + (int) (serviceUserId ^ (serviceUserId >>> 32));
        result = 31 * result + (int) (publishId ^ (publishId >>> 32));
        result = 31 * result + (applyAddress != null ? applyAddress.hashCode() : 0);
        result = 31 * result + (applyUserName != null ? applyUserName.hashCode() : 0);
        result = 31 * result + (applyUserPhone != null ? applyUserPhone.hashCode() : 0);
        result = 31 * result + payWay;
        result = 31 * result + (beginTime != null ? beginTime.hashCode() : 0);
        result = 31 * result + (endTime != null ? endTime.hashCode() : 0);
        result = 31 * result + (actualBeginTime != null ? actualBeginTime.hashCode() : 0);
        result = 31 * result + (actualEndTime != null ? actualEndTime.hashCode() : 0);
        result = 31 * result + (payMoney != null ? payMoney.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }
}
