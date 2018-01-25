package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;

@Service("timebankAccountService")
public class TimebankAccountServiceImpl implements TimebankAccountService {

    @Autowired
    TimebankService timebankService;

    @Autowired
    UserAuthService userAuthService;

    @Autowired
    RechargeTimebankService rechargeTimebankService;

    @Autowired
    RechargeUserService rechargeUserService;

    @Autowired
    UserService userService;

    @Transactional
    public boolean createNewCurrency(String type, double total, String description, String reason) {
        TimebankEntity timebankEntity = new TimebankEntity();
        timebankEntity.setType(type);
        timebankEntity.setTotal(total);

        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        timebankEntity.setCreateTime(timestamp);

        timebankEntity.setCreateUserId(getCurrentUser().getId());
        timebankEntity.setDescription(description);
        timebankEntity.setReason(reason);
        timebankService.saveTimebankEntity(timebankEntity);
        return true;
    }

    @Transactional
    public boolean rechargeCurrency(long timebankID, double rechargeValue, String rechargeReason) {
        //1.更新timebank余额
        TimebankEntity timebankEntity = timebankService.findTimebankEntityByID(timebankID);
        double total = timebankEntity.getTotal() + rechargeValue;
        timebankEntity.setTotal(total);
        timebankService.saveTimebankEntity(timebankEntity);

        //2.将充值记录写入数据库
        RechargeTimebankEntity rechargeTimebankEntity = new RechargeTimebankEntity();
        rechargeTimebankEntity.setTimebankId(timebankID);
        rechargeTimebankEntity.setRechargeValue(rechargeValue);
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        rechargeTimebankEntity.setRechargeTime(timestamp);
        rechargeTimebankEntity.setOperatorId(getCurrentUser().getId());
        rechargeTimebankEntity.setReason(rechargeReason);
        rechargeTimebankService.saveRechargeTimebankEntity(rechargeTimebankEntity);

        return true;
    }

    @Transactional
    public boolean rechargeCurrencyToUser(String userPhone, long timebankID, double rechargeValue, String rechargeReason) {
        //1.更新用户账户和总帐户
        TimebankEntity timebankEntity = timebankService.findTimebankEntityByID(timebankID);
        String currencyType = timebankEntity.getType();
        UserEntity userEntity = userService.findUserEntityByPhone(userPhone);
        double userTotal,bankTotal;
        if(currencyType.equals(CurrencyType.timeVol)){
            //用户账户充值
            userTotal = userEntity.getTimeVol();
            userTotal = userTotal + rechargeValue;
            userEntity.setTimeVol(userTotal);

            //银行账户支出
            bankTotal = timebankEntity.getTotal();
            //判断账户余额是否充足
            if(bankTotal<rechargeValue){
                return false;
            }
            bankTotal = bankTotal - rechargeValue;
            timebankEntity.setTotal(bankTotal);
        }else if (currencyType.equals(CurrencyType.timeCoin)){
            userTotal = userEntity.getTimeCoin();
            userTotal = userTotal + rechargeValue;
            userEntity.setTimeCoin(userTotal);
        }else{
            return false;
        }
        userService.updateUserEntity(userEntity);
        timebankService.saveTimebankEntity(timebankEntity);

        //2.充值记录写入数据库
        RechargeUserEntity rechargeUserEntity = new RechargeUserEntity();
        rechargeUserEntity.setTimebankId(timebankID);
        rechargeUserEntity.setRechargeValue(rechargeValue);
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        rechargeUserEntity.setRechargeTime(timestamp);
        rechargeUserEntity.setOperatorId(getCurrentUser().getId());
        rechargeUserEntity.setUserId(userEntity.getId());
        rechargeUserEntity.setReason(rechargeReason);
        rechargeUserService.saveRechargeUserEntity(rechargeUserEntity);

        return true;
    }

    private UserAuthEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserAuthEntity userEntity = userAuthService.findUserAuthEntityByPhone(userDetails.getUsername());
            return userEntity;
        } else {
            return null;
        }
    }
}
