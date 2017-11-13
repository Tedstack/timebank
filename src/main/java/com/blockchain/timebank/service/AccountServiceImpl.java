package com.blockchain.timebank.service;

import com.blockchain.timebank.dao.RecordDao;
import com.blockchain.timebank.dao.UserDao;
import com.blockchain.timebank.entity.AccountServiceException;
import com.blockchain.timebank.entity.OrderStatus;
import com.blockchain.timebank.entity.RecordEntity;
import com.blockchain.timebank.entity.UserEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
    UserService userService;

    @Autowired
    RecordService recordService;

    @Transactional
    public void payTimeCoin(long recordID) {
        //1.查询订单价格
        RecordEntity record = recordService.findRecordEntityById(recordID);
        double price = record.getPayMoney();

        //2.扣除申请者时间币账户
        UserEntity applyUser = userService.findUserEntityById(record.getApplyUserId());
        if(applyUser.getTimeCoin()<price){
            throw new AccountServiceException("您的金额不足！");
        }
        double timeCoin = applyUser.getTimeCoin() - price;
        applyUser.setTimeCoin(timeCoin);
        userService.updateUserEntity(applyUser);

        //3.增加服务者时间币账户
        UserEntity serviceUser = userService.findUserEntityById(record.getServiceUserId());
        double timeCoin2 = serviceUser.getTimeCoin() + price;
        serviceUser.setTimeCoin(timeCoin2);
        userService.updateUserEntity(serviceUser);

        //4.更改订单状态
        record.setStatus(OrderStatus.alreadyComplete);
        recordService.updateRecordEntity(record);
    }
}
