package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.ViewActivityPublishDetailDao;
import com.blockchain.timebank.dao.ViewTeamDetailDao;
import com.blockchain.timebank.dao.ViewUserActivityDetailDao;
import com.blockchain.timebank.dao.ViewTeamUserDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.*;
import com.blockchain.timebank.weixin.util.Configs;
import net.sf.json.JSONObject;
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
import org.springframework.web.multipart.MultipartFile;
import com.blockchain.timebank.weixin.util.MessageUtil;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;



@Controller
@RequestMapping("/team")
public class TeamController {
    @Autowired
    TeamUserService teamUserService;

    @Autowired
    UserService userService;

    @Autowired
    ViewTeamDetailDao viewTeamDetailDao;

    @Autowired
    TeamService teamService;

    @Autowired
    ActivityPublishService activityPublishService;

    @Autowired
    ViewActivityPublishDetailDao viewActivityPublishDetailDao;

    @Autowired
    UserActivityService userActivityService;

    @Autowired
    ViewUserActivityDetailDao viewUserActivityDetailDao;

    @Autowired
    ViewTeamUserDetailDao viewTeamUserDetailDao;

    private Random random=new Random();

    @RequestMapping(value = "/teamList", method = RequestMethod.GET)
    public String teamListPage(ModelMap map) {
        List<TeamUserEntity> allTeamUser = teamUserService.findAll();
        List<ViewTeamDetailEntity> myTeam = new ArrayList<ViewTeamDetailEntity>();
        List<ViewTeamDetailEntity> otherTeam = new ArrayList<ViewTeamDetailEntity>();
        List<Long> alreadyInTeamList = new ArrayList<Long>();
        List<ViewTeamDetailEntity> alreadyInTeam = new ArrayList<ViewTeamDetailEntity>();
        List<Long> appliedTeamList = new ArrayList<Long>();
        List<ViewTeamDetailEntity> appliedTeam = new ArrayList<ViewTeamDetailEntity>();

        if(isAnonymous()){
            map.addAttribute("myList", myTeam);
            map.addAttribute("otherList", viewTeamDetailDao.findAllByDeleted(false));
            map.addAttribute("alreadyInList", alreadyInTeam);
            map.addAttribute("appliedList", appliedTeam);
            return "team/all_teams";
        }

        long currentId = getCurrentUser().getId();
        //从所有用户加入的团队中找到自己已经加入的团队
        for (int i = 0; i < allTeamUser.size(); i++) {
            if (allTeamUser.get(i).getUserId() == currentId) {
                if (allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered) || (allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.isLocked)))
                    alreadyInTeamList.add(allTeamUser.get(i).getTeamId());
                else if (allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.inApplication))
                    appliedTeamList.add(allTeamUser.get(i).getTeamId());
            }
        }
        List<ViewTeamDetailEntity> list = viewTeamDetailDao.findAllByDeleted(false);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getCreatorId() == currentId)
                myTeam.add(list.get(i));
            else if (alreadyInTeamList.contains(list.get(i).getId()))
                alreadyInTeam.add(list.get(i));
            else if (appliedTeamList.contains(list.get(i).getId()))
                appliedTeam.add(list.get(i));
            else
                otherTeam.add(list.get(i));
        }
        map.addAttribute("myList", myTeam);
        map.addAttribute("otherList", otherTeam);
        map.addAttribute("alreadyInList", alreadyInTeam);
        map.addAttribute("appliedList", appliedTeam);
        return "team/all_teams";
    }

    //搜索页面，效率需要改进
    @RequestMapping(value = "/searchTeam", method = RequestMethod.GET)
    public String searchTeam(ModelMap map, @RequestParam String searchInput) {
        map.addAttribute("param", searchInput);
        if(searchInput.equalsIgnoreCase(""))
            return "team/all_teams";
        List<ViewTeamDetailEntity> teamList = viewTeamDetailDao.findAllByNameContainingAndDeleted("%"+searchInput+"%",false);
        //从所有用户加入的团队中找到自己已经加入的团队
        List<ViewTeamDetailEntity> myTeam = new ArrayList<ViewTeamDetailEntity>();
        List<ViewTeamDetailEntity> otherTeam = new ArrayList<ViewTeamDetailEntity>();
        List<ViewTeamDetailEntity> alreadyInTeam = new ArrayList<ViewTeamDetailEntity>();
        List<ViewTeamDetailEntity> appliedTeam = new ArrayList<ViewTeamDetailEntity>();
        Long userId =  getCurrentUser().getId();
        for (int i = 0; i < teamList.size(); i++) {
            if (teamList.get(i).getCreatorId() == userId)
                myTeam.add(teamList.get(i));
            else {
                TeamUserEntity teamUser = teamUserService.findByUserIdAndTeamIdAndStatusNot(userId, teamList.get(i).getId(),TeamUserStatus.isDeleted);
                if (teamUser != null) {
                    if (teamUser.getStatus().equalsIgnoreCase(TeamUserStatus.isLocked) || teamUser.getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered))
                        alreadyInTeam.add(teamList.get(i));
                    else if (teamUser.getStatus().equalsIgnoreCase(TeamUserStatus.inApplication))
                        appliedTeam.add(teamList.get(i));
                    else
                        otherTeam.add(teamList.get(i));
                } else {
                    otherTeam.add(teamList.get(i));
                }
            }
        }
        map.addAttribute("myList", myTeam);
        map.addAttribute("otherList", otherTeam);
        map.addAttribute("alreadyInList", alreadyInTeam);
        map.addAttribute("appliedList", appliedTeam);
        return "team/all_teams_search";
    }

    @RequestMapping(value = "/chosenTeam", method = RequestMethod.GET)
    public String chosenTeamListPage(ModelMap map) {
        List<TeamUserEntity> allTeamUser = teamUserService.findAll();
        List<Long> alreadyInTeamList = new ArrayList<Long>();
        List<Long> managerTeamList = new ArrayList<Long>();
        long currentId =  getCurrentUser().getId();
        for (int i = 0; i < allTeamUser.size(); i++) {
            if (allTeamUser.get(i).getUserId() == currentId) {
                if (allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered) || allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.isLocked)){
                    if(allTeamUser.get(i).isManager())
                        managerTeamList.add(allTeamUser.get(i).getTeamId());
                    else
                        alreadyInTeamList.add(allTeamUser.get(i).getTeamId());
                }
            }
        }
        List<TeamEntity> myTeam = teamService.findTeamsByCreatorId(currentId);
        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        map.addAttribute("alreadyInList", alreadyInTeamList);
        map.addAttribute("managerTeamList", managerTeamList);
        map.addAttribute("myTeam", myTeam);
        return "team/chosen_teams";
    }

    @RequestMapping(value = "/addUserToTeam", method = RequestMethod.POST)
    @ResponseBody
    public String addUserToTeam(@RequestParam long teamId) {
        //判断是否匿名登陆，是则重新登陆
        if(isAnonymous()){
            return "isAnonymous";
        }

        long userId = getCurrentUser().getId();
        TeamUserEntity teamUser;
        teamUser=teamUserService.findByUserIdAndTeamId(getCurrentUser().getId(),teamId);
        if(teamUser==null)
            teamUser=new TeamUserEntity();
        teamUser.setTeamId(teamId);
        teamUser.setUserId(userId);
        teamUser.setStatus(TeamUserStatus.inApplication);
        teamUserService.addUserToTeam(teamUser);
        ViewTeamDetailEntity team=viewTeamDetailDao.findOne(teamId);
        if(MessageUtil.TextMessage(userService.findUserEntityById(team.getCreatorId()).getOpenId(),getAppliedMessage(getCurrentUser(),team.getCreatorUserName(),team.getName(),team.getId())))
            System.out.println("Message send success");
        else
            System.out.println("Message send fail");
        return "success";
    }

    @RequestMapping(value = "/quiteFromTeam", method = RequestMethod.POST)
    @ResponseBody
    public String deleteUserFromTeam(@RequestParam long teamId) {
        long userId =  getCurrentUser().getId();
        System.out.println("userId:" + userId);
        //用户状态是已加入
        TeamUserEntity teamUser = teamUserService.findByUserIdAndTeamId(userId, teamId);
        if (teamUser != null && (teamUser.getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered) || teamUser.getStatus().equalsIgnoreCase(TeamUserStatus.isLocked))) {
            teamUser.setStatus(TeamUserStatus.isDeleted);
            teamUserService.saveTeamUser(teamUser);
            return "success";
        }else
            return "failure";
    }

    //用户查看团队活动列表
    @RequestMapping(value = "/teamActivities", method = RequestMethod.GET)
    public String activities(ModelMap map) {
        long current=System.currentTimeMillis();//当前时间毫秒数
        long zero=current/(1000*3600*24)*(1000*3600*24)-TimeZone.getDefault().getRawOffset();
        Timestamp zeroTimestamp = new Timestamp(zero);
        List<ActivityPublishEntity> activityList = activityPublishService.findAllByStatusAndBeginTimeAfterAndDeleted(ActivityStatus.waitingForApply,zeroTimestamp,false);
        //倒序排列
        Collections.reverse(activityList);
        boolean isAnonymous=isAnonymous();
        //因为使用remove方法，此处循环用倒叙
        long currentId=0000;
        if(!isAnonymous)
            currentId= getCurrentUser().getId();
        for (int i = activityList.size() - 1; i >= 0; i--) {
            List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityList.get(i).getId(), true);
            //判断活动已报名人数是否达到活动要求人数，已达到的活动下架不显示
            if (userActivityList.size() >= activityList.get(i).getCount()) {
                activityList.remove(i);
                continue;
            }
            //活动不公开
            if (!activityList.get(i).isPublic()) {
                if(currentId==0000)
                    activityList.remove(i);
                else {
                    TeamUserEntity teamUser = teamUserService.findByUserIdAndTeamIdAndStatusNot(currentId, activityList.get(i).getTeamId(),TeamUserStatus.isDeleted);
                    if (teamUser != null) {
                        if (teamUser.getStatus() != TeamUserStatus.alreadyEntered)
                            activityList.remove(i);
                    }
                }
            }
        }

        map.addAttribute("activityList", activityList);
        return "team_activities";
    }

    // 团队活动详情页面
    @RequestMapping(value = "/teamActivityDetails", method = RequestMethod.GET)
    public String teamActivityDetails(ModelMap map, @RequestParam String type, @RequestParam long activityID) {

        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityID);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityID, true);
        ViewUserActivityDetailEntity userActivity=null;
        if(!isAnonymous())
            userActivity = viewUserActivityDetailDao.findViewUserActivityDetailEntityByUserIdAndActivityIdAndAllow(getCurrentUser().getId(), activityID,true);
        String isApplied = "false";
        if (userActivity != null && userActivity.isAllow())
            isApplied = "true";
        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("userActivityList", userActivityList);
        map.addAttribute("isApplied", isApplied);
        map.addAttribute("type", type);
        return "activities_details";
    }

    //申请发布团队活动页面
    @RequestMapping(value = "/startPublishActivity", method = RequestMethod.GET)
    public String startPublishActivity(ModelMap map) {
        UserEntity user = getCurrentUser();
//        long current=System.currentTimeMillis();//当前时间毫秒数
//        long zero=current/(1000*3600*24)*(1000*3600*24)-TimeZone.getDefault().getRawOffset();
//        Timestamp zeroTimestamp = new Timestamp(zero);
//        List<ViewActivityPublishDetailEntity> publishEntities = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdAndBeginTimeAfter(user.getId(),zeroTimestamp);
//        if(publishEntities.size() >= 3){
//            map.addAttribute("surplus", "true");
//        } else{
//            map.addAttribute("surplus", "false");
//        }
        List<TeamEntity> teamList = teamService.findTeamsByCreatorId(user.getId());
        List<ViewTeamUserDetailEntity> manageTeamList=viewTeamUserDetailDao.findAllByUserIdAndManagerAndTeamDeleted(user.getId(),true,false);
        if (teamList.size() == 0 && manageTeamList.size()==0) {
            map.addAttribute("msg", "notManagerUser");
            return "start_publish_activity_result";
        }

        map.addAttribute("teamList", teamList);
        map.addAttribute("manageTeamList", manageTeamList);
        return "activities_add";
    }

    // 发布活动
    @RequestMapping(value = "/publishActivity", method = RequestMethod.POST)
    @ResponseBody
    public String publishActivity(@RequestParam(value = "file1", required = false) MultipartFile file,
                                  long teamId,
                                  String activityType,
                                  boolean isPublicOptions,
                                  String activityName,
                                  String description,
                                  String beginTime, String endTime, String applyEndTime,
                                  int count,
                                  String address) {
        String idImg = "";
        if (file != null && !file.isEmpty()) {
            if(file.getSize()>1024*1024)
                return "hugeImg";
            File uploadDir = new File("/home/ubuntu/timebank/picture/activityImg/");
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            int ram = random.nextInt(999999)%(999999-100000+1) + 100000;
            String date = new java.sql.Date(System.currentTimeMillis()).toString();
            String suffix1 = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            idImg = Long.toString(teamId) + "_ActImg_"+date+"_"+Integer.toString(ram) + suffix1;
            String path = "/home/ubuntu/timebank/picture/activityImg/";
            File imgFile = new File(path, idImg);
            try {
                ActivityPublishEntity activityPublishEntity = new ActivityPublishEntity();
                activityPublishEntity.setTeamId(teamId);
                if (activityType.equalsIgnoreCase("志愿者"))
                    activityPublishEntity.setType(ActivityType.volunteerActivity);
                else
                    activityPublishEntity.setType(ActivityType.communityActivity);
                activityPublishEntity.setPublic(isPublicOptions);
                activityPublishEntity.setDeleted(false);
                activityPublishEntity.setName(activityName);
                activityPublishEntity.setDescription(description);
                activityPublishEntity.setHeadImg(idImg);
                file.transferTo(imgFile);
                activityPublishEntity.setStatus(ActivityStatus.waitingForApply);
                activityPublishEntity.setBeginTime(new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " ")).getTime()));
                activityPublishEntity.setEndTime(new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(endTime.replace("T", " ")).getTime()));
                activityPublishEntity.setApplyEndTime(new Timestamp(new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(applyEndTime.replace("T", " ")).getTime()));
                activityPublishEntity.setAddress(address);
                activityPublishEntity.setCount(count);
                activityPublishService.saveActivityPublishEntity(activityPublishEntity);
            } catch (Exception e) {
                e.printStackTrace();
                return "error";
            }
        }
        return "ok";
    }

    // 申请加入活动
    @RequestMapping(value = "/applyToJoinActivity", method = RequestMethod.POST)
    @ResponseBody
    public String applyToJoinActivity(@RequestParam long activityID) {
        //判断是否匿名登陆，是则重新登陆
        if(isAnonymous()){
            return "isAnonymous";
        }
        //管理员不能报名自己管理的活动
        ViewActivityPublishDetailEntity viewActivityPublishDetailEntity = viewActivityPublishDetailDao.findOne(activityID);
        if (viewActivityPublishDetailEntity.getCreatorId() ==  getCurrentUser().getId()) {
            return "managerError";
        }
        //判断是否重复申请
        UserActivityEntity userActivity = userActivityService.findUserFromActivity(getCurrentUser().getId(), activityID);
        if (userActivity != null && userActivity.isAllow()) {
            return "alreadyApply";
        }else if(userActivity != null && !userActivity.isAllow()){
            userActivity.setAllow(true);
            userActivityService.addUserActivity(userActivity);
        }else {
            UserActivityEntity userActivityEntity = new UserActivityEntity();
            userActivityEntity.setActivityId(activityID);
            userActivityEntity.setUserId(getCurrentUser().getId());
            userActivityEntity.setAllow(true);
            userActivityService.addUserActivity(userActivityEntity);
        }
        if(MessageUtil.apply_success(userService.findUserEntityById(viewActivityPublishDetailEntity.getCreatorId()),getCurrentUser().getName(),viewActivityPublishDetailEntity))
            System.out.println("Message send success");
        else
            System.out.println("Message send fail");
        return "ok";
    }

    @RequestMapping(value = "/quitFromActivity", method = RequestMethod.POST)
    @ResponseBody
    public String quitFromActivity(ModelMap map, @RequestParam long activityID) {
        try {
            UserActivityEntity userActivity = userActivityService.findUserFromActivity(getCurrentUser().getId(), activityID);
            userActivity.setAllow(false);
            userActivityService.updateUserActivityEntity(userActivity);
        } catch (Exception e) {
            return "fail";
        }
        return "ok";
    }

    //待报名活动的状态（发布活动）
    @RequestMapping(value = "/activitiesWaitingForApply", method = RequestMethod.GET)
    public String activitiesWaitingForApply(ModelMap map) {
        long current=System.currentTimeMillis();//当前时间毫秒数
        long zero=current/(1000*3600*24)*(1000*3600*24)-TimeZone.getDefault().getRawOffset();
        Timestamp zeroTimestamp = new Timestamp(zero);
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByDeletedAndStatusAndBeginTimeAfterAndCreatorIdOrPublishUserId(false, ActivityStatus.waitingForApply,zeroTimestamp,getCurrentUser().getId(),getCurrentUser().getId());
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);
        return "activities_daishenqing_publish";
    }

    //发布者管理待报名的活动
    @RequestMapping(value = "/manageActivities", method = RequestMethod.GET)
    public String manageActivities(ModelMap map, @RequestParam long activityId) {
        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityId);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityId, true);

        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("userActivityList", userActivityList);
        return "manage_activities";
    }

    @RequestMapping(value = "/modifyActivityPage", method = RequestMethod.GET)
    public String goToModifyPage(ModelMap map, @RequestParam long activityId) {
        List<TeamEntity> teamList = teamService.findTeamsByCreatorId(getCurrentUser().getId());
        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityId);
        String beiginTime = activityPublishDetail.getBeginTime().toString();
        beiginTime = beiginTime.substring(0, 10) + "T" + beiginTime.substring(11, 19);
        String endTime = activityPublishDetail.getEndTime().toString();
        endTime = endTime.substring(0, 10) + "T" + endTime.substring(11, 19);
        String applyTime = activityPublishDetail.getApplyEndTime().toString();
        applyTime = endTime.substring(0, 10) + "T" + applyTime.substring(11, 19);
        map.addAttribute("currentUser",Long.toString(getCurrentUser().getId()));
        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("teamList", teamList);
        map.addAttribute("beiginTime", beiginTime);
        map.addAttribute("endTime", endTime);
        map.addAttribute("applyTime", applyTime);
        return "activities_modify";
    }

    @RequestMapping(value = "/modifyActivity", method = RequestMethod.POST)
    @ResponseBody
    public String modifyActivity(@RequestParam(value = "file1", required = false) MultipartFile file,
                                 long teamOptions,
                                 String activityType,
                                 boolean isPublic,
                                 String activityName,
                                 String description,
                                 String beginTime, String endTime, String applyEndTime,
                                 int count,
                                 String address,
                                 String activityId) throws IOException {
        ActivityPublishEntity activity=activityPublishService.findActivityPublishEntityByID(Long.parseLong(activityId));
        String idImg="";
        if (file != null && !file.isEmpty()) {
            File uploadDir = new File("/home/ubuntu/timebank/picture/activityImg/");
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            int ram = random.nextInt(999999)%(999999-100000+1) + 100000;
            String suffix1 = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            idImg = Long.toString(activity.getId()) + "_ActImg_"+Integer.toString(ram) + suffix1;
            String path = "/home/ubuntu/timebank/picture/activityImg/";
            File imgFile = new File(path, idImg);
            activity.setHeadImg(idImg);
            file.transferTo(imgFile);
        }
        try {
            activity.setTeamId(teamOptions);
            if (activityType.equalsIgnoreCase("志愿者"))
                activity.setType(ActivityType.volunteerActivity);
            else
                activity.setType(ActivityType.communityActivity);
            activity.setPublic(isPublic);
            activity.setName(activityName);
            activity.setPublishUserId(getCurrentUser().getId());
            activity.setDescription(description);
            activity.setStatus(ActivityStatus.waitingForApply);
            Date beginDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));
            Date endDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(endTime.replace("T", " "));
            Date applyEndDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(applyEndTime.replace("T", " "));
            activity.setBeginTime(new Timestamp(beginDate.getTime()));
            activity.setEndTime(new Timestamp(endDate.getTime()));
            activity.setApplyEndTime(new Timestamp(applyEndDate.getTime()));
            activity.setAddress(address);
            activity.setCount(count);
            activityPublishService.saveActivityPublishEntity(activity);
            return "success";
        } catch (Exception e) {
            return "failure";
        }
    }

    //带申请活动中移除报名用户
    @RequestMapping(value = "/removeApplyUser", method = RequestMethod.POST)
    @ResponseBody
    public String removeApplyUser(@RequestParam long userActivityID) {
        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityID);
        UserEntity user=userService.findUserEntityById(userActivityEntity.getUserId());
        userActivityEntity.setAllow(false);
        userActivityService.updateUserActivityEntity(userActivityEntity);
        if(MessageUtil.TextMessage(user.getOpenId(),getRejectedMessage(userActivityEntity,user)))
            System.out.println("Message send success");
        else
            System.out.println("Message send fail");
        return "ok";
    }

    //活动管理者结束活动报名
    @RequestMapping(value = "/terminateApplyActivity", method = RequestMethod.POST)
    @ResponseBody
    public String terminateApplyActivity(ModelMap map, @RequestParam long activityID) {
        ActivityPublishEntity activityPublishEntity = activityPublishService.findActivityPublishEntityByID(activityID);
        activityPublishEntity.setStatus(ActivityStatus.waitingForExecute);
        activityPublishService.saveActivityPublishEntity(activityPublishEntity);

        return "ok";
    }

    //待执行团队活动页面（发布活动）
    @RequestMapping(value = "/activitiesWaitingToExecute", method = RequestMethod.GET)
    public String activitiesWaitingToExecute(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdOrPublishUserIdAndDeletedAndStatus(getCurrentUser().getId(),getCurrentUser().getId(), false, ActivityStatus.waitingForExecute);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);
        return "activities_daizhixing_publish";
    }

    // 发布者开始执行活动、勾选实际参与人员页面
    @RequestMapping(value = "/prepareStartActivity", method = RequestMethod.GET)
    public String startActivities(ModelMap map, @RequestParam long activityID) {
        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityID);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityID, true);

        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("userActivityList", userActivityList);
        return "manage_activities_start";
    }

    @RequestMapping(value = "/startActivity", method = RequestMethod.POST)
    @ResponseBody
    public String startActivity(ModelMap map, @RequestParam List<Long> userActivityIDList) {
        for (int i = 0; i < userActivityIDList.size(); i++) {
            UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityIDList.get(i));
            userActivityEntity.setPresent(true);
            userActivityService.updateUserActivityEntity(userActivityEntity);
        }

        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityIDList.get(0));
        ActivityPublishEntity activityPublishEntity = activityPublishService.findActivityPublishEntityByID(userActivityEntity.getActivityId());
        activityPublishEntity.setStatus(ActivityStatus.alreadyStart);
        activityPublishService.saveActivityPublishEntity(activityPublishEntity);

        JSONObject result = new JSONObject();
        result.put("msg", "ok");
        return result.toString();
    }

    //已开始团队活动页面（发布活动）
    @RequestMapping(value = "/alreadyStartedActivities", method = RequestMethod.GET)
    public String alreadyStartedActivities(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdOrPublishUserIdAndDeletedAndStatus(getCurrentUser().getId(),getCurrentUser().getId(), false, ActivityStatus.alreadyStart);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);
        return "activities_yikaishi_publish";
    }

    // 发布者结束活动、勾选实际参与人员页面
    @RequestMapping(value = "/prepareTerminateActivity", method = RequestMethod.GET)
    public String prepareTerminateActivity(ModelMap map, @RequestParam long activityID) {
        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityID);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresent(activityID, true, true);

        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("userActivityList", userActivityList);
        return "activities_waiting_finish";
    }

    @RequestMapping(value = "/terminateActivity", method = RequestMethod.POST)
    @ResponseBody
    public String terminateActivity(ModelMap map, @RequestParam long activityID) {

        ActivityPublishEntity activityPublishEntity = activityPublishService.findActivityPublishEntityByID(activityID);
        activityPublishEntity.setStatus(ActivityStatus.alreadyTerminate);
        activityPublishService.saveActivityPublishEntity(activityPublishEntity);
        if (activityPublishEntity.getType().equalsIgnoreCase(ActivityType.volunteerActivity)) {//志愿者活动结算志愿者时间
            double diff = activityPublishEntity.getEndTime().getTime() - activityPublishEntity.getBeginTime().getTime();
            diff = diff / (1000 * 60 * 60);
            List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresent(activityID, true, true);//获取实际参加人员
            for (int i = 0; i < userActivityList.size(); i++) {
                UserEntity user = userService.findUserEntityById(userActivityList.get(i).getUserId());
                user.setTimeVol(user.getTimeVol() + diff);//增加志愿者时间
                userService.saveUserEntity(user);//更新志愿者时间
            }
            return "ok_vol";
        }
        return "ok";
    }

    //申请已完成团队活动页面（发布活动）
    @RequestMapping(value = "/alreadyCompleteActivities", method = RequestMethod.GET)
    public String alreadyCompleteActivities(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdOrPublishUserIdAndDeletedAndStatus(getCurrentUser().getId(),getCurrentUser().getId(), false, ActivityStatus.alreadyTerminate);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);

        return "activities_yiwancheng_publish";
    }

    //跳转到待评价团员列表页面
    @RequestMapping(value = "/managerUserGetEvaluateList", method = RequestMethod.GET)
    public String managerUserGetEvaluateList(ModelMap map, @RequestParam long activityID) {
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresentAndStatus(activityID, true, true, ActivityStatus.alreadyTerminate);

        map.addAttribute("userActivityList", userActivityList);
        return "user_activity_rate_list";
    }

    //获取成员对活动的评价
    @RequestMapping(value = "/managerGetEvaluateList", method = RequestMethod.GET)
    public String managerGetEvaluateList(ModelMap map, @RequestParam long activityID) {
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresentAndStatus(activityID, true, true, ActivityStatus.alreadyTerminate);
        map.addAttribute("userActivityList", userActivityList);
        return "user_activity_comment_list";
    }

    //跳转到待评价团员评价页面
    @RequestMapping(value = "/managerUserStartEvaluateUser", method = RequestMethod.GET)
    public String managerUserStartEvaluateUser(ModelMap map,@RequestParam String type, @RequestParam long userActivityID) {
        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityID);

        map.addAttribute("userActivityEntity", userActivityEntity);
        map.addAttribute("type",type);
        return "user_activity_rate";
    }

    //申请者评价团员
    @RequestMapping(value = "/managerUserEvaluateUser", method = RequestMethod.POST)
    @ResponseBody
    public String managerUserEvaluateUser(@RequestParam long userActivityID, @RequestParam double rating, @RequestParam String comment) {
        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityID);
        userActivityEntity.setManagerRating(rating);
        userActivityEntity.setManagerComment(comment);
        userActivityService.updateUserActivityEntity(userActivityEntity);
        return "ok";
    }

    //团员评价活动
    @RequestMapping(value = "/userEvaluateActivity", method = RequestMethod.POST)
    @ResponseBody
    public String userEvaluateActivity(@RequestParam long userActivityID, @RequestParam double rating, @RequestParam String comment) {
        UserActivityEntity userActivityEntity = userActivityService.findUserFromActivity(getCurrentUser().getId(), userActivityID);
        userActivityEntity.setUserRating(rating);
        userActivityEntity.setUserComment(comment);
        userActivityService.updateUserActivityEntity(userActivityEntity);
        return "ok";
    }

    @RequestMapping(value = "/managerUserCheckUser", method = RequestMethod.GET)
    public String managerUserCheckUser(ModelMap map, @RequestParam long userID) {
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndAllowAndPresentAndStatus(userID, true, true, ActivityStatus.alreadyTerminate);
        for (int i = userActivityList.size() - 1; i >= 0; i--) {
            if (userActivityList.get(i).getManagerRating() == null) {
                userActivityList.remove(i);
            }
        }

        map.addAttribute("userActivityList", userActivityList);
        return "user_activity_info";
    }

    //申请已申请的活动页面（参与活动）
    @RequestMapping(value = "/alreadyApplyActivities", method = RequestMethod.GET)
    public String alreadyApplyActivities(ModelMap map) {
        List<ViewUserActivityDetailEntity> userActivityList_applied = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndStatusAndAllow(getCurrentUser().getId(), ActivityStatus.waitingForApply, true);
        //倒序排列
        Collections.reverse(userActivityList_applied);
        List<ViewUserActivityDetailEntity> userActivityList_finished = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndStatusAndAllow(getCurrentUser().getId(), ActivityStatus.alreadyTerminate, true);
        //倒序排列
        Collections.reverse(userActivityList_finished);

        map.addAttribute("userActivityList_applied", userActivityList_applied);
        map.addAttribute("userActivityList_finished", userActivityList_finished);
        return "activities_participant";
    }

    //申请待执行的活动页面（参与活动）
    @RequestMapping(value = "/activitiesWaitingToExecute2", method = RequestMethod.GET)
    public String activitiesWaitingToExecute2(ModelMap map) {
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndStatusAndAllow(getCurrentUser().getId(), ActivityStatus.waitingForExecute, true);
        //倒序排列
        Collections.reverse(userActivityList);
        List<ActivityPublishEntity> activityList=new ArrayList<ActivityPublishEntity>();
        for(int i=0;i<userActivityList.size();i++)
            activityList.add(activityPublishService.findActivityPublishEntityByID(userActivityList.get(i).getActivityId()));
        map.addAttribute("userActivityList", userActivityList);
        map.addAttribute("activityList", activityList);
        return "activities_daizhixing_volunteer";
    }

    //团队详情页面
    @RequestMapping(value = "/teamInfo", method = RequestMethod.GET)
    public String teamIndexView(ModelMap map, @RequestParam String teamId) {
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity = teamService.findById(Long.parseLong(teamId));
        UserEntity Manager = userService.findUserEntityById(teamEntity.getCreatorId());
        UserEntity creator = userService.findUserEntityById(teamEntity.getCreatorId());
        List<ViewTeamUserDetailEntity> memberList =viewTeamUserDetailDao.findAllByTeamIdAndManagerAndStatus(id,false,TeamUserStatus.alreadyEntered);
        List<ViewTeamUserDetailEntity> managerList =viewTeamUserDetailDao.findAllByTeamIdAndManagerAndStatus(id,true,TeamUserStatus.alreadyEntered);
        List<ActivityPublishEntity> activityList = activityPublishService.findAllByTeamIdAndStatus(id, ActivityStatus.alreadyTerminate);
        List<ActivityPublishEntity> publicActivity = new ArrayList<ActivityPublishEntity>();
        List<ActivityPublishEntity> privateActivity = new ArrayList<ActivityPublishEntity>();
        long userId = getCurrentUser().getId();
        String isMember="Out";
        String isCreator="false";
        if(userId==creator.getId())
            isCreator="true";
        //判断用户在这个团队内
        TeamUserEntity team = teamUserService.findByUserIdAndTeamId(userId, id);
        if(team!=null && team.getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered) || teamEntity.getCreatorId().equals(getCurrentUser().getId()))
            isMember="alreadyIn";
        else if(team!=null && (team.getStatus().equalsIgnoreCase(TeamUserStatus.isLocked) || team.getStatus().equalsIgnoreCase(TeamUserStatus.inApplication)))
            isMember="stillInProcess";
        if(isMember.equalsIgnoreCase("alreadyIn")) {
            for (int i = 0; i < activityList.size(); i++) {
                if (activityList.get(i).isPublic())
                    publicActivity.add(activityList.get(i));
                else
                    privateActivity.add(activityList.get(i));
            }
        }
        map.addAttribute("isMember", isMember);
        map.addAttribute("isCreator", isCreator);
        map.addAttribute("publicActivity", publicActivity);
        map.addAttribute("privateActivity", privateActivity);
        map.addAttribute("teamEntity", teamEntity);
        map.addAttribute("managerName", Manager.getName());
        map.addAttribute("userList", memberList);
        map.addAttribute("managerList", managerList);
        map.addAttribute("creator", creator);
        return "team/team_info";
    }

    @RequestMapping(value = "/myTeams", method = RequestMethod.GET)
    public String teamActivityView(ModelMap map) {
        long userId = getCurrentUser().getId();
        map.addAttribute("allTeamList", teamService.findTeamsByCreatorId(userId));
        return "team/my_teams";
    }

    @RequestMapping(value = "/myTeamMember", method = RequestMethod.GET)
    public String myTeamMemberView(ModelMap map, @RequestParam String teamId) {
        long id = Long.parseLong(teamId);
        long creatorId=teamService.findById(id).getCreatorId();
        List<TeamUserEntity> userList = teamUserService.findAllUsersOfOneTeam(id);//only find user id
        List<UserEntity> memberList = new ArrayList<UserEntity>();
        List<UserEntity> ManagerList = new ArrayList<UserEntity>();
        List<UserEntity> lockedList = new ArrayList<UserEntity>();
        List<UserEntity> appliedList = new ArrayList<UserEntity>();
        for (int i = 0; i < userList.size(); i++) {
            UserEntity user = userService.findUserEntityById(userList.get(i).getUserId());
            if (userList.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered)) {
                if (!userList.get(i).isManager())
                    memberList.add(user);//已经加入成员
                else
                    ManagerList.add(user);
            } else if (userList.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.isLocked))
                lockedList.add(user);//锁定成员
            else if (userList.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.inApplication))
                appliedList.add(user);
        }
        if(getCurrentUser().getId()==creatorId)
            map.addAttribute("isCreator","true");
        else
            map.addAttribute("isCreator","false");
        map.addAttribute("teamId",teamId);
        map.addAttribute("ManagerList", ManagerList);
        map.addAttribute("userList", memberList);
        map.addAttribute("lockedList", lockedList);
        map.addAttribute("appliedList", appliedList);
        return "team/my_team_member";
    }

    @RequestMapping(value = "/myTeamMessage", method = RequestMethod.GET)
    public String myTeamMessageView(ModelMap map, @RequestParam String teamId) {
        return "my_team_message";
    }

    @RequestMapping(value = "/myTeamHistory", method = RequestMethod.GET)
    public String myTeamHistoryView(ModelMap map, @RequestParam String teamId) {
        List<ActivityPublishEntity> activityList=activityPublishService.findAllByTeamIdAndStatus(Long.parseLong(teamId),ActivityStatus.alreadyTerminate);
        map.addAttribute("activityList",activityList);
        map.addAttribute("teamId",teamId);
        return "team/my_team_history";
    }

    @RequestMapping(value = "/lockMember", method = RequestMethod.POST)
    @ResponseBody
    public String blockTeamMember(@RequestParam String userId,@RequestParam String teamId) {
        return TeamManage(userId,teamId,"lock");
    }

    @RequestMapping(value = "/UnlockMember", method = RequestMethod.POST)
    @ResponseBody
    public String UnblockTeamMember(@RequestParam String userId,@RequestParam String teamId) {
        return TeamManage(userId,teamId,"unlock");
    }

    @RequestMapping(value = "/approveUser", method = RequestMethod.POST)
    @ResponseBody
    public String ApproveUser(@RequestParam String userId,@RequestParam String teamId) {
        UserEntity user=userService.findUserEntityById(Long.parseLong(userId));
        TeamEntity team=teamService.findById(Long.parseLong(teamId));
        if(MessageUtil.team_join_success(user,team))
            System.out.println("message send success");
        else
            System.out.println("Message send fail");
        return TeamManage(userId,teamId,"approve");
    }

    @RequestMapping(value = "/demoteManager", method = RequestMethod.POST)
    @ResponseBody
    public String DemoteManager(@RequestParam String userId,@RequestParam String teamId) {
        return TeamManage(userId,teamId, "demote");
    }

    @RequestMapping(value = "/promoteManager", method = RequestMethod.POST)
    @ResponseBody
    public String promteManager(@RequestParam String userId,@RequestParam String teamId) {
        return TeamManage(userId,teamId, "promote");
    }

    private String TeamManage(String userId,String teamId, String type) {
        long t_id = Long.parseLong(teamId);
        long u_id = Long.parseLong(userId);
        try {
            TeamUserEntity teamUser = teamUserService.findByUserIdAndTeamId(u_id, t_id);
            if (type.equalsIgnoreCase("lock")) {//锁定
                teamUser.setStatus(TeamUserStatus.isLocked);
            } else if (type.equalsIgnoreCase("unlock")) {//解锁
                teamUser.setStatus(TeamUserStatus.alreadyEntered);
            } else if (type.equalsIgnoreCase("approve")) {//同意加入
                teamUser.setStatus(TeamUserStatus.alreadyEntered);
            } else if (type.equalsIgnoreCase("demote")) {//解除管理员
                teamUser.setManager(false);
            } else if (type.equalsIgnoreCase("promote")) {//提升管理员
                teamUser.setManager(true);
            } else//非法操作
                return "failure";
            teamUserService.saveTeamUser(teamUser);
            System.out.println("The user " + userId + " has been locked");
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "failure";
        }
    }

    @RequestMapping(value = "/createPage", method = RequestMethod.GET)
    public String goToCreatePage(ModelMap map) {
        if(getCurrentUser().getIsVerify()==null)
            map.addAttribute("msg","NoVerified");
        else
            map.addAttribute("msg","Verified");
        return "team/create_team";
    }

    @RequestMapping(value = "/createTeam", method = RequestMethod.POST)
    @ResponseBody
    public String createTeam(@RequestParam(value = "file1", required = false) MultipartFile file,
                             String team_name,
                             String team_address,
                             String content_number,
                             String describe)throws IOException {
        String idImg = "";
        UserEntity user=getCurrentUser();
        if (checkTeamNameExist(team_name))
            return "nameExist";
        if (file != null && !file.isEmpty()) {
            if(file.getSize()>1024*1024)
                return "hugeImg";
            File uploadDir = new File("/home/ubuntu/timebank/picture/teamHeadImg");
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            int ram = random.nextInt(999999)%(999999-100000+1) + 100000;
            String suffix1 = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            idImg = team_name + "_headImg_"+ Integer.toString(ram) + suffix1;
            String path = "/home/ubuntu/timebank/picture/teamHeadImg";
            File imgFile = new File(path, idImg);
            file.transferTo(imgFile);
            try {
                TeamEntity newTeam = new TeamEntity();
                newTeam.setName(team_name);
                newTeam.setAddress(team_address);
                if (content_number.equalsIgnoreCase(""))
                    content_number = user.getPhone();
                newTeam.setHeadImg(idImg);
                newTeam.setCreatorId(user.getId());
                newTeam.setPhone(content_number);
                newTeam.setCreateDate(new java.sql.Date(System.currentTimeMillis()));
                newTeam.setDeleted(false);
                newTeam.setDescription(describe);
                teamService.addTeamEntity(newTeam);
                return "success";
            } catch (Exception e) {
                return "failure";
            }
        }
        return "missImg";
    }

    @RequestMapping(value = "/viewTeamInfoPage", method = RequestMethod.GET)
    public String goToViewTeamInfoPage(ModelMap map, @RequestParam String teamId) {
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity = teamService.findById(id);
        map.addAttribute("currentUser",Long.toString(getCurrentUser().getId()));
        map.addAttribute("teamEntity", teamEntity);
        return "team/view_teamInfo";
    }

    @RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
    public String goToModifyPage(ModelMap map, @RequestParam String teamId) {
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity = teamService.findById(id);
        map.addAttribute("currentUser",Long.toString(getCurrentUser().getId()));
        map.addAttribute("teamEntity", teamEntity);
        return "team/modify_team";
    }

    @RequestMapping(value = "/modifyTeam", method = RequestMethod.POST)
    @ResponseBody
    public String modifyTeam(@RequestParam(value = "file1", required = false) MultipartFile file,
                             String team_id,
                             String team_name,
                             String team_location,
                             String team_phone,
                             String describe) {
        try {
            TeamEntity team = teamService.findById(Long.parseLong(team_id));
            String idImg = "";
            //判断是否需要上传头像
            if (file != null && !file.isEmpty()) {
                if(file.getSize()>1024*1024)
                    return "hugeImg";
                File uploadDir = new File("/home/ubuntu/timebank/picture/teamHeadImg");
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                int ram = random.nextInt(999999)%(999999-100000+1) + 100000;
                String suffix1 = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                idImg = team_name + "_headImg_" + Integer.toString(ram) + suffix1;
                String path = "/home/ubuntu/timebank/picture/teamHeadImg/";
                File imgFile = new File(path, idImg);
                team.setHeadImg(idImg);
                file.transferTo(imgFile);
            }
            if (!team.getName().trim().equalsIgnoreCase(team_name)) {
                if (checkTeamNameExist(team_name))
                    return "nameExist";
                else
                    team.setName(team_name);
            }
            team.setDescription(describe);
            team.setPhone(team_phone);
            team.setAddress(team_location);
            teamService.saveTeamEntity(team);
            return "success";
        } catch (Exception e) {
            return "failure";
        }
    }

    @RequestMapping(value = "/deleteTeam", method = RequestMethod.POST)
    @ResponseBody
    public String deleteTeam(@RequestParam String teamId) {
        try {
            TeamEntity Team = teamService.findById(Long.parseLong(teamId));
            Team.setDeleted(true);
            teamService.saveTeamEntity(Team);
            List<ActivityPublishEntity> activityList = activityPublishService.findAllByTeamId(Team.getId());
            for (int i = 0; i < activityList.size(); i++) {
                activityList.get(i).setDeleted(true);
                activityPublishService.saveActivityPublishEntity(activityList.get(i));
            }
            return "success";
        } catch (Exception e) {
            System.out.println(e.toString());
            return "failure";
        }
    }

    @RequestMapping(value = "/deleteActivity", method = RequestMethod.POST)
    @ResponseBody
    public String deleteActivity(@RequestParam String activityId) {
        try {
            ActivityPublishEntity activityPublishEntity=activityPublishService.findActivityPublishEntityByID(Long.parseLong(activityId));
            activityPublishEntity.setDeleted(true);
            activityPublishService.saveActivityPublishEntity(activityPublishEntity);
            List<UserActivityEntity> userList=userActivityService.findAllByActivityId(Long.parseLong(activityId));
            for(int i=0;i<userList.size();i++){
                userList.get(i).setAllow(false);
                userActivityService.updateUserActivityEntity(userList.get(i));
            }
            return "success";
        } catch (Exception e) {
            System.out.println(e.toString());
            return "failure";
        }
    }

    @RequestMapping(value="/teamComment",method = RequestMethod.GET)
    public String viewTeamComment(ModelMap map, @RequestParam String teamId){
        long ID=Long.parseLong(teamId);
        List<ViewUserActivityDetailEntity> userList=new ArrayList<ViewUserActivityDetailEntity>();
        double all_rate=0;
        int num_comment=0;
        //find all userActivity record
        List<ViewUserActivityDetailEntity> userActivityList=viewUserActivityDetailDao.findAllByTeamId(ID);
        for(int i=0;i<userActivityList.size();i++){
            if(userActivityList.get(i).getUserComment()!=null){
                userList.add(userActivityList.get(i));
                all_rate+=userActivityList.get(i).getUserRating();
                num_comment++;
            }
        }
        all_rate=(double) Math.round(all_rate/num_comment * 100) / 100;
        map.addAttribute("HeadImg",teamService.findById(ID).getHeadImg());
        map.addAttribute("averageRate",String.valueOf(all_rate));
        map.addAttribute("userList",userList);
        return "team/team_comment_list";
    }

    //need promote
    @RequestMapping(value = "/userActivityList", method = RequestMethod.GET)
    public String viewUserActivityList(ModelMap map, @RequestParam long activityId) {
        List<ViewUserActivityDetailEntity> list = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityId, true);
        map.addAttribute("userList", list);
        return "user_activities_list";
    }

    @RequestMapping(value="/teamAvitivitySelect",method = RequestMethod.GET)
    public String goToActivitySelectPage(){
        return "activities_select";
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

    @RequestMapping(value = "/activitySearch", method = RequestMethod.GET)
    public String activities(ModelMap map,String activityName,String beginTime,String endTime) throws ParseException {
        long currentId=getCurrentUser().getId();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = sdf.parse(beginTime);
        Date endDate = sdf.parse(endTime);
        Timestamp BeginTime = new Timestamp(startDate.getTime());
        Timestamp EndTime = new Timestamp(endDate.getTime());
        List<ViewActivityPublishDetailEntity> activityList=viewActivityPublishDetailDao.findAllByNameContainingAndDeletedAndBeginTimeAfterAndEndTimeBefore(activityName,false,BeginTime,EndTime);
        //倒序排列
        Collections.reverse(activityList);
        //因为使用remove方法，此处循环用倒叙
        for (int i = activityList.size() - 1; i >= 0; i--) {
            List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityList.get(i).getId(), true);
            //判断活动已报名人数是否达到活动要求人数，已达到的活动下架不显示
            if (userActivityList.size() >= activityList.get(i).getCount()) {
                activityList.remove(i);
                continue;
            }
            //活动不公开
            if (!activityList.get(i).isPublic()) {
                TeamUserEntity teamUser = teamUserService.findByUserIdAndTeamIdAndStatusNot(currentId, activityList.get(i).getTeamId(), TeamUserStatus.isDeleted);
                if (teamUser != null) {
                    if (teamUser.getStatus() != TeamUserStatus.alreadyEntered)
                        activityList.remove(i);
                }
            }
        }

        map.addAttribute("activityList", activityList);
        return "team_activities_select";
    }

    private boolean checkTeamNameExist(String teamName) {
        System.out.println("TeamName   " + teamName);
        TeamEntity team;
        team = teamService.findTeamByName(teamName);
        if (team == null) {
            return false;
        } else {
            return true;
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

    private String getRejectedMessage(UserActivityEntity userActivityEntity,UserEntity user){
        ActivityPublishEntity activity=activityPublishService.findActivityPublishEntityByID(userActivityEntity.getActivityId());
        String sex=user.getSex();
        String param="先生";
        if(sex.equalsIgnoreCase("女"))
            param="女士";
        return "尊敬的"+user.getName()+param+",非常抱歉您报名的"+activity.getName()+"未能通过活动组织者的审核。";
    }

    private String getAppliedMessage(UserEntity user,String creator_name, String teamName,long teamid){
        return "尊敬的"+creator_name+",用户"+user.getName()+"已经报名申请你的"+teamName+"团队，请你"+"<a href=\\\"http://"+ Configs.DOMAINNAME+"/timebanktest/team/myTeamMember?teamId="+teamid+"\\\">尽快处理。</a>";
    }
}
