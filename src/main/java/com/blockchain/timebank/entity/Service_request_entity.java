package com.blockchain.timebank.entity;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Service_request_entity {
    private String clarify;
    private long id;
    private long NeedUserid;
    private String NeedUsername;
    private long ServiceUserid;
    private String ServiceUserName;
    private String service_name;
    private String service_type;
    private Integer rate;
    private String comment;
    private Timestamp ActualBeginTime;
    private Timestamp ActualEndTime;
    private String orderid;
    private BigDecimal paymoney;

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public BigDecimal getPaymoney() {

        return paymoney;
    }

    public void setPaymoney(BigDecimal paymoney) {
        this.paymoney = paymoney;
    }

    public Integer getRate() {
        return rate;
    }

    public void setRate(Integer rate) {
        this.rate = rate;
    }

    public long getNeedUserid() {
        return NeedUserid;
    }

    public void setNeedUserid(long needUserid) {
        NeedUserid = needUserid;
    }

    public String getNeedUsername() {
        return NeedUsername;
    }

    public void setNeedUsername(String needUsername) {
        NeedUsername = needUsername;
    }

    public String getClarify() {
        return clarify;
    }

    public void setClarify(String clarify) {
        this.clarify = clarify;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getServiceUserid() {
        return ServiceUserid;
    }

    public void setServiceUserid(long serviceUserid) {
        ServiceUserid = serviceUserid;
    }

    public String getServiceUserName() {
        return ServiceUserName;
    }

    public void setServiceUserName(String serviceUserName) {
        ServiceUserName = serviceUserName;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public String getService_type() {
        return service_type;
    }

    public void setService_type(String service_type) {
        this.service_type = service_type;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Timestamp getActualBeginTime() {
        return ActualBeginTime;
    }

    public void setActualBeginTime(Timestamp actualBeginTime) {
        ActualBeginTime = actualBeginTime;
    }

    public Timestamp getActualEndTime() {
        return ActualEndTime;
    }

    public void setActualEndTime(Timestamp actualEndTime) {
        ActualEndTime = actualEndTime;
    }
}
