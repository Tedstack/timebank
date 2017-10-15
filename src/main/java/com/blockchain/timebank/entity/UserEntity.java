package com.blockchain.timebank.entity;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "user", schema = "mydb", catalog = "")
public class UserEntity {
    private int id;
    private String name;
    private String password;
    private String phone;
    private double timeCoin;
    private double timeVol;
    private Date registerDate;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "Name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "Password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "Phone")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Basic
    @Column(name = "TimeCoin")
    public double getTimeCoin() {
        return timeCoin;
    }

    public void setTimeCoin(double timeCoin) {
        this.timeCoin = timeCoin;
    }

    @Basic
    @Column(name = "TimeVol")
    public double getTimeVol() {
        return timeVol;
    }

    public void setTimeVol(double timeVol) {
        this.timeVol = timeVol;
    }

    @Basic
    @Column(name = "RegisterDate")
    public Date getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate) {
        this.registerDate = registerDate;
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

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (phone != null ? phone.hashCode() : 0);
        temp = Double.doubleToLongBits(timeCoin);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        temp = Double.doubleToLongBits(timeVol);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (registerDate != null ? registerDate.hashCode() : 0);
        return result;
    }
}
