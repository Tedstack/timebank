package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Service("accountService")
public class AccountServiceImpl implements AccountService {

    @Autowired
    UserService userService;

    @Autowired
    RecordService recordService;

    @Autowired
    RequestOrderService requestOrderService;

    @Transactional
    public void payTimeVol(long recordID) {
        //1.查询订单价格
        PublishOrderEntity record = recordService.findRecordEntityById(recordID);
        double price = record.getPayMoney();

        //2.扣除申请者志愿者币账户
        UserEntity applyUser = userService.findUserEntityById(record.getApplyUserId());
        if(applyUser.getTimeVol()<price){
            throw new AccountServiceException("您的金额不足！");
        }
        double timeVol = applyUser.getTimeVol() - price;
        applyUser.setTimeVol(timeVol);
        userService.updateUserEntity(applyUser);

        //3.增加服务者志愿者币账户
        UserEntity serviceUser = userService.findUserEntityById(record.getServiceUserId());
        double timeVol2 = serviceUser.getTimeVol() + price;
        serviceUser.setTimeVol(timeVol2);
        userService.updateUserEntity(serviceUser);

        //4.更改订单状态
        record.setStatus(OrderStatus.alreadyComplete);
        recordService.updateRecordEntity(record);
    }

    //支付时间币
    @Transactional
    public void payTimeCoin(long recordID) {
        //1.查询订单价格
        PublishOrderEntity record = recordService.findRecordEntityById(recordID);
        double price = record.getPayMoney();

        //2.扣除申请者时间币账户
        UserEntity applyUser = userService.findUserEntityById(record.getApplyUserId());
        if(applyUser.getTimeCoin()<price){
            throw new AccountServiceException("您的金额不足！");
        }
        double timeCoin = applyUser.getTimeCoin() - price;
        applyUser.setTimeVol(timeCoin);
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

    @Transactional
    public void updateOrderToComplete(long recordID) {
        //1.查询订单价格
        PublishOrderEntity record = recordService.findRecordEntityById(recordID);
        //4.更改订单状态
        record.setStatus(OrderStatus.alreadyComplete);
        recordService.updateRecordEntity(record);
    }

    public void payRequestTimeVol(long matchID) {
        //1.查询订单价格
        RequestOrderEntity matchEntity = requestOrderService.findVolunteerRequestMatchEntityById(matchID);
        BigDecimal price = matchEntity.getPayMoney();

        //2.扣除申请者志愿者币账户
        UserEntity requestUser = userService.findUserEntityById(matchEntity.getRequestUserId());
        if(requestUser.getTimeVol()<price.doubleValue()){
            throw new AccountServiceException("您的金额不足！");
        }
        double timeVol = requestUser.getTimeVol() - price.doubleValue();
        requestUser.setTimeVol(timeVol);
        userService.updateUserEntity(requestUser);

        //3.增加服务者时间币账户
        UserEntity applyUser = userService.findUserEntityById(matchEntity.getApplyUserId());
        double timeVol2 = applyUser.getTimeVol() + price.doubleValue();
        applyUser.setTimeVol(timeVol2);
        userService.updateUserEntity(applyUser);

        //4.更改订单状态
        matchEntity.setStatus(OrderStatus.alreadyComplete);
        requestOrderService.updateVolunteerRequestMatchEntity(matchEntity);
    }
}
