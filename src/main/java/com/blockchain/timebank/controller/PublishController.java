package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.dao.ViewRecordDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.TeamService;
import com.blockchain.timebank.service.PublishService;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.weixin.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/publish")
public class PublishController {

    @Autowired
    PublishService publishService;

    @Autowired
    ServiceService serviceService;

    @Autowired
    TeamService teamService;

    @Autowired
    UserService userService;

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @Autowired
    ViewRecordDetailDao viewRecordDetailDao;

    //服务种类页面
    @RequestMapping(value = "/category", method = RequestMethod.GET)
    public String categoryPage(ModelMap map) {
        UserEntity user = getCurrentUser();
        List<TeamEntity> teamList = teamService.findTeamsByManagerUserId(user.getId());

        //判断是否是团队管理者，若不是则无法发布服务
        if(teamList.size()==0){
            map.addAttribute("msg", "notManagerUser");
            return "publish_category_notManager";
        }

        map.addAttribute("teamList", teamList);
        return "publish_category";
    }

    //发布服务页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map) {
        UserEntity user =  getCurrentUser();
        if(user.getIsVerify()==null){
            map.addAttribute("msg", "notVerify");
            return "publish_service_result";
        }else if(user.getIsVerify()==0){
            map.addAttribute("msg", "failVerify");
            return "publish_service_result";
        }

        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        return "publish_add";
    }

    //服务显示列表
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listPage(ModelMap map, @RequestParam String type) {
        List<ViewPublishDetailEntity> list = viewPublishDetailDao.findAllByServiceType(type);
        //倒序排列
        Collections.reverse(list);
        map.addAttribute("list", list);
        map.addAttribute("type", type);
        return "publish_list";
    }

    //服务详细列表
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String detailPage(ModelMap map, @RequestParam long id) {
        ViewPublishDetailEntity viewPublishDetailEntity = viewPublishDetailDao.findOne(id);
        map.addAttribute("detail", viewPublishDetailEntity);

        //取前十条评价
        List<ViewRecordDetailEntity> temp = viewRecordDetailDao.findViewRecordDetailEntitiesByPublishIdAndStatus(id,OrderStatus.alreadyComplete);
        List<ViewRecordDetailEntity> recordList = new ArrayList<ViewRecordDetailEntity>();
        if(temp.size()<=10){
            recordList = temp;
        }else{
            recordList = temp.subList(0,10);
        }

        UserEntity user = userService.findUserEntityById(viewPublishDetailEntity.getUserId());
        String cardID = user.getIdCard();
        try {
            Map<String, Object> info =  CommonUtil.getCarInfo(cardID);
            map.addAttribute("age",info.get("age"));
        } catch (Exception e) {
            map.addAttribute("age",-1);
            e.printStackTrace();
        }

        map.addAttribute("timeVol", user.getTimeVol());
        map.addAttribute("recordList", recordList);
        return "publish_detail";
    }

    //发布服务提交接口
    @RequestMapping(value = "/add/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map, @RequestParam String serviceType, @RequestParam String serviceName, @RequestParam String description, @RequestParam String beginDate, @RequestParam String endDate, @RequestParam double price, @RequestParam String address) {
        try {
            PublishEntity publishEntity = new PublishEntity();
            publishEntity.setAddress(address);
            publishEntity.setDescription(description);
            publishEntity.setUserId(getCurrentUser().getId());
            publishEntity.setPrice(price);
            publishEntity.setServiceId(serviceService.findFirstByTypeAndName(serviceType, serviceName).getId());//serviceId
            Date beginTime = new SimpleDateFormat("yyyy-MM-dd").parse(beginDate);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            Date endTime = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
            publishEntity.setBeginDate(new Timestamp(beginTime.getTime()));
            publishEntity.setEndDate(new Timestamp(endTime.getTime()));
            publishService.savePublishEntity(publishEntity);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        map.addAttribute("type", serviceType);
        return "redirect:/publish/list";
    }

    public UserEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserEntity userEntity = userService.findUserEntityByPhone(userDetails.getUsername());
            System.out.println(userEntity.toString());
            return userEntity;
        } else {
            return null;
        }
    }
}
