package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.dao.ViewRecordDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.weixin.model.SNSUserInfo;
import com.blockchain.timebank.weixin.model.WeixinOauth2Token;
import com.blockchain.timebank.weixin.util.AdvancedUtil;
import com.blockchain.timebank.weixin.util.Configs;
import com.blockchain.timebank.weixin.util.TokenThread;
import com.blockchain.timebank.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    PublishService publishService;

    @Autowired
    RecordService recordService;

    @Autowired
    ServiceService serviceService;

    @Autowired
    ViewRecordDetailDao viewRecordDetailDao;

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @Autowired
    AccountService accountService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String userPage(ModelMap map) {
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("user", userEntity);
        return "userinfo";
    }


    // 登陆请求提交接口
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String userLogin(ModelMap map, @RequestParam String phone, @RequestParam String password) {
        if (phone.equals("") || password.equals("")) {
            map.addAttribute("error", "输入信息不能为空");
            return "login";
        }
        if (userService.findUserEntityByPhoneAndPassword(phone, password) == null) {
            map.addAttribute("error", "错误的用户名或者密码");
            return "login";
        } else {
            Authentication token = new UsernamePasswordAuthenticationToken(phone, password);
            SecurityContextHolder.getContext().setAuthentication(token);
            return "redirect:/index";
        }
    }

    // 登出请求
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(ModelMap map) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            SecurityContextHolder.getContext().setAuthentication(null);
        }
        map.addAttribute("logout", "已经为您安全退出！");
        return "/login";
    }

    // 注册请求接口
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public String userRegister(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String password) {
        String status = "";
        boolean phoneCorrect = true;
        boolean nameCorrect = true;

        if(userService.findUserEntityByPhone(phone) != null) {
            phoneCorrect = false;
            status = "phoneIsRegistered";
        }

        if(userService.findUserEntityByUserName(name)!=null){
            nameCorrect = false;
            status = "userNameIsRegistered";
        }

        if(phoneCorrect&&nameCorrect){
            try {
                UserEntity userEntity = new UserEntity();
                userEntity.setName(name);
                userEntity.setPhone(phone);
                userEntity.setPassword(password);
                userService.saveUserEntity(userEntity);
                Authentication token = new UsernamePasswordAuthenticationToken(phone, password);
                SecurityContextHolder.getContext().setAuthentication(token);
                status = "success";
            } catch (Exception e) {
                status = "failure";
            }
        }

        return status;
    }

    //跳转到修改个人信息页面
    @RequestMapping(value = "/startModifyPersonalInfo",method = RequestMethod.GET)
    public String startModifyPersonalInfo(ModelMap map){
        UserEntity user = getCurrentUser();

        map.addAttribute("user",user);
        return "change_userinfo";
    }

    //修改个人信息
    @RequestMapping(value = "/modifyPersonalInfo",method = RequestMethod.POST)
    @ResponseBody
    public String modifyPersonalInfo(ModelMap map,@RequestParam String qrcode){

        String status = "";
        if(userService.findUserEntityByQrCode(qrcode)==null){
            try{
                UserEntity user = getCurrentUser();
                user.setQrCode(qrcode);
                userService.updateUserEntity(user);
                status = "ok";
            }catch (Exception e){
                status = "error";
                e.printStackTrace();
            }
        }else{
            status = "alreadyExist";
        }

        return status;
    }

    //用户上传照片
    @RequestMapping(value = "/uploadUserInfo",method = RequestMethod.POST)
    @ResponseBody
    public String uploadUserInfo(HttpServletRequest request, @RequestParam(value = "file", required = false) MultipartFile file,
            @RequestParam(value = "file2", required = false) MultipartFile file2,String idNum){
        String msg = "";

        String idImg = null;
        String idImg2 = null;
        if (file != null && !file.isEmpty()&& file2 != null && !file2.isEmpty()) {
            System.out.println("idNum"+idNum);
            File uploadDir = new File(request.getSession().getServletContext().getRealPath("/") + "WEB-INF\\img\\profile\\");
            if (!uploadDir.exists()) uploadDir.mkdir();
            String suffix1 = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            idImg = idNum + "_" + 1 + suffix1;

            String suffix2 = file2.getOriginalFilename().substring(file2.getOriginalFilename().lastIndexOf("."));
            idImg2 = idNum + "_" + 2 + suffix2;

            // 构建上传目录及文件对象，不存在则自动创建
            String path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/profile/";
            File imgFile = new File(path, idImg);
            File imgFile2 = new File(path, idImg2);

            // 保存文件
            try {
                UserEntity user = getCurrentUser();
                user.setImg1(idImg);
                user.setImg2(idImg2);
                user.setIdCard(idNum);
                file.transferTo(imgFile);
                file2.transferTo(imgFile2);
                userService.updateUserEntity(user);
                msg = "success";
            } catch (Exception e) {
                msg = "failure";
                e.printStackTrace();
            }
        }else{
            msg = "failure";
        }


        return msg;
    }

    @RequestMapping(value = "/endModifyPersonalInfo",method = RequestMethod.GET)
    public String endModifyPersonalInfo(ModelMap map,@RequestParam String status){
        map.addAttribute("msg",status);
        return "change_userinfo_result";
    }

    //实名认证
    @RequestMapping(value = "/startRealNameAuth",method = RequestMethod.GET)
    public String startRealNameAuth(ModelMap map){
        return "realname_authentication";
    }

    /**
     * 查询用户作为服务者 发布的服务
     * @param map
     * @return
     */
    //查询用户发布服务的接口：已发布
    @RequestMapping(value = "/queryPublishAlreadyPublish",method = RequestMethod.GET)
    public String queryPublishAlreadyPublish(ModelMap map){
        List<ViewPublishDetailEntity> publishList = viewPublishDetailDao.findViewPublishDetailEntitiesByUserId(getCurrentUser().getId());

        //倒序排列
        Collections.reverse(publishList);
        map.addAttribute("publishList", publishList);
        return "service_posted_fabu";
    }

    //查询用户发布服务的接口：待确认
    @RequestMapping(value = "/queryPublishWaitingConfirm",method = RequestMethod.GET)
    public String queryPublishWaitingConfirm(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(getCurrentUser().getId(), OrderStatus.alreadyApply);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_posted_queren";
    }

    //查询用户发布服务的接口：待服务
    @RequestMapping(value = "/queryPublishWaitingService",method = RequestMethod.GET)
    public String queryPublishWaitingService(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(getCurrentUser().getId(), OrderStatus.waitingService);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_posted_fuwu";
    }

    //查询用户发布服务的接口：待收款
    @RequestMapping(value = "/queryPublishWaitingCollect",method = RequestMethod.GET)
    public String queryPublishWaitingCollect(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(getCurrentUser().getId(), OrderStatus.waitingPay);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_posted_zhifu";
    }

    //查询用户发布服务的接口：已完成
    @RequestMapping(value = "/queryPublishAlreadyComplete",method = RequestMethod.GET)
    public String queryPublishAlreadyComplete(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(getCurrentUser().getId(), OrderStatus.alreadyComplete);
        List<ViewRecordDetailEntity> recordDetailList2 = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(getCurrentUser().getId(), OrderStatus.alreadyRefuse);

        recordDetailList.addAll(recordDetailList2);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);

        return "service_posted_wancheng";
    }

    /**
     * 查村用户作为申请者 申请的订单
     * @param map
     * @return
     */
    //查询用户申请订单的接口：已申请
    @RequestMapping(value = "/queryOrderAlreadyApply",method = RequestMethod.GET)
    public String queryAlreadyApplyOrder(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(getCurrentUser().getId(), OrderStatus.alreadyApply);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_yuyue";
    }

    //查询用户申请订单的接口：待上门
    @RequestMapping(value = "/queryOrderWaitingService",method = RequestMethod.GET)
    public String queryWaitingServiceOrder(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(getCurrentUser().getId(), OrderStatus.waitingService);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_shangmen";
    }

    //查询用户申请订单的接口：待付款
    @RequestMapping(value = "/queryOrderWaitingPay",method = RequestMethod.GET)
    public String queryWaitingPayOrder(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(getCurrentUser().getId(), OrderStatus.waitingPay);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_fukuan";
    }

    //查询用户申请订单的接口：已完成
    @RequestMapping(value = "/queryOrderAlreadyComplete",method = RequestMethod.GET)
    public String queryAlreadyCompleteOrder(ModelMap map){
        List<ViewRecordDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(getCurrentUser().getId(), OrderStatus.alreadyComplete);
        List<ViewRecordDetailEntity> recordDetailList2 = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(getCurrentUser().getId(), OrderStatus.alreadyRefuse);
        recordDetailList.addAll(recordDetailList2);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_wancheng";
    }

    //服务者开始扫码
    @RequestMapping(value = "/serviceUserStartScan",method = RequestMethod.GET)
    public String serviceUserStartScan(ModelMap map,@RequestParam long recordID) throws InterruptedException {
        TokenThread.appId = "wxb0f6b07f01978a2a"; //获取servlet初始参数appid和appsecret
        TokenThread.appSecret = "386ef712d87480fa1dc27a93995936eb";
        System.out.println("appid:"+TokenThread.appId);
        System.out.println("appSecret:"+TokenThread.appSecret);
        Thread thread = new Thread(new TokenThread());
        thread.start(); //启动进程

        map.addAttribute("recordID",recordID);
        return "returnRobot";
    }

    //服务者扫码结束
    @RequestMapping(value = "/serviceUserCompleteScan",method = RequestMethod.POST)
    @ResponseBody
    public String serviceUserCompleteFirstScan(ModelMap map,@RequestParam String qrcode,@RequestParam long recordID){
        String status = "";
        UserEntity applyUser = userService.findUserEntityByQrCode(qrcode);
        RecordEntity record = recordService.findRecordEntityById(recordID);
        if(record.getApplyUserId()!=applyUser.getId()){
            status = "notOneself";
        }else{
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            if(record.getActualBeginTime()==null){
                record.setActualBeginTime(timestamp);
            }else{
                record.setActualEndTime(timestamp);
                record.setStatus(OrderStatus.waitingPay);
                Timestamp beginStamp = record.getActualBeginTime();
                Timestamp endStamp = record.getActualEndTime();
                long begin = beginStamp.getTime();
                long end = endStamp.getTime();

                long l = end - begin;
                String s = String.valueOf(l);
                double d = Double.parseDouble(s);
                double price = publishService.findPublishEntityById(record.getPublishId()).getPrice();
                double money = price * (d/(3600*1000));

                BigDecimal bg = new BigDecimal(money);
                double convertedMoney = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                record.setPayMoney(convertedMoney);
            }

            recordService.updateRecordEntity(record);
            status = "success";
        }
        //map.addAttribute("status",status);
        return status;
    }

    //申请者开始付款
    @RequestMapping(value = "/applyUserStartPay",method = RequestMethod.GET)
    public String applyUserStartPay(ModelMap map,@RequestParam long recordID){
        ViewRecordDetailEntity viewRecordDetailEntity = viewRecordDetailDao.findViewRecordDetailEntityById(recordID);

        map.addAttribute("viewRecordDetailEntity",viewRecordDetailEntity);
        return "service_posted_paydetails";
    }

    //申请志愿者服务的用户支付志愿者币
    @RequestMapping(value = "/applyUserPayTimeVol",method = RequestMethod.POST)
    @ResponseBody
    public void applyUserPayTimeCoin(ModelMap map,@RequestParam long recordID) {
        ViewRecordDetailEntity viewRecordDetailEntity = viewRecordDetailDao.findViewRecordDetailEntityById(recordID);
        if(viewRecordDetailEntity.getServiceType().equals(ServiceType.volunteerService)){
            if(getCurrentUser().getId()==viewRecordDetailEntity.getApplyUserId()){
                accountService.payTimeVol(recordID);
            }
        }

    }

    public UserEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserEntity userEntity = userService.findUserEntityByPhone(userDetails.getUsername());
            return userEntity;
        } else {
            return null;
        }
    }

}
