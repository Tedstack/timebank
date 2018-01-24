package com.blockchain.timebank.admin;


import com.blockchain.timebank.dao.ViewTimebankDetailDao;
import com.blockchain.timebank.entity.TimebankEntity;
import com.blockchain.timebank.entity.UserAuthEntity;
import com.blockchain.timebank.entity.ViewTimebankDetailEntity;
import com.blockchain.timebank.service.TimebankAccountService;
import com.blockchain.timebank.service.TimebankService;
import com.blockchain.timebank.service.UserAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class TimebankManageController {
    @Autowired
    TimebankService timebankService;

    @Autowired
    UserAuthService userAuthService;

    @Autowired
    TimebankAccountService timebankAccountService;

    @Autowired
    ViewTimebankDetailDao viewTimebankDetailDao;

    @RequestMapping(value = "/timebankInfo", method = RequestMethod.GET)
    public String timebankInfo(ModelMap map) {
        List<ViewTimebankDetailEntity> list = (List<ViewTimebankDetailEntity>) viewTimebankDetailDao.findAll();
        map.addAttribute("list_timebank", list);
        return "../admin/timebank_info";
    }

    @RequestMapping(value = "/timebankPublishNew", method = RequestMethod.GET)
    public String timebankPublishNew(ModelMap map) {
        return "../admin/timebank_publish_new";
    }

    @RequestMapping(value = "/timebankPublishNewSubmit", method = RequestMethod.POST)
    public String timebankPublishNewSubmit(ModelMap map, @RequestParam String type, @RequestParam double total, @RequestParam String description, @RequestParam String reason) {
        //1.输入总额合法性验证
        if(total<=0){
            map.addAttribute("error", "输入有误，发行失败！");
            return "../admin/timebank_publish_new";
        }

        //2.写入数据库
        boolean isSuccess = timebankAccountService.createNewCurrency(type,total,description,reason);
        if(isSuccess){
            map.addAttribute("ok", "发行成功！");
        }else{
            map.addAttribute("error", "输入有误，发行失败！");
        }

        return "../admin/timebank_publish_new";
    }

    @RequestMapping(value = "/timebankRecharge", method = RequestMethod.GET)
    public String timebankRecharge(ModelMap map, @RequestParam long timebankID) {
        ViewTimebankDetailEntity viewTimebankDetailEntity = viewTimebankDetailDao.findViewTimebankDetailEntityById(timebankID);
        map.addAttribute("viewTimebankDetailEntity", viewTimebankDetailEntity);
        return "../admin/timebank_recharge";
    }

    @RequestMapping(value = "/timebankRechargeSubmit", method = RequestMethod.POST)
    public String timebankRechargeSubmit(ModelMap map, @RequestParam long timebankID, @RequestParam double rechargeValue, @RequestParam String rechargeReason) {
        ViewTimebankDetailEntity viewTimebankDetailEntity = viewTimebankDetailDao.findViewTimebankDetailEntityById(timebankID);
        map.addAttribute("viewTimebankDetailEntity", viewTimebankDetailEntity);

        //1.输入总额合法性验证
        if(rechargeValue<=0){
            map.addAttribute("error", "输入有误，充值失败！");
            return "../admin/timebank_recharge";
        }

        //2.写入数据库
        boolean isSuccess = timebankAccountService.rechargeCurrency(timebankID,rechargeValue,rechargeReason);

        if(isSuccess){
            map.addAttribute("ok", "充值成功！");
        }else{
            map.addAttribute("error", "输入有误，充值失败！");
        }

        return "../admin/timebank_recharge";
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
