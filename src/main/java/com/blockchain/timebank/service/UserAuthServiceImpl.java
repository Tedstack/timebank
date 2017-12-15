package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.UserAuthDao;
import com.blockchain.timebank.entity.UserAuthEntity;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class UserAuthServiceImpl implements UserAuthService {

    @Autowired
    UserAuthDao userAuthDao;

    public UserAuthEntity saveUserAuthEntity(UserAuthEntity userAuthEntity) {
        return userAuthDao.save(userAuthEntity);
    }

    public List<UserAuthEntity> findAll() {
        return (List<UserAuthEntity>) userAuthDao.findAll();
    }

    public UserAuthEntity findUserAuthEntityById(long id) {
        return userAuthDao.findOne(id);
    }

    public UserAuthEntity findUserAuthEntityByPhone(String phone) {
        return userAuthDao.findUserAuthEntityByPhone(phone);
    }

    public List<String> getAllAuthoritiesFromJSONString(String authority) {
        JSONArray jsonArray = JSONArray.fromObject(authority);
        List<String> list= new ArrayList<String>();
        for(int i=0;i<jsonArray.size();i++){
            list.add(jsonArray.getString(i));
        }
        return list;
    }

    public String getJSONStringFromAllAuthorities(String[] authorities) {
        JSONArray jsonArray = new JSONArray();
        jsonArray.addAll(Arrays.asList(authorities));
        return jsonArray.toString();
    }

}
