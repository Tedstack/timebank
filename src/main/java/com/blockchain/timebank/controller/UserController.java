package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.*;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.*;
import com.blockchain.timebank.util.*;
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
import com.blockchain.timebank.weixin.util.VerificationMessageSend;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.*;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private TechnicAuthService technicAuthService;

    @Autowired
    PublishService publishService;

    @Autowired
    RecordService recordService;

    @Autowired
    ServiceService serviceService;

    @Autowired
    ViewRecordDetailDao viewRecordDetailDao;

    @Autowired
    PublishDao publishDao;

    @Autowired
    RecordDao recordDao;

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @Autowired
    AccountService accountService;

    @Autowired
    RequestService requestService;

    @Autowired
    RequestOrderService requestOrderService;

    @Autowired
    ViewRequestOrderDetailDao viewRequestOrderDetailDao;

    @Autowired
    ViewUserActivityDetailDao viewUserActivityDetailDao;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String userPage(ModelMap map) {
        UserEntity userEntity = getCurrentUser();
        int techNum = technicAuthService.findTechAuthCountByUserId(userEntity.getId());
        map.addAttribute("user", userEntity);
        map.addAttribute("techNum", techNum);
        return "userinfo";
    }


    // 登陆请求提交接口
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String userLogin(ModelMap map, @RequestParam String phone, @RequestParam String password ,@RequestParam String openID) {
        if (phone.equals("") || password.equals("")) {
            map.addAttribute("error", "输入信息不能为空");
            return "login";
        }
        UserEntity userEntity = userService.findUserEntityByPhoneAndPassword(phone, password);
        if (userEntity == null) {
            map.addAttribute("error", "错误的用户名或者密码");
            return "login";
        } else {
            CommenData.setUserId(userEntity.getId());
            userEntity.setOpenId(openID);
            userService.updateUserEntity(userEntity);

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
            UserEntity user = getCurrentUser();
            //user.setOpenId(null);
            userService.updateUserEntity(user);

            SecurityContextHolder.getContext().setAuthentication(null);
        }
        map.addAttribute("logout", "已经为您安全退出！");
        return "/login";
    }

    //扫码支付测试
    @RequestMapping(value = "/scan",method = RequestMethod.GET)
    public String scan (ModelMap map){
        return "scan";
    }

    // 注册请求接口
    @RequestMapping(value = "/register2", method = RequestMethod.POST)
    @ResponseBody
    public String userRegister(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String password ,@RequestParam String openID) {
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
                if(openID!=null){
                    userEntity.setOpenId(openID);
                }
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

    // 短信验证请求接口
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public String userRegister(ModelMap map, @RequestParam String phone) {
        Random random=new Random();
        int ram = random.nextInt(999999)%(999999-100000+1) + 100000;
        String ram1=Integer.toString(ram);
        VerificationMessageSend sender=new VerificationMessageSend();
        String result=sender.sendPost(phone,ram1,"242470");
        return ram1;
    }

    //实名认证成功后跳转
    @RequestMapping(value = "/realnameNotification",method = RequestMethod.GET)
    public String realnameNotification(ModelMap map){
        return "realname_notification";
    }

    //专业认证成功后跳转
    @RequestMapping(value = "/techNotification",method = RequestMethod.GET)
    public String techNotification(ModelMap map){
        return "technic_notification";
    }

    //跳转到修改个人信息页面
    @RequestMapping(value = "/startModifyPersonalInfo",method = RequestMethod.GET)
    public String startModifyPersonalInfo(ModelMap map){
        UserEntity user = getCurrentUser();

        map.addAttribute("user",user);
        return "change_userinfo";
    }
    //查看头像大图
    @RequestMapping(value = "/headimg",method = RequestMethod.GET)
    public String headimg (ModelMap map){
        UserEntity user = getCurrentUser();

        map.addAttribute("user",user);
        return "headimg";
    }

    //查看个人信息
    @RequestMapping(value = "/userdetail",method = RequestMethod.GET)
    public String userdetail(ModelMap map){
        UserEntity user = getCurrentUser();

        map.addAttribute("user",user);
        return "userdetail";
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
    public String uploadUserInfo(HttpServletRequest request,
                                 @RequestParam(value = "file1", required = false) MultipartFile file,
                                 @RequestParam(value = "file2", required = false) MultipartFile file2,
                                 String idNum){
        String msg = "";

        String idImg = null;
        String idImg2 = null;
        if (file != null && !file.isEmpty()&& file2 != null && !file2.isEmpty()) {
            System.out.println("idNum"+idNum);
            File uploadDir = new File(request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/profile/");
            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }
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
                msg = "upload success";
            } catch (Exception e) {
                msg = "failure";
                e.printStackTrace();
            }
        }else{
            msg = "failure";
        }


        return msg;
    }
    
    //用户上传专业技能照片
    @RequestMapping(value = "/uploadTechInfo",method = RequestMethod.POST)
    @ResponseBody
    public String uploadTechInfo(HttpServletRequest request,
                                 @RequestParam(value = "file1", required = false) MultipartFile file1,
                                 @RequestParam(value = "file2", required = false) MultipartFile file2,
                                 @RequestParam(value = "file3", required = false) MultipartFile file3,
                                 String techName,
                                 String techLevel,
                                 String techId){
        String msg = "";

        String techImg1 = null;
        String techImg2 = null;
        String techImg3 = null;
        File imgFile1 = null;
        File imgFile2 = null;
        if (file3 != null && !file3.isEmpty()) {
            File uploadDir = new File(request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/techAuth/");
            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }
            String path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/techAuth/";
            if(file1 != null && !file1.isEmpty()) {
                String suffix1 = file1.getOriginalFilename().substring(file1.getOriginalFilename().lastIndexOf("."));
                techImg1 = techName + techLevel + techId + "_" + 1 + suffix1;
                imgFile1 = new File(path, techImg1);
            }
            if(file2 != null && !file2.isEmpty()) {
                String suffix2 = file2.getOriginalFilename().substring(file2.getOriginalFilename().lastIndexOf("."));
                techImg2 = techName + techLevel + techId + "_" + 2 + suffix2;
                imgFile2 = new File(path, techImg2);
            }
            String suffix3 = file3.getOriginalFilename().substring(file3.getOriginalFilename().lastIndexOf("."));
            techImg3 = techName + techLevel + techId + "_" + 3 + suffix3;
            File imgFile3 = new File(path, techImg3);

            // 保存文件
            try {
                TechnicAuthEntity technicAuthEntity = new TechnicAuthEntity();
                technicAuthEntity.setTechPhoto1(techImg1);
                technicAuthEntity.setTechPhoto2(techImg2);
                technicAuthEntity.setTechPhoto3(techImg3);
                technicAuthEntity.setTechId(techId);
                technicAuthEntity.setTechName(techName);
                technicAuthEntity.setTechLevel(techLevel);
                if(imgFile1!=null)
                    file1.transferTo(imgFile1);
                if(imgFile2!=null)
                    file2.transferTo(imgFile2);
                file3.transferTo(imgFile3);
                technicAuthEntity.setUserId(CommenData.getUserId());
                if (technicAuthService.insertTechnicAuthEntity(technicAuthEntity))
                    msg = "upload success";
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


    //申请充值时间币页面
    @RequestMapping(value = "/pay", method = RequestMethod.GET)
    public String coinpay(ModelMap map) {
        return "pay";
    }

    //实名认证
    @RequestMapping(value = "/startRealNameAuth",method = RequestMethod.GET)
    public String startRealNameAuth(ModelMap map){
        return "realname_authentication";
    }


    //专业技能认证
    @RequestMapping(value = "/startTechAuth",method = RequestMethod.GET)
    public String startTechAuth(ModelMap map){ return "technic_authentication"; }

    //专业技能信息页面
    @RequestMapping(value = "/techInfo",method = RequestMethod.GET)
    public String techInfo(ModelMap map){
        List<TechnicAuthEntity> technicAuthEntities = getCurrentUserTechAuths();
        map.addAttribute("authsInfo", technicAuthEntities);
        return "technic_info";
    }

    //实名认证信息页面
    @RequestMapping(value = "/realnameInfo",method = RequestMethod.GET)
    public String realnameInfo(ModelMap map){
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("user", userEntity);
        return "realname_info";
    }

    //志愿者币查看
    @RequestMapping(value = "/volunteer_coin",method = RequestMethod.GET)
    public String volunteer_coin(ModelMap map){
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("user", userEntity);
        return "volunteer_coin";
    }

    //查询用户发布服务接口：已完成的志愿者服务
    @RequestMapping(value="/queryVolPublishAlComplete",method = RequestMethod.GET)
    public String queryVolPublicAlComplete(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(CommenData.getUserId(),OrderStatus.alreadyComplete);
        List<ViewPublishOrderDetailEntity> recordDetailList2 = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(CommenData.getUserId(), OrderStatus.alreadyComplete);
        recordDetailList.addAll(recordDetailList2);
        Iterator<ViewPublishOrderDetailEntity> iter = recordDetailList.iterator();
        while(iter.hasNext()){
            ViewPublishOrderDetailEntity record = iter.next();
            if(!(record.getServiceType().equals("志愿者服务"))){
                iter.remove();
            }
        }
        if(recordDetailList.size()>0){
            Collections.reverse(recordDetailList);
        }
        map.addAttribute("recordDetailList", recordDetailList);
        map.addAttribute("userid",CommenData.getUserId());
        return "volCoin_list";

    }
    //显示志愿者币详情
    @RequestMapping(value="/vol_detail",method = RequestMethod.GET)
    public String detailPage(ModelMap map, @RequestParam long id){
        ViewPublishOrderDetailEntity viewPublishOrderDetailEntity = viewRecordDetailDao.findOne(id);
        map.addAttribute("vol_detail", viewPublishOrderDetailEntity);
        map.addAttribute("userid",CommenData.getUserId());
        return "volCoin_detail";
    }

    /**
     * 查询用户作为服务者 发布的服务
     * @param map
     * @return
     */
    //查询用户发布服务的接口：已发布
    @RequestMapping(value = "/queryPublishAlreadyPublish",method = RequestMethod.GET)
    public String queryPublishAlreadyPublish(ModelMap map){
        List<ViewPublishDetailEntity> publishList = viewPublishDetailDao.findViewPublishDetailEntitiesByUserIdAndIsDelete(CommenData.getUserId(),0);

        //倒序排列
        Collections.reverse(publishList);
        map.addAttribute("publishList", publishList);
        return "service_posted_fabu";
    }

    //查询用户发布服务的接口：待确认
    @RequestMapping(value = "/queryPublishWaitingConfirm",method = RequestMethod.GET)
    public String queryPublishWaitingConfirm(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(CommenData.getUserId(), OrderStatus.alreadyApply);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_posted_queren";
    }

    //查询用户发布服务的接口：待服务
    @RequestMapping(value = "/queryPublishWaitingService",method = RequestMethod.GET)
    public String queryPublishWaitingService(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(CommenData.getUserId(), OrderStatus.waitingService);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_posted_fuwu";
    }

    //查询用户发布服务的接口：待收款
    @RequestMapping(value = "/queryPublishWaitingCollect",method = RequestMethod.GET)
    public String queryPublishWaitingCollect(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(CommenData.getUserId(), OrderStatus.waitingPay);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_posted_zhifu";
    }

    //查询用户发布服务的接口：已完成
    @RequestMapping(value = "/queryPublishAlreadyComplete",method = RequestMethod.GET)
    public String queryPublishAlreadyComplete(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(CommenData.getUserId(), OrderStatus.alreadyComplete);
        List<ViewPublishOrderDetailEntity> recordDetailList2 = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(CommenData.getUserId(), OrderStatus.alreadyRefuse);

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
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(CommenData.getUserId(), OrderStatus.alreadyApply);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_yuyue";
    }

    //查询用户申请订单的接口：待上门
    @RequestMapping(value = "/queryOrderWaitingService",method = RequestMethod.GET)
    public String queryWaitingServiceOrder(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(CommenData.getUserId(), OrderStatus.waitingService);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_shangmen";
    }

    //查询用户申请订单的接口：待付款
    @RequestMapping(value = "/queryOrderWaitingPay",method = RequestMethod.GET)
    public String queryWaitingPayOrder(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(CommenData.getUserId(), OrderStatus.waitingPay);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_fukuan";
    }

    //查询用户申请订单的接口：已完成
    @RequestMapping(value = "/queryOrderAlreadyComplete",method = RequestMethod.GET)
    public String queryAlreadyCompleteOrder(ModelMap map){
        List<ViewPublishOrderDetailEntity> recordDetailList = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(CommenData.getUserId(), OrderStatus.alreadyComplete);
        List<ViewPublishOrderDetailEntity> recordDetailList2 = viewRecordDetailDao.findViewRecordDetailEntitiesByApplyUserIdAndStatus(CommenData.getUserId(), OrderStatus.alreadyRefuse);
        recordDetailList.addAll(recordDetailList2);

        //倒序排列
        Collections.reverse(recordDetailList);
        map.addAttribute("recordDetailList", recordDetailList);
        return "service_requested_wancheng";
    }

    //服务者开始扫码
    @RequestMapping(value = "/serviceUserStartScan",method = RequestMethod.GET)
    public String serviceUserStartScan(ModelMap map,@RequestParam long recordID) throws InterruptedException {
//        TokenThread.appId = Configs.APPID; //获取servlet初始参数appid和appsecret
//        TokenThread.appSecret = Configs.APPSECRET;
//        System.out.println("appid:"+TokenThread.appId);
//        System.out.println("appSecret:"+TokenThread.appSecret);
//        Thread thread = new Thread(new TokenThread());
//        thread.start(); //启动进程
        PublishOrderEntity matchEntity = recordService.findRecordEntityById(recordID);
        map.addAttribute("isFirst", matchEntity.getActualBeginTime()==null);
        map.addAttribute("recordID",recordID);
        return "returnRobot";
    }

    //服务者扫码结束
    @RequestMapping(value = "/serviceUserCompleteScan",method = RequestMethod.POST)
    @ResponseBody
    public String serviceUserCompleteFirstScan(ModelMap map,@RequestParam String qrcode,@RequestParam long recordID){
        String status = "";
        UserEntity applyUser = userService.findUserEntityByQrCode(qrcode);
        PublishOrderEntity record = recordService.findRecordEntityById(recordID);
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
        ViewPublishOrderDetailEntity viewPublishOrderDetailEntity = viewRecordDetailDao.findViewRecordDetailEntityById(recordID);

        map.addAttribute("viewPublishOrderDetailEntity", viewPublishOrderDetailEntity);
        return "service_posted_paydetails";
    }

    //申请者跳转到评价订单页面
    @RequestMapping(value = "/applyUserStartEvaluate",method = RequestMethod.GET)
    public String applyUserStartEvaluate(ModelMap map,@RequestParam long recordID){
        ViewPublishOrderDetailEntity viewPublishOrderDetailEntity = viewRecordDetailDao.findViewRecordDetailEntityById(recordID);

        map.addAttribute("viewPublishOrderDetailEntity", viewPublishOrderDetailEntity);
        return "rate";
    }

    //申请者评价订单
    @RequestMapping(value = "/applyUserEvaluateRecord",method = RequestMethod.POST)
    @ResponseBody
    public void applyUserEvaluateRecord(ModelMap map,@RequestParam long recordID,@RequestParam int rating,@RequestParam String comment){
        PublishOrderEntity record = recordService.findRecordEntityById(recordID);
        record.setRating(rating);
        record.setComment(comment);
        recordService.updateRecordEntity(record);
    }

    //申请志愿者服务的用户支付志愿者币
    @RequestMapping(value = "/updateOrderToComplete",method = RequestMethod.POST)
    @ResponseBody
    public void updateOrderToComplete(ModelMap map,@RequestParam long recordID) {
        accountService.updateOrderToComplete(recordID);
    }

    //申请志愿者或互助服务的用户支付志愿者币或时间币
    @RequestMapping(value = "/applyUserPayTimeVol",method = RequestMethod.POST)
    @ResponseBody
    public void applyUserPayTimeCoin(ModelMap map,@RequestParam long recordID) {
        ViewPublishOrderDetailEntity viewPublishOrderDetailEntity = viewRecordDetailDao.findViewRecordDetailEntityById(recordID);
        if(viewPublishOrderDetailEntity.getServiceType().equals(ServiceType.volunteerService)){
            if(CommenData.getUserId()== viewPublishOrderDetailEntity.getApplyUserId()){
                accountService.payTimeVol(recordID);
            }
        } else if(viewPublishOrderDetailEntity.getServiceType().equals(ServiceType.mutualHelpService)){
            if(CommenData.getUserId()== viewPublishOrderDetailEntity.getApplyUserId()){
                accountService.payTimeCoin(recordID);
            }
        }

    }

    //服务详细列表
    @RequestMapping(value = "/fabuDetail", method = RequestMethod.GET)
    public String detailPage(ModelMap map, @RequestParam long id, @RequestParam String type) {
        ViewPublishDetailEntity viewPublishDetailEntity = viewPublishDetailDao.findOne(id);
        map.addAttribute("detail", viewPublishDetailEntity);
        return "service_posted_detail";
    }

    //删除已发布的服务
    @RequestMapping(value = "/deletePublish", method = RequestMethod.GET)
    public String deletePublishService(ModelMap map, @RequestParam long id) {
        List<PublishOrderEntity> publishOrderList = recordDao.findByPublishId(id);
        String deleteMsg = "删除成功";
        boolean isDelete = true;
        for(PublishOrderEntity record : publishOrderList){
            String status = record.getStatus();
            if(!"已拒绝".equals(status)){
                if(!"已申请".equals(status)){
                    isDelete = false;
                    deleteMsg="您已接受过服务，无法删除";
                    break;
                }else{
                    isDelete = false;
                    deleteMsg="请拒绝所有申请后删除";
                }
            }
        }
        if(isDelete){
            PublishEntity publishEntity = publishDao.findPublishEntityById(id);
            publishEntity.setIsDelete(1);
            publishDao.save(publishEntity);
        }
        map.addAttribute("deleteMsg", deleteMsg);
        return "service_delete_result";
    }

    //历史评价信息
    @RequestMapping(value = "/history_evaluation", method = RequestMethod.GET)
    public String history_evaluation(ModelMap map) {
        List<ViewPublishOrderDetailEntity> servicelist = viewRecordDetailDao.findViewRecordDetailEntitiesByServiceUserIdAndStatus(CommenData.getUserId(),OrderStatus.alreadyComplete);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndAllowAndPresentAndStatus(CommenData.getUserId(), true, true, ActivityStatus.alreadyTerminate);
        List<ViewRequestOrderDetailEntity> requestlist = viewRequestOrderDetailDao.findViewRequestOrderDetailByApplyUserIdAndStatus(CommenData.getUserId(),OrderStatus.alreadyComplete);
        List<Evaluation_entity> recordlist = new ArrayList<Evaluation_entity>();
        Iterator<ViewPublishOrderDetailEntity> iter1 = servicelist.iterator();
        Iterator<ViewRequestOrderDetailEntity> iter2 = requestlist.iterator();
        Iterator<ViewUserActivityDetailEntity> iter3 = userActivityList.iterator();
        while(iter1.hasNext()){
            ViewPublishOrderDetailEntity record = iter1.next();
            if(null == record.getRating() && null == record.getComment()){
                ;
            }
            else{
                Evaluation_entity entity = new Evaluation_entity() ;
                entity.setClassify("service");
                entity.setId(record.getId());
                entity.setService_name(record.getServiceName());
                entity.setRating(record.getRating());
                entity.setService_type(record.getServiceType());
                entity.setComment(record.getComment());
                entity.setEndTime(record.getActualEndTime());
                recordlist.add(entity);
            }
        }
        while(iter2.hasNext()){
            ViewRequestOrderDetailEntity record2 = iter2.next();
            if(null == record2.getRate() && null == record2.getComment()){
                ;
            }
            else{
                Evaluation_entity entity = new Evaluation_entity();
                entity.setClassify("request");
                entity.setId(record2.getId());
                entity.setService_name(record2.getServiceName());
                entity.setRating(record2.getRate());
                entity.setService_type(record2.getServiceType());
                entity.setComment(record2.getComment());
                entity.setEndTime(record2.getActualEndTime());
                recordlist.add(entity);
            }
        }

        while(iter3.hasNext()){
            ViewUserActivityDetailEntity record3 = iter3.next();
            if(null == record3.getManagerRating() && null == record3.getManagerComment()){
                ;
            }
            else{
                Evaluation_entity entity = new Evaluation_entity();
                entity.setClassify("team_activity");
                entity.setId(record3.getActivityId());
                entity.setService_name(record3.getName());
                double rate = Double.valueOf(record3.getManagerRating());
                entity.setRating((int)rate);
                entity.setService_type(record3.getTeamName());
                entity.setComment(record3.getManagerComment());
                entity.setEndTime(record3.getEndTime());
                recordlist.add(entity);
            }
        }


        if(recordlist.size()>0){
            MySortList<Evaluation_entity> msList = new MySortList<Evaluation_entity>();
            msList.sortByMethod(recordlist,"getEndTime",true);
        }
        map.addAttribute("recordlist",recordlist);
        return "history_evaluation";

    }



    private UserEntity getCurrentUser() {
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            UserEntity userEntity = userService.findUserEntityByPhone(userDetails.getUsername());
            return userEntity;
        } else {
            return null;
        }
    }

    private List<TechnicAuthEntity> getCurrentUserTechAuths(){
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (userDetails != null) {
            try {
                return technicAuthService.findTechnicAuthEntitiesByUserId(CommenData.getUserId());
            }
            catch (Exception e){
                System.out.println(e);
                return null;
            }
        } else {
            return null;
        }
    }

}
