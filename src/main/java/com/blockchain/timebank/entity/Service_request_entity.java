package com.blockchain.timebank.entity;

import com.blockchain.timebank.weixin.util.FormatOrderIdUtil;
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

    public static Service_request_entity set_service(ViewPublishOrderDetailEntity record){
        Service_request_entity service = new Service_request_entity();
        service.setClarify("service");
        service.setId(record.getId());
        service.setNeedUserid(record.getApplyUserId());
        service.setNeedUsername(record.getApplyUserName());
        service.setServiceUserid(record.getServiceUserId());
        service.setServiceUserName(record.getServiceUserName());
        service.setActualBeginTime(record.getActualBeginTime());
        service.setActualEndTime(record.getActualEndTime());
        service.setService_name(record.getServiceName());
        service.setService_type(record.getServiceType());
        service.setComment(record.getComment());
        service.setRate(record.getRating());
        BigDecimal money = BigDecimal.valueOf(Double.valueOf(record.getPayMoney()));
        service.setPaymoney(money);
        service.setOrderid(FormatOrderIdUtil.format(record.getCreateTime(),record.getId()));
        return service;
    }
    public static Service_request_entity set_request(ViewRequestOrderDetailEntity record){
        Service_request_entity request = new Service_request_entity();
        request.setClarify("request");
        request.setId(record.getId());
        request.setNeedUserid(record.getRequestUserId());
        request.setNeedUsername(record.getRequestUserName());
        request.setServiceUserid(record.getApplyUserId());
        request.setServiceUserName(record.getApplyUserName());
        request.setActualBeginTime(record.getActualBeginTime());
        request.setActualEndTime(record.getActualEndTime());
        request.setService_name(record.getServiceName());
        request.setService_type(record.getServiceType());
        request.setComment(record.getComment());
        request.setRate(record.getRate());
        request.setPaymoney(record.getPayMoney());
        request.setOrderid(FormatOrderIdUtil.format(record.getCreateTime(),record.getId()));
        return request;
    }

    public static Service_request_entity set_recharge(RechargeEntity record){
        Service_request_entity recharge = new Service_request_entity();
        recharge.setClarify("recharge");
        recharge.setId(record.getId());
        BigDecimal money = BigDecimal.valueOf(record.getTotalAmount());
        recharge.setPaymoney(money);
        recharge.setOrderid(record.getUuid());
        recharge.setComment(record.getRechargeStatus());
        recharge.setActualEndTime(record.getRechargeDate());
        return recharge;
    }
}
