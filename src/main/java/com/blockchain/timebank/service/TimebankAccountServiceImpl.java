package com.blockchain.timebank.service;

import com.blockchain.timebank.entity.RechargeTimebankEntity;
import com.blockchain.timebank.entity.TimebankEntity;
import com.blockchain.timebank.entity.UserAuthEntity;
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
