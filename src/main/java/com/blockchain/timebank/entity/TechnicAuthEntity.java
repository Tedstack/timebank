package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "technicAuth", schema = "mydb", catalog = "")
public class TechnicAuthEntity {
    private long id;
    private Long userId;
    private long authId;
    private String techName;
    private String techLevel;
    private String techId;
    private String techPhoto1;
    private String techPhoto2;
    private String techPhoto3;
    private boolean isVerified;
    private boolean isDeleted;
    private Timestamp validBeginDate;
    private Timestamp validEndDate;
    private boolean outDated;
    private Timestamp uploadDate;
    private Timestamp authDate;
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
    @Column(name = "UserID", nullable = true)
    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "AuthID", nullable = false)
    public long getAuthId() {
        return authId;
    }

    public void setAuthId(long authId) {
        this.authId = authId;
    }

    @Basic
    @Column(name = "TechName", nullable = false, length = 40)
    public String getTechName() {
        return techName;
    }

    public void setTechName(String techName) {
        this.techName = techName;
    }

    @Basic
    @Column(name = "TechLevel", nullable = false, length = 40)
    public String getTechLevel() {
        return techLevel;
    }

    public void setTechLevel(String techLevel) {
        this.techLevel = techLevel;
    }

    @Basic
    @Column(name = "TechID", nullable = false, length = 40)
    public String getTechId() {
        return techId;
    }

    public void setTechId(String techId) {
        this.techId = techId;
    }

    @Basic
    @Column(name = "TechPhoto1", nullable = true, length = 40)
    public String getTechPhoto1() {
        return techPhoto1;
    }

    public void setTechPhoto1(String techPhoto1) {
        this.techPhoto1 = techPhoto1;
    }

    @Basic
    @Column(name = "TechPhoto2", nullable = true, length = 40)
    public String getTechPhoto2() {
        return techPhoto2;
    }

    public void setTechPhoto2(String techPhoto2) {
        this.techPhoto2 = techPhoto2;
    }

    @Basic
    @Column(name = "TechPhoto3", nullable = true, length = 40)
    public String getTechPhoto3() {
        return techPhoto3;
    }

    public void setTechPhoto3(String techPhoto3) {
        this.techPhoto3 = techPhoto3;
    }

    @Basic
    @Column(name = "IsVerified", nullable = false)
    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    @Basic
    @Column(name = "IsDeleted", nullable = false)
    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }

    @Basic
    @Column(name = "ValidBeginDate", nullable = true)
    public Timestamp getValidBeginDate() {
        return validBeginDate;
    }

    public void setValidBeginDate(Timestamp validBeginDate) {
        this.validBeginDate = validBeginDate;
    }

    @Basic
    @Column(name = "ValidEndDate", nullable = true)
    public Timestamp getValidEndDate() {
        return validEndDate;
    }

    public void setValidEndDate(Timestamp validEndDate) {
        this.validEndDate = validEndDate;
    }

    @Basic
    @Column(name = "OutDated", nullable = false)
    public boolean isOutDated() {
        return outDated;
    }

    public void setOutDated(boolean outDated) {
        this.outDated = outDated;
    }

    @Basic
    @Column(name = "UploadDate", nullable = false)
    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }

    @Basic
    @Column(name = "AuthDate", nullable = true)
    public Timestamp getAuthDate() {
        return authDate;
    }

    public void setAuthDate(Timestamp authDate) {
        this.authDate = authDate;
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

        TechnicAuthEntity that = (TechnicAuthEntity) o;

        if (id != that.id) return false;
        if (authId != that.authId) return false;
        if (isVerified != that.isVerified) return false;
        if (isDeleted != that.isDeleted) return false;
        if (outDated != that.outDated) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;
        if (techName != null ? !techName.equals(that.techName) : that.techName != null) return false;
        if (techLevel != null ? !techLevel.equals(that.techLevel) : that.techLevel != null) return false;
        if (techId != null ? !techId.equals(that.techId) : that.techId != null) return false;
        if (techPhoto1 != null ? !techPhoto1.equals(that.techPhoto1) : that.techPhoto1 != null) return false;
        if (techPhoto2 != null ? !techPhoto2.equals(that.techPhoto2) : that.techPhoto2 != null) return false;
        if (techPhoto3 != null ? !techPhoto3.equals(that.techPhoto3) : that.techPhoto3 != null) return false;
        if (validBeginDate != null ? !validBeginDate.equals(that.validBeginDate) : that.validBeginDate != null)
            return false;
        if (validEndDate != null ? !validEndDate.equals(that.validEndDate) : that.validEndDate != null) return false;
        if (uploadDate != null ? !uploadDate.equals(that.uploadDate) : that.uploadDate != null) return false;
        if (authDate != null ? !authDate.equals(that.authDate) : that.authDate != null) return false;
        if (extra != null ? !extra.equals(that.extra) : that.extra != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (int) (authId ^ (authId >>> 32));
        result = 31 * result + (techName != null ? techName.hashCode() : 0);
        result = 31 * result + (techLevel != null ? techLevel.hashCode() : 0);
        result = 31 * result + (techId != null ? techId.hashCode() : 0);
        result = 31 * result + (techPhoto1 != null ? techPhoto1.hashCode() : 0);
        result = 31 * result + (techPhoto2 != null ? techPhoto2.hashCode() : 0);
        result = 31 * result + (techPhoto3 != null ? techPhoto3.hashCode() : 0);
        result = 31 * result + (isVerified ? 1 : 0);
        result = 31 * result + (isDeleted ? 1 : 0);
        result = 31 * result + (validBeginDate != null ? validBeginDate.hashCode() : 0);
        result = 31 * result + (validEndDate != null ? validEndDate.hashCode() : 0);
        result = 31 * result + (outDated ? 1 : 0);
        result = 31 * result + (uploadDate != null ? uploadDate.hashCode() : 0);
        result = 31 * result + (authDate != null ? authDate.hashCode() : 0);
        result = 31 * result + (extra != null ? extra.hashCode() : 0);
        return result;
    }
}
