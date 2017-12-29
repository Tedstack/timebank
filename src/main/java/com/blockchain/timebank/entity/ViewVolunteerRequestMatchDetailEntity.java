package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "view_volunteer_request_match_detail", schema = "mydb", catalog = "")
public class ViewVolunteerRequestMatchDetailEntity {
    private Long id;
    private Long applyUserId;
    private String applyUserName;
    private String applyUserPhone;
    private String address;
    private Timestamp beginTime;
    private Timestamp endTime;
    private Timestamp actualBeginTime;
    private Timestamp actualEndTime;
    private Integer payWay;
    private BigDecimal payMoney;
    private String status;
    private Long requestId;
    private BigDecimal requestPrice;
    private Long serviceId;
    private String serviceType;
    private String serviceName;
    private Long requestUserId;
    private String requestUserName;
    private String requestUserPhone;
    private Integer rate;
    private String comment;

    @Id
    @Column(name = "ID", nullable = false)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "ApplyUserID", nullable = false)
    public Long getApplyUserId() {
        return applyUserId;
    }

    public void setApplyUserId(Long applyUserId) {
        this.applyUserId = applyUserId;
    }

    @Basic
    @Column(name = "ApplyUserName", nullable = true, length = 20)
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
    @Column(name = "Address", nullable = false, length = 300)
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
    public Integer getPayWay() {
        return payWay;
    }

    public void setPayWay(Integer payWay) {
        this.payWay = payWay;
    }

    @Basic
    @Column(name = "PayMoney", nullable = true, precision = 2)
    public BigDecimal getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(BigDecimal payMoney) {
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
    @Column(name = "RequestID", nullable = false)
    public Long getRequestId() {
        return requestId;
    }

    public void setRequestId(Long requestId) {
        this.requestId = requestId;
    }

    @Basic
    @Column(name = "RequestPrice", nullable = true, precision = 2)
    public BigDecimal getRequestPrice() {
        return requestPrice;
    }

    public void setRequestPrice(BigDecimal requestPrice) {
        this.requestPrice = requestPrice;
    }

    @Basic
    @Column(name = "ServiceID", nullable = false)
    public Long getServiceId() {
        return serviceId;
    }

    public void setServiceId(Long serviceId) {
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
    @Column(name = "RequestUserID", nullable = false)
    public Long getRequestUserId() {
        return requestUserId;
    }

    public void setRequestUserId(Long requestUserId) {
        this.requestUserId = requestUserId;
    }

    @Basic
    @Column(name = "RequestUserName", nullable = true, length = 20)
    public String getRequestUserName() {
        return requestUserName;
    }

    public void setRequestUserName(String requestUserName) {
        this.requestUserName = requestUserName;
    }

    @Basic
    @Column(name = "RequestUserPhone", nullable = false, length = 20)
    public String getRequestUserPhone() {
        return requestUserPhone;
    }

    public void setRequestUserPhone(String requestUserPhone) {
        this.requestUserPhone = requestUserPhone;
    }

    @Basic
    @Column(name = "Rate", nullable = true)
    public Integer getRate() {
        return rate;
    }

    public void setRate(Integer rate) {
        this.rate = rate;
    }

    @Basic
    @Column(name = "Comment", nullable = true, length = 100)
    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ViewVolunteerRequestMatchDetailEntity that = (ViewVolunteerRequestMatchDetailEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (applyUserId != null ? !applyUserId.equals(that.applyUserId) : that.applyUserId != null) return false;
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
        if (payWay != null ? !payWay.equals(that.payWay) : that.payWay != null) return false;
        if (payMoney != null ? !payMoney.equals(that.payMoney) : that.payMoney != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (requestId != null ? !requestId.equals(that.requestId) : that.requestId != null) return false;
        if (requestPrice != null ? !requestPrice.equals(that.requestPrice) : that.requestPrice != null) return false;
        if (serviceId != null ? !serviceId.equals(that.serviceId) : that.serviceId != null) return false;
        if (serviceType != null ? !serviceType.equals(that.serviceType) : that.serviceType != null) return false;
        if (serviceName != null ? !serviceName.equals(that.serviceName) : that.serviceName != null) return false;
        if (requestUserId != null ? !requestUserId.equals(that.requestUserId) : that.requestUserId != null)
            return false;
        if (requestUserName != null ? !requestUserName.equals(that.requestUserName) : that.requestUserName != null)
            return false;
        if (requestUserPhone != null ? !requestUserPhone.equals(that.requestUserPhone) : that.requestUserPhone != null)
            return false;
        if (rate != null ? !rate.equals(that.rate) : that.rate != null) return false;
        if (comment != null ? !comment.equals(that.comment) : that.comment != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (applyUserId != null ? applyUserId.hashCode() : 0);
        result = 31 * result + (applyUserName != null ? applyUserName.hashCode() : 0);
        result = 31 * result + (applyUserPhone != null ? applyUserPhone.hashCode() : 0);
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (beginTime != null ? beginTime.hashCode() : 0);
        result = 31 * result + (endTime != null ? endTime.hashCode() : 0);
        result = 31 * result + (actualBeginTime != null ? actualBeginTime.hashCode() : 0);
        result = 31 * result + (actualEndTime != null ? actualEndTime.hashCode() : 0);
        result = 31 * result + (payWay != null ? payWay.hashCode() : 0);
        result = 31 * result + (payMoney != null ? payMoney.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (requestId != null ? requestId.hashCode() : 0);
        result = 31 * result + (requestPrice != null ? requestPrice.hashCode() : 0);
        result = 31 * result + (serviceId != null ? serviceId.hashCode() : 0);
        result = 31 * result + (serviceType != null ? serviceType.hashCode() : 0);
        result = 31 * result + (serviceName != null ? serviceName.hashCode() : 0);
        result = 31 * result + (requestUserId != null ? requestUserId.hashCode() : 0);
        result = 31 * result + (requestUserName != null ? requestUserName.hashCode() : 0);
        result = 31 * result + (requestUserPhone != null ? requestUserPhone.hashCode() : 0);
        result = 31 * result + (rate != null ? rate.hashCode() : 0);
        result = 31 * result + (comment != null ? comment.hashCode() : 0);
        return result;
    }
}
