package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserEntity;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath*:applicationContext.xml"})
public class UserTest {

    @Autowired
    private UserService userService;

    //保存用户
    @Test
    public void testSaveUser() {
        UserEntity userEntity = new UserEntity();
        userEntity.setName("测试姓名");
        userEntity.setPhone("测试号码");//重复的号码只能插入一次
        userEntity.setTimeCoin(0);
        userEntity.setTimeVol(0);
        userEntity.setPassword("测试密码");
        userEntity.setRegisterDate(new java.sql.Date(new Date().getTime()));
        //userService.saveUserEntity(userEntity);
        System.out.println("ok");
    }


    //根据id查找用户
    @Test
    public void testFindUserById() {
        //UserEntity userEntity = userService.findUserEntityById(1L);
    }


}
