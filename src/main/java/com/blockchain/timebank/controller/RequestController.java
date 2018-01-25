package com.blockchain.timebank.controller;


import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.*;
import com.blockchain.timebank.weixin.util.MessageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/request")
public class RequestController {

    @Autowired
    UserService userService;

    @Autowired
    ServiceService serviceService;

    @Autowired
    RequestService requestService;

    @Autowired
    RequestOrderService requestOrderService;

    @Autowired
    AccountService accountService;

    @Autowired
    TechnicAuthService technicAuthService;

    //发布需求页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map) {
        UserEntity user =  getCurrentUser();
        if(user.getIsVerify()==null){
            map.addAttribute("msg", "notVerify");
            return "request/fail_page";
        }else if(user.getIsVerify()==0){
            map.addAttribute("msg", "failVerify");
            return "request/fail_page";
        }
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        return "request/add";
    }

    //发布需求提交接口
    @RequestMapping(value = "/add/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map,
                                @RequestParam Long serviceId,
                                @RequestParam String description,
                                @RequestParam String beginTime,
                                @RequestParam String endTime,
                                @RequestParam BigDecimal price,
                                @RequestParam String address) {
        try {
            UserEntity user =  getCurrentUser();
            RequestEntity requestEntity = new RequestEntity();
            requestEntity.setAddress(address);
            requestEntity.setDescription(description);
            requestEntity.setUserId(user.getId());
            requestEntity.setPrice(price);
            requestEntity.setServiceId(serviceId);//serviceId
            Date beginDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(beginTime);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            Date endDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTime);
            requestEntity.setBeginTime(new Timestamp(beginDateTime.getTime()));
            requestEntity.setEndTime(new Timestamp(endDateTime.getTime()));
            requestEntity.setRequesterName(user.getName());
            requestEntity.setRequesterPhone(user.getPhone());
            requestEntity.setPayway(1);
            requestService.saveRequestEntity(requestEntity);
        }
        catch (ParseException e) {
            e.printStackTrace();
        }

        List<ViewRequestDetailEntity> viewRequestDetailEntities = requestService.findAllRequestDetailByType(getServiceTypeById(serviceId));
        map.addAttribute("list", viewRequestDetailEntities);
        map.addAttribute("type", getServiceTypeById(serviceId));
        return "redirect:/request/list";
    }

    //志愿者需求详细列表
    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public String detailVolunteerPage(ModelMap map, @RequestParam long id, @RequestParam String type) {
        if(isAnonymous()) {
            return "request/detail_anonymous";
        }
        ViewRequestDetailEntity viewRequestDetailEntity = requestService.findDetailById(id);
        map.addAttribute("detail", viewRequestDetailEntity);
        UserEntity userEntity = getCurrentUser();
        map.addAttribute("currentUser", userEntity);
        map.addAttribute("type", type);
        return "request/detail";
    }

    //申请需求页面
    @RequestMapping(value = "/apply", method = RequestMethod.GET)
    public String apply(ModelMap map, long id){
        UserEntity userEntity = getCurrentUser();
        ViewRequestDetailEntity requestDetailEntity = requestService.findDetailById(id);
        if(userEntity.getIsVerify()==null){
            map.addAttribute("msg", "applierNotVerify");
            return "request/fail_page";
        }else if(userEntity.getIsVerify()==0){
            map.addAttribute("msg", "applierFailVerify");
            return "request/fail_page";
        }
        else if(requestDetailEntity.getServiceId()>=200&&requestDetailEntity.getServiceId()<300&&technicAuthService.findTechAuthCountByUserId(userEntity.getId())==0){
            map.addAttribute("msg", "applierNotTechVerify");
            return "request/fail_page";
        }
        map.addAttribute("detail", requestDetailEntity);
        map.addAttribute("name", userEntity.getName());
        map.addAttribute("phone", userEntity.getPhone());
        return "request/apply";
    }

    //需求申请提交
    @RequestMapping(value = "/applySubmit", method = RequestMethod.POST)
    public String applySubmit(ModelMap map,
                                       @RequestParam long requestUserId,
                                       @RequestParam long requestId,
                                       @RequestParam String beginTime,
                                       @RequestParam int serveTime){
        long applyUserId = getCurrentUser().getId();
        //判断是否申请自己的服务
        boolean isOneself = false;
        if(requestUserId == applyUserId){
            isOneself = true;
        }
        try {
            RequestOrderEntity requestOrderEntity = new RequestOrderEntity();
            requestOrderEntity.setApplyUserId(applyUserId);
            requestOrderEntity.setRequestUserId(requestUserId);
            requestOrderEntity.setRequestId(requestId);
            requestOrderEntity.setApplyUserId(getCurrentUser().getId());
            Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            requestOrderEntity.setBeginTime(new Timestamp(date.getTime()));
            requestOrderEntity.setEndTime(new Timestamp(date.getTime() + serveTime * 60 * 60 * 1000));
            requestOrderEntity.setStatus(OrderStatus.alreadyApply);
            RequestOrderEntity insertRequestOrderEntity = requestOrderService.saveRequestOrderEntity(requestOrderEntity);

            UserEntity userEntity = userService.findUserEntityById(requestUserId);
            ViewRequestOrderDetailEntity viewRequestOrderDetailEntity = requestOrderService.findRequestOrderDetailById(insertRequestOrderEntity.getId());
            if(userEntity != null && viewRequestOrderDetailEntity != null) {
                System.out.println("===========================进入判断===============================");
                int try_num = 3;
                while(!MessageUtil.customer_appoint(userEntity, viewRequestOrderDetailEntity)){
                    if (--try_num==0)
                        break;
                }

            }
            else if (userEntity==null){
                System.out.println("===========================user_entity null===========================");
            }
            else{
                System.out.println("===========================request_order_entity null===========================");
            }
            map.addAttribute("msg","ok");
        } catch (ParseException e) {
            e.printStackTrace();
            map.addAttribute("msg","error");
            map.addAttribute("detail","parseException");
        }
        if(isOneself){
            map.addAttribute("msg","error");
            map.addAttribute("detail","isOneself");
        }
        return "request/apply_result";
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String volunteerList(ModelMap map, @RequestParam String type) {
        List<ViewRequestDetailEntity> viewRequestDetailEntities = requestService.findAllRequestDetailByType(type);
        map.addAttribute("list", viewRequestDetailEntities);
        map.addAttribute("type", type);
        return "request/list";

    }

    //条件筛选需求
    @RequestMapping(value = "/select", method = RequestMethod.GET)
    public String selectService(ModelMap map, @RequestParam String type) {
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("service_list", list);
        map.addAttribute("type", type);
        return "request/select";
    }

    @RequestMapping(value = "/selectList", method = RequestMethod.GET)
    //public String listPage(ModelMap map, @RequestParam String type, @RequestParam String[] serviceName, @RequestParam Date upperDate, @RequestParam Date lowerDate, @RequestParam String upper, @RequestParam String lower) {
    public String selectRequestList(ModelMap map, @RequestParam String type,@RequestParam String upper, @RequestParam String lower, @RequestParam String upperDate, @RequestParam String lowerDate, @RequestParam String serviceName) {
        try {
            BigDecimal upperPrice = BigDecimal.valueOf(Double.valueOf(upper));
            BigDecimal lowerPrice = BigDecimal.valueOf(Double.valueOf(lower));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(lowerDate);
            Date endDate = sdf.parse(upperDate);
            Timestamp lowerTime = new Timestamp(startDate.getTime());
            Timestamp upperTime = new Timestamp(endDate.getTime()+24*60*60*1000);
            String[] serviceNameArr = serviceName.split(",");
            //List<ViewPublishDetailEntity> list = selectServiceDao.findPublishEntityByCondition(type, serviceName, upperTime, lowerTime, upperPrice, lowerPrice);
            List<ViewRequestDetailEntity> list = requestService.findAllByCondition(type, upperPrice, lowerPrice, upperTime, lowerTime, serviceNameArr);
            map.addAttribute("list", list);
            map.addAttribute("type", type);
        } catch(Exception e){
            e.printStackTrace();
        }
        return "request/list";
    }

    //需求者处理订单
    @RequestMapping(value = "/handleRequestMatch", method = RequestMethod.GET)
    public String handleRequestMatch(ModelMap map,@RequestParam long matchID,@RequestParam String handle){
        RequestOrderEntity matchEntity = requestOrderService.findRequestOrderEntityById(matchID);
        if(handle.equals("refuse")){
            matchEntity.setStatus(OrderStatus.alreadyRefuse);
            requestOrderService.updateRequestOrderEntity(matchEntity);
        }

        if(handle.equals("confirm")){
            matchEntity.setStatus(OrderStatus.waitingService);
            requestOrderService.updateRequestOrderEntity(matchEntity);
        }

        UserEntity userEntity = userService.findUserEntityById(matchEntity.getApplyUserId());
        RequestEntity requestEntity = requestService.findRequestById(matchEntity.getRequestId());
        ViewRequestOrderDetailEntity viewRequestOrderDetailEntity = requestOrderService.findRequestOrderDetailById(matchID);
        if(userEntity != null && viewRequestOrderDetailEntity != null) {
            System.out.println("===========================进入判断===============================");
            int try_num = 3;
            while(!MessageUtil.apply_result(userEntity, viewRequestOrderDetailEntity)){
                if (--try_num==0)
                    break;
            }

        }
        else if (userEntity==null){
            System.out.println("===========================user_entity null===========================");
        }
        else{
            System.out.println("===========================request_order_entity null===========================");
        }
        map.addAttribute("userEntity",userEntity);
        map.addAttribute("requestEntity",requestEntity);
        map.addAttribute("matchEntity",requestOrderService.findRequestOrderDetailById(matchID));

        return "request/taken_detail";
    }

    @RequestMapping(value = "/published", method = RequestMethod.GET)
    public String published(ModelMap map){
        long id = getCurrentUser().getId();
        
        List<ViewRequestDetailEntity> requestPublished = requestService.findUserRequestPublished(id);
        //倒序排列
        Collections.reverse(requestPublished);
        map.addAttribute("requestPublished", requestPublished);
        
        List<ViewRequestOrderDetailEntity> requestToConfirm = requestOrderService.findUserRequestToConfirm(id);
        //倒序排列
        Collections.reverse(requestToConfirm);
        map.addAttribute("requestToConfirm", requestToConfirm);

        List<ViewRequestOrderDetailEntity> requestToService = requestOrderService.findUserRequestToServe(id);
        //倒序排列
        Collections.reverse(requestToService);
        map.addAttribute("requestToService", requestToService);

        List<ViewRequestOrderDetailEntity> requestToPay = requestOrderService.findUserRequestToPay(id);
        //倒序排列
        Collections.reverse(requestToPay);
        map.addAttribute("requestToPay", requestToPay);
        
        List<ViewRequestOrderDetailEntity> requestCompleted = requestOrderService.findUserRequestCompleted(id);
        //倒序排列
        Collections.reverse(requestCompleted);
        map.addAttribute("requestCompleted", requestCompleted);
        
        return "request/published";

    }

    @RequestMapping(value = "deletePublish", method = RequestMethod.GET)
    public String deletePublish(ModelMap map, @RequestParam long id) {
        List<RequestOrderEntity> requestOrderEntityList = requestOrderService.findByRequestId(id);
        String deleteMsg = "删除成功";
        boolean isDelete = true;
        for(RequestOrderEntity record : requestOrderEntityList){
            String status = record.getStatus();
            if(!OrderStatus.alreadyRefuse.equals(status)){
                if(!OrderStatus.alreadyApply.equals(status)){
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
            RequestEntity requestEntity = requestService.findRequestById(id);
            requestEntity.setIsDeleted(1);
            requestService.saveRequestEntity(requestEntity);
        }
        map.addAttribute("deleteMsg", deleteMsg);
        return "request/delete_detail";
    }

        @RequestMapping(value = "/publishDetail", method = RequestMethod.GET)
    public String detailPage(ModelMap map, @RequestParam long id, @RequestParam String type) {
        ViewRequestDetailEntity viewRequestDetailEntity = requestService.findDetailById(id);
        map.addAttribute("detail", viewRequestDetailEntity);
        return "request/publish_detail";
    }

    @RequestMapping(value = "/applied", method = RequestMethod.GET)
    public String applied(ModelMap map){
        long id = getCurrentUser().getId();

        List<ViewRequestOrderDetailEntity> requestApplied = requestOrderService.findUserApplyApplied(id);
        //倒序排列
        Collections.reverse(requestApplied);
        map.addAttribute("requestApplied", requestApplied);

        List<ViewRequestOrderDetailEntity> requestToService = requestOrderService.findUserApplyToServe(id);
        //倒序排列
        Collections.reverse(requestToService);
        map.addAttribute("requestToService", requestToService);

        List<ViewRequestOrderDetailEntity> requestToPay = requestOrderService.findUserApplyToPay(id);
        //倒序排列
        Collections.reverse(requestToPay);
        map.addAttribute("requestToPay", requestToPay);

        List<ViewRequestOrderDetailEntity> requestCompleted = requestOrderService.findUserApplyCompleted(id);
        //倒序排列
        Collections.reverse(requestCompleted);
        map.addAttribute("requestCompleted", requestCompleted);
        
        return "request/applied";

    }

    //申请者开始扫码
    @RequestMapping(value = "/requestApplyUserStartScan",method = RequestMethod.GET)
    public String requestApplyUserStartScan(ModelMap map,@RequestParam long matchID) throws InterruptedException {
//        TokenThread.appId = Configs.APPID; //获取servlet初始参数appid和appsecret
//        TokenThread.appSecret = Configs.APPSECRET;
//        System.out.println("appid:"+TokenThread.appId);
//        System.out.println("appSecret:"+TokenThread.appSecret);
//        Thread thread = new Thread(new TokenThread());
//        thread.start(); //启动进程

        map.addAttribute("matchID",matchID);
        RequestOrderEntity matchEntity = requestOrderService.findRequestOrderEntityById(matchID);
        map.addAttribute("isFirst", matchEntity.getActualBeginTime()==null);
        return "request/qr_scan";
    }

    //申请者扫码结束
    @RequestMapping(value = "/requestApplyUserCompleteScan",method = RequestMethod.POST)
    @ResponseBody
    public String requestApplyUserCompleteScan(ModelMap map,@RequestParam String qrcode,@RequestParam long matchID){
        String status = "";
        UserEntity requestUser = userService.findUserEntityByQrCode(qrcode);
        RequestOrderEntity matchEntity = requestOrderService.findRequestOrderEntityById(matchID);
        if(matchEntity.getRequestUserId()!=requestUser.getId()){
            status = "notOneself";
        }else{
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            if(matchEntity.getActualBeginTime()==null){
                matchEntity.setActualBeginTime(timestamp);
            }else{
                matchEntity.setActualEndTime(timestamp);
                matchEntity.setStatus(OrderStatus.waitingPay);
                Timestamp beginStamp = matchEntity.getActualBeginTime();
                Timestamp endStamp = matchEntity.getActualEndTime();
                long begin = beginStamp.getTime();
                long end = endStamp.getTime();

                long l = end - begin;
                String s = String.valueOf(l);
                double d = Double.parseDouble(s);
                BigDecimal price = requestService.findDetailById(matchEntity.getRequestId()).getPrice();
                BigDecimal money = price.multiply(new BigDecimal ((d/(3600*1000))));

                matchEntity.setPayMoney(money);
            }

            requestOrderService.updateRequestOrderEntity(matchEntity);
            status = "success";
        }
        //map.addAttribute("status",status);
        return status;
    }

    //需求者开始付款
    @RequestMapping(value = "/requestUserStartPay",method = RequestMethod.GET)
    public String requestUserStartPay(ModelMap map,@RequestParam long matchID){
        ViewRequestOrderDetailEntity viewRequestOrderDetailEntity = requestOrderService.findRequestOrderDetailById(matchID);
        if(viewRequestOrderDetailEntity.getRequestUserId()!=getCurrentUser().getId())
            return "redirect:index";
        if(viewRequestOrderDetailEntity.getStatus().equals(OrderStatus.alreadyComplete))
            return "redirect:request/published?tab=4";

        map.addAttribute("viewMatchDetailEntity", viewRequestOrderDetailEntity);
        return "request/paydetail";
    }

    //需求者跳转到评价订单页面
    @RequestMapping(value = "/requestUserStartEvaluate",method = RequestMethod.GET)
    public String requestUserStartEvaluate(ModelMap map,@RequestParam long recordID){
        ViewRequestOrderDetailEntity viewRequestOrderDetailEntity = requestOrderService.findRequestOrderDetailById(recordID);

        map.addAttribute("viewMatchDetailEntity", viewRequestOrderDetailEntity);
        return "request/request_rate";
    }

    //需求者评价订单
    @RequestMapping(value = "/requestUserEvaluateRecord",method = RequestMethod.POST)
    @ResponseBody
    public void requestUserEvaluateRecord(ModelMap map,@RequestParam long recordID,@RequestParam double rating,@RequestParam String comment){
        RequestOrderEntity matchEntity = requestOrderService.findRequestOrderEntityById(recordID);
        matchEntity.setRate((int)rating);
        matchEntity.setComment(comment);
        requestOrderService.updateRequestOrderEntity(matchEntity);
    }

    //志愿者需求的用户支付志愿者币
    @RequestMapping(value = "/requestUserPayTimeVol",method = RequestMethod.POST)
    @ResponseBody
    public void requestUserPayTimeVol(ModelMap map,@RequestParam long matchID) {
        ViewRequestOrderDetailEntity viewRequestOrderDetailEntity = requestOrderService.findRequestOrderDetailById(matchID);
        if(viewRequestOrderDetailEntity.getServiceType().equals("volunteer")){
            if(getCurrentUser().getId()== viewRequestOrderDetailEntity.getRequestUserId()){
                accountService.payRequestTimeVol(matchID);
            }
        }
        else if(viewRequestOrderDetailEntity.getServiceType().equals("mutualAid")){
            if(getCurrentUser().getId()== viewRequestOrderDetailEntity.getRequestUserId()){
                accountService.payRequestTimeCoin(matchID);
            }
        }

    }


    @RequestMapping(value = "/updateOrderToComplete",method = RequestMethod.POST)
    @ResponseBody
    public void updateOrderToComplete(ModelMap map,@RequestParam long orderID) {
        accountService.updateRequestOrderToComplete(orderID);
    }

    private String getServiceTypeById(Long id){
        if(100<=id && id<200)
            return "volunteer";
        else if(200<=id && id<300)
            return "technic";
        else
            return "mutualAid";

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
