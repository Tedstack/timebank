package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "view_record_detail", schema = "mydb", catalog = "")
public class ViewRecordDetailEntity {
    private long id;
    private long applyUserId;
    private String applyUserName;
    private String applyUserPhone;
    private String address;
    private Timestamp beginTime;
    private Timestamp endTime;
    private Timestamp actualBeginTime;
    private Timestamp actualEndTime;
    private int payWay;
    private Double payMoney;
    private String status;
    private long publishId;
    private double publishPrice;
    private long serviceId;
    private String serviceType;
    private String serviceName;
    private long serviceUserId;
    private String serviceUserName;
    private String serviceUserPhone;

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
    @Column(name = "Address", nullable = false, length = 100)
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
    @Column(name = "PayWay", nullable = false)
    public int getPayWay() {
        return payWay;
    }

    public void setPayWay(int payWay) {
        this.payWay = payWay;
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

    @Basic
    @Column(name = "PublishID", nullable = false)
    public long getPublishId() {
        return publishId;
    }

    public void setPublishId(long publishId) {
        this.publishId = publishId;
    }

    @Basic
    @Column(name = "PublishPrice", nullable = false, precision = 0)
    public double getPublishPrice() {
        return publishPrice;
    }

    public void setPublishPrice(double publishPrice) {
        this.publishPrice = publishPrice;
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
    @Column(name = "ServiceType", nullable = false, length = 45)
    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    @Basic
    @Column(name = "ServiceName", nullable = false, length = 45)
    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
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
    @Column(name = "ServiceUserName", nullable = true, length = 20)
    public String getServiceUserName() {
        return serviceUserName;
    }

    public void setServiceUserName(String serviceUserName) {
        this.serviceUserName = serviceUserName;
    }

    @Basic
    @Column(name = "ServiceUserPhone", nullable = false, length = 20)
    public String getServiceUserPhone() {
        return serviceUserPhone;
    }

    public void setServiceUserPhone(String serviceUserPhone) {
        this.serviceUserPhone = serviceUserPhone;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ViewRecordDetailEntity that = (ViewRecordDetailEntity) o;

        if (id != that.id) return false;
        if (applyUserId != that.applyUserId) return false;
        if (payWay != that.payWay) return false;
        if (publishId != that.publishId) return false;
        if (Double.compare(that.publishPrice, publishPrice) != 0) return false;
        if (serviceId != that.serviceId) return false;
        if (serviceUserId != that.serviceUserId) return false;
        if (applyUserName != null ? !applyUserName.equals(that.applyUserName) : that.applyUserName != null)
            return false;
        if (applyUserPhone != null ? !applyUserPhone.equals(that.applyUserPhone) : that.applyUserPhone != null)
            return false;
        if (address != null ? !address.equals(that.address) : that.address != null) return false;
        if (beginTime != null ? !beginTime.equals(that.beginTime) : that.beginTime != null) return false;
        if (endTime != null ? !endTime.equals(that.endTime) : that.endTime != null) return false;
        if (actualBeginTime != null ? !actualBeginTime.equals(that.actualBeginTime) : that.actualBeginTime != null)
            return false;
        if (actualEndTime != null ? !actualEndTime.equals(that.actualEndTime) : that.actualEndTime != null)
            return false;
        if (payMoney != null ? !payMoney.equals(that.payMoney) : that.payMoney != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (serviceType != null ? !serviceType.equals(that.serviceType) : that.serviceType != null) return false;
        if (serviceName != null ? !serviceName.equals(that.serviceName) : that.serviceName != null) return false;
        if (serviceUserName != null ? !serviceUserName.equals(that.serviceUserName) : that.serviceUserName != null)
            return false;
        if (serviceUserPhone != null ? !serviceUserPhone.equals(that.serviceUserPhone) : that.serviceUserPhone != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = (int) (id ^ (id >>> 32));
        result = 31 * result + (int) (applyUserId ^ (applyUserId >>> 32));
        result = 31 * result + (applyUserName != null ? applyUserName.hashCode() : 0);
        result = 31 * result + (applyUserPhone != null ? applyUserPhone.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (beginTime != null ? beginTime.hashCode() : 0);
        result = 31 * result + (endTime != null ? endTime.hashCode() : 0);
        result = 31 * result + (actualBeginTime != null ? actualBeginTime.hashCode() : 0);
        result = 31 * result + (actualEndTime != null ? actualEndTime.hashCode() : 0);
        result = 31 * result + payWay;
        result = 31 * result + (payMoney != null ? payMoney.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (int) (publishId ^ (publishId >>> 32));
        temp = Double.doubleToLongBits(publishPrice);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (int) (serviceId ^ (serviceId >>> 32));
        result = 31 * result + (serviceType != null ? serviceType.hashCode() : 0);
        result = 31 * result + (serviceName != null ? serviceName.hashCode() : 0);
        result = 31 * result + (int) (serviceUserId ^ (serviceUserId >>> 32));
        result = 31 * result + (serviceUserName != null ? serviceUserName.hashCode() : 0);
        result = 31 * result + (serviceUserPhone != null ? serviceUserPhone.hashCode() : 0);
        return result;
    }
}
