package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserDao;
import com.blockchain.timebank.dao.UserUpdateDao;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.weixin.model.SNSUserInfo;
import com.blockchain.timebank.weixin.util.AdvancedUtil;
import com.blockchain.timebank.weixin.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserUpdateDao userUpdateDao;

    public UserEntity saveUserEntity(UserEntity userEntity) {
        return userDao.save(userEntity);
    }

    public UserEntity findUserEntityById(Long id) {
        return userDao.findOne(id);
    }

    public UserEntity findUserEntityByPhone(String phone) {
        return userDao.findUserEntityByPhone(phone);
    }

    public UserEntity findUserEntityByUserName(String userName) {
        return userDao.findUserEntityByName(userName);
    }

    public UserEntity findUserEntityByPhoneAndPassword(String phone, String password) {
        return userDao.findUserEntityByPhoneAndPassword(phone, password);
    }

    public UserEntity updateUserEntity(UserEntity userEntity) {
        return userDao.save(userEntity);
    }

    public void deleteById(Long id) {
        userDao.delete(id);
    }


    public List<UserEntity> findAll() {
        return (List<UserEntity>) userDao.findAll();
    }

    public UserEntity findUserEntityByQrCode(String qrCode) {
        return userDao.findUserEntityByQrCode(qrCode);
    }

    public UserEntity findUserEntityByIdCard(String idCard) {
        return userDao.findUserEntityByIdCard(idCard);
    }

    public UserEntity findUserEntityByOpenID(String openID) {
        return userDao.findUserEntityByOpenId(openID);
    }

    public String saveUserHeadImgUrl(UserEntity userEntity,String path){
        String phone = userEntity.getPhone()+".jpg";
        String headImgUrl = userEntity.getHeadImgUrl();
        String status = CommonUtil.getImageByUrl(headImgUrl,path,phone);
        if("success".equals(status)){
            return path+phone;
        }else{
            return path+"defaultAvatar.jpg";
        }
    }

}
