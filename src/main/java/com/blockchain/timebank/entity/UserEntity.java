package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "user", schema = "mydb", catalog = "")
public class UserEntity {
    private long id;
    private String name;
    private String password;
    private String phone;
    private double timeCoin;
    private double timeVol;
    private Date registerDate;
    private String idCard;
    private String sex;
    private Date birth;
    private String qrCode;
    private String img1;
    private String img2;
    private Integer isVerify;
    private String openId;
    private String headImgUrl;
    private String country;
    private String province;
    private String city;
    private String remark;
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
    @Column(name = "Name", nullable = true, length = 20)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "Password", nullable = true, length = 45)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "Phone", nullable = false, length = 20)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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
    @Column(name = "TimeVol", nullable = false, precision = 0)
    public double getTimeVol() {
        return timeVol;
    }

    public void setTimeVol(double timeVol) {
        this.timeVol = timeVol;
    }

    @Basic
    @Column(name = "RegisterDate", nullable = true)
    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
    }

    @Basic
    @Column(name = "IDCard", nullable = true, length = 20)
    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    @Basic
    @Column(name = "Sex", nullable = true, length = 10)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Basic
    @Column(name = "Birth", nullable = true)
    public Date getBirth() {
        return birth;
    }

    public void setBirth(Date birth) {
        this.birth = birth;
    }

    @Basic
    @Column(name = "QRCode", nullable = true, length = 20)
    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
    }

    @Basic
    @Column(name = "img1", nullable = true, length = 50)
    public String getImg1() {
        return img1;
    }

    public void setImg1(String img1) {
        this.img1 = img1;
    }

    @Basic
    @Column(name = "img2", nullable = true, length = 50)
    public String getImg2() {
        return img2;
    }

    public void setImg2(String img2) {
        this.img2 = img2;
    }

    @Basic
    @Column(name = "IsVerify", nullable = true)
    public Integer getIsVerify() {
        return isVerify;
    }

    public void setIsVerify(Integer isVerify) {
        this.isVerify = isVerify;
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
    @Column(name = "HeadImgUrl", nullable = true, length = 255)
    public String getHeadImgUrl() {
        return headImgUrl;
    }

    public void setHeadImgUrl(String headImgUrl) {
        this.headImgUrl = headImgUrl;
    }

    @Basic
    @Column(name = "Country", nullable = true, length = 50)
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @Basic
    @Column(name = "Province", nullable = true, length = 50)
    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Basic
    @Column(name = "City", nullable = true, length = 50)
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Basic
    @Column(name = "Remark", nullable = true, length = 100)
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
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

        UserEntity that = (UserEntity) o;

        if (id != that.id) return false;
        if (Double.compare(that.timeCoin, timeCoin) != 0) return false;
        if (Double.compare(that.timeVol, timeVol) != 0) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        if (password != null ? !password.equals(that.password) : that.password != null) return false;
        if (phone != null ? !phone.equals(that.phone) : that.phone != null) return false;
        if (registerDate != null ? !registerDate.equals(that.registerDate) : that.registerDate != null) return false;
        if (idCard != null ? !idCard.equals(that.idCard) : that.idCard != null) return false;
        if (sex != null ? !sex.equals(that.sex) : that.sex != null) return false;
        if (birth != null ? !birth.equals(that.birth) : that.birth != null) return false;
        if (qrCode != null ? !qrCode.equals(that.qrCode) : that.qrCode != null) return false;
        if (img1 != null ? !img1.equals(that.img1) : that.img1 != null) return false;
        if (img2 != null ? !img2.equals(that.img2) : that.img2 != null) return false;
        if (isVerify != null ? !isVerify.equals(that.isVerify) : that.isVerify != null) return false;
        if (openId != null ? !openId.equals(that.openId) : that.openId != null) return false;
        if (headImgUrl != null ? !headImgUrl.equals(that.headImgUrl) : that.headImgUrl != null) return false;
        if (country != null ? !country.equals(that.country) : that.country != null) return false;
        if (province != null ? !province.equals(that.province) : that.province != null) return false;
        if (city != null ? !city.equals(that.city) : that.city != null) return false;
        if (remark != null ? !remark.equals(that.remark) : that.remark != null) return false;
        if (extra != null ? !extra.equals(that.extra) : that.extra != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = (int) (id ^ (id >>> 32));
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (phone != null ? phone.hashCode() : 0);
        temp = Double.doubleToLongBits(timeCoin);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(timeVol);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (registerDate != null ? registerDate.hashCode() : 0);
        result = 31 * result + (idCard != null ? idCard.hashCode() : 0);
        result = 31 * result + (sex != null ? sex.hashCode() : 0);
        result = 31 * result + (birth != null ? birth.hashCode() : 0);
        result = 31 * result + (qrCode != null ? qrCode.hashCode() : 0);
        result = 31 * result + (img1 != null ? img1.hashCode() : 0);
        result = 31 * result + (img2 != null ? img2.hashCode() : 0);
        result = 31 * result + (isVerify != null ? isVerify.hashCode() : 0);
        result = 31 * result + (openId != null ? openId.hashCode() : 0);
        result = 31 * result + (headImgUrl != null ? headImgUrl.hashCode() : 0);
        result = 31 * result + (country != null ? country.hashCode() : 0);
        result = 31 * result + (province != null ? province.hashCode() : 0);
        result = 31 * result + (city != null ? city.hashCode() : 0);
        result = 31 * result + (remark != null ? remark.hashCode() : 0);
        result = 31 * result + (extra != null ? extra.hashCode() : 0);
        return result;
    }
}
