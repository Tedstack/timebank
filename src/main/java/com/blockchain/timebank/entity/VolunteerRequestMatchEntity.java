package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "volunteerRequestMatch", schema = "mydb", catalog = "")
public class VolunteerRequestMatchEntity {
    private Long id;
    private Timestamp beginTime;
    private Timestamp endTime;
    private Timestamp actualBeginTime;
    private Timestamp actualEndTime;
    private BigDecimal payMoney;
    private Integer rate;
    private String comment;
    private String status;
    private String extra;

    @Id
    @Column(name = "ID", nullable = false)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
    @Column(name = "PayMoney", nullable = true, precision = 2)
    public BigDecimal getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(BigDecimal payMoney) {
        this.payMoney = payMoney;
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

    @Basic
    @Column(name = "Status", nullable = false, length = 50)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

        VolunteerRequestMatchEntity that = (VolunteerRequestMatchEntity) o;

        if (id != null ? !id.equals(that.id) : that.id != null) return false;
        if (beginTime != null ? !beginTime.equals(that.beginTime) : that.beginTime != null) return false;
        if (endTime != null ? !endTime.equals(that.endTime) : that.endTime != null) return false;
        if (actualBeginTime != null ? !actualBeginTime.equals(that.actualBeginTime) : that.actualBeginTime != null)
            return false;
        if (actualEndTime != null ? !actualEndTime.equals(that.actualEndTime) : that.actualEndTime != null)
            return false;
        if (payMoney != null ? !payMoney.equals(that.payMoney) : that.payMoney != null) return false;
        if (rate != null ? !rate.equals(that.rate) : that.rate != null) return false;
        if (comment != null ? !comment.equals(that.comment) : that.comment != null) return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;
        if (extra != null ? !extra.equals(that.extra) : that.extra != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (beginTime != null ? beginTime.hashCode() : 0);
        result = 31 * result + (endTime != null ? endTime.hashCode() : 0);
        result = 31 * result + (actualBeginTime != null ? actualBeginTime.hashCode() : 0);
        result = 31 * result + (actualEndTime != null ? actualEndTime.hashCode() : 0);
        result = 31 * result + (payMoney != null ? payMoney.hashCode() : 0);
        result = 31 * result + (rate != null ? rate.hashCode() : 0);
        result = 31 * result + (comment != null ? comment.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (extra != null ? extra.hashCode() : 0);
        return result;
    }
}
