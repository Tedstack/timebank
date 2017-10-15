package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.UserEntity;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"/applicationContext.xml"})
public class UserTest {

    @Resource
    private UserService userService;

    //保存用户
    @Test
    public void testSaveUser() {

    }


    //根据id查找用户
    @Test
    public void testFindUserById() {
        UserEntity userEntity=userService.findUserEntityById(1L);

    }


}
