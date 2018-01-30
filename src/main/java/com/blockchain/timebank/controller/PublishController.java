package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.TechnicAuthDao;
import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.dao.ViewRecordDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.TeamService;
import com.blockchain.timebank.service.PublishService;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.weixin.util.CommonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
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
        //判断是否时匿名登陆 游客模式
        if(isAnonymous()){
            map.addAttribute("msg", "notManagerUser");
            return "publish_category_notManager";
        }

        UserEntity user = getCurrentUser();
        List<TeamEntity> teamList = teamService.findTeamsByCreatorId(user.getId());

        //判断是否是团队管理者，若不是则无法发布服务
        if(teamList.size()==0){
            map.addAttribute("msg", "notManagerUser");
            return "publish_category_notManager";
        }

        map.addAttribute("teamList", teamList);
        return "publish_category";
    }
    //活动发布申请页面
    @RequestMapping(value = "/activities_category", method = RequestMethod.GET)
    public String activities_categoryPage(ModelMap map) {
        //判断是否是匿名登陆 游客模式
        if(isAnonymous()){
            map.addAttribute("msg", "notManagerUser");
            return "activities_notmanager";
        }

        UserEntity user = getCurrentUser();
        List<TeamEntity> teamList = teamService.findTeamsByCreatorId(user.getId());

        //判断是否是团队管理者，若不是则无法发布服务
        if(teamList.size()==0){
            map.addAttribute("msg", "notManagerUser");
            return "activities_notmanager";
        }

        map.addAttribute("teamList", teamList);
        return "activities";
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
        UserEntity currentUser = getCurrentUser();
        List<TechnicAuthEntity> technicAuthEntities = publishService.findTechnicAuthEntitiesByUserId(currentUser.getId());
        long current=System.currentTimeMillis();//当前时间毫秒数
        long zero=current/(1000*3600*24)*(1000*3600*24)-TimeZone.getDefault().getRawOffset();
        Timestamp zeroTimestamp = new Timestamp(zero);
        List<PublishEntity> publishEntities = publishService.findByUserIdAndCreateTimeAfter(currentUser.getId(),zeroTimestamp);
        if(publishEntities.size() >= 3){
            map.addAttribute("surplus", true);
        } else{
            map.addAttribute("surplus", false);
        }
        if(technicAuthEntities != null && technicAuthEntities.size() != 0){
            map.addAttribute("isTechnicUser", true);
        } else {
            map.addAttribute("isTechnicUser", false);
        }
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        return "publish_add";
    }

    //服务显示列表
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listPage(ModelMap map, @RequestParam String type) {
        List<ViewPublishDetailEntity> list = publishService.findViewPublishDetailEntitiesByServiceTypeAndIsDeleteOrderByCreateTime(type);
        map.addAttribute("list", list);
        map.addAttribute("type", type);
        //return "publish_list";
        if("志愿者服务".equals(type)){
            return "service_volunteer/publish_list_volunteer";
        } else if("互助服务".equals(type)){
            return "service_mutualAid/publish_list_mutualAid";
        } else{
            return "service_profession/publish_list_profession";
        }
    }

    //条件筛选服务
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    public String selectService(ModelMap map, @RequestParam String type) {
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        map.addAttribute("type", type);
        return "service_select";
    }

    //服务详细列表
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String detailPage(ModelMap map, @RequestParam long id, @RequestParam String type) {
        ViewPublishDetailEntity viewPublishDetailEntity = viewPublishDetailDao.findOne(id);
        map.addAttribute("detail", viewPublishDetailEntity);
        if(isAnonymous()) {
            return "publish_detail_noManager";
        }
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("currentUser", userEntity);
        //取前十条评价
        /*List<ViewPublishOrderDetailEntity> temp = viewRecordDetailDao.findViewRecordDetailEntitiesByPublishIdAndStatus(id,OrderStatus.alreadyComplete);
        List<ViewPublishOrderDetailEntity> recordList = new ArrayList<ViewPublishOrderDetailEntity>();
        if(temp.size()<=10){
            recordList = temp;
        }else{
            recordList = temp.subList(0,10);
        }*/
        if("volunteer".equals(type)){
            return "service_volunteer/publish_detail_volunteer";
        } else if("mutualAid".equals(type)){
            return "service_mutualAid/publish_detail_mutualAid";
        } else{
            return "service_profession/publish_detail_profession";
        }
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

    //修改服务提交接口
    @RequestMapping(value = "/update/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map, @RequestParam long id, @RequestParam String address, @RequestParam String beginDate, @RequestParam String endDate, @RequestParam double price, @RequestParam String description) {
        try {
            PublishEntity publishEntity = publishService.findPublishEntityById(id);
            publishEntity.setAddress(address);
            publishEntity.setDescription(description);
            publishEntity.setUserId(getCurrentUser().getId());
            publishEntity.setPrice(price);
            Date beginTime = new SimpleDateFormat("yyyy-MM-dd").parse(beginDate);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            Date endTime = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
            publishEntity.setBeginDate(new Timestamp(beginTime.getTime()));
            publishEntity.setEndDate(new Timestamp(endTime.getTime()));
            publishService.savePublishEntity(publishEntity);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        ViewPublishDetailEntity viewPublishDetailEntity = viewPublishDetailDao.findOne(id);
        map.addAttribute("id", viewPublishDetailEntity.getId());
        map.addAttribute("type", viewPublishDetailEntity.getServiceType());
        return "redirect:/user/fabuDetail";
    }

    @RequestMapping(value = "/selectList", method = RequestMethod.GET)
    //public String listPage(ModelMap map, @RequestParam String type, @RequestParam String[] serviceName, @RequestParam Date upperDate, @RequestParam Date lowerDate, @RequestParam String upper, @RequestParam String lower) {
    public String selectPublishList(ModelMap map, @RequestParam String type,@RequestParam String upper, @RequestParam String lower, @RequestParam String upperDate, @RequestParam String lowerDate, @RequestParam String serviceName) {
        try {
            double upperPrice = Double.valueOf(upper);
            double lowerPrice = Double.valueOf(lower);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(lowerDate);
            Date endDate = sdf.parse(upperDate);
            Timestamp lowerTime = new Timestamp(startDate.getTime());
            Timestamp upperTime = new Timestamp(endDate.getTime());
            String[] serviceNameArr = serviceName.split(",");
            //List<ViewPublishDetailEntity> list = selectServiceDao.findPublishEntityByCondition(type, serviceName, upperTime, lowerTime, upperPrice, lowerPrice);
            List<ViewPublishDetailEntity> list = publishService.findAllByCondition(type, upperPrice, lowerPrice, upperTime, lowerTime, serviceNameArr);
            //倒序排列
            Collections.reverse(list);
            List<ViewPublishDetailEntity> overTimeList = new ArrayList<ViewPublishDetailEntity>();
            Date currentDate = new Date();
            String currentTime = sdf.format(currentDate);
            Iterator iterator = list.iterator();
            while(iterator.hasNext()){
                ViewPublishDetailEntity viewPublishDetailEntity = (ViewPublishDetailEntity)iterator.next();
                if(viewPublishDetailEntity!=null && viewPublishDetailEntity.getEndDate().getTime() < new Date().getTime()){
                    iterator.remove();
                    overTimeList.add(viewPublishDetailEntity);
                }
            }
            list.addAll(overTimeList);
            System.out.println(list == null);
            map.addAttribute("list", list);
            map.addAttribute("type", type);
        } catch(Exception e){
            e.printStackTrace();
        }
        if("志愿者服务".equals(type)){
            return "service_volunteer/publish_list_volunteer";
        } else if("互助服务".equals(type)){
            return "service_mutualAid/publish_list_mutualAid";
        } else{
            return "service_profession/publish_list_profession";
        }
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

    private boolean isAnonymous(){
        List<GrantedAuthority> authorities = (List<GrantedAuthority>) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
        for (GrantedAuthority grantedAuthority : authorities) {
            System.out.println("isAnonymous:" + grantedAuthority.getAuthority());
            if(grantedAuthority.getAuthority().equals("ROLE_ANONYMOUS")){
                return true;
            }
        }
        return false;
    }

}
