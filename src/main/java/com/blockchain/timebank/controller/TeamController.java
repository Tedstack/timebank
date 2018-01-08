package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.ViewActivityPublishDetailDao;
import com.blockchain.timebank.dao.ViewTeamDetailDao;
import com.blockchain.timebank.dao.ViewUserActivityDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.*;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

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

    @RequestMapping(value = "/teamList", method = RequestMethod.GET)
    public String teamListPage(ModelMap map) {
        List<TeamUserEntity> allTeamUser = teamUserService.findAll();
        List<ViewTeamDetailEntity> myTeam=new ArrayList<ViewTeamDetailEntity>();
        List<ViewTeamDetailEntity> otherTeam=new ArrayList<ViewTeamDetailEntity>();
        List<Long> alreadyInTeamList = new ArrayList<Long>();
        List<ViewTeamDetailEntity> alreadyInTeam=new ArrayList<ViewTeamDetailEntity>();
        List<Long> appliedTeamList = new ArrayList<Long>();
        List<ViewTeamDetailEntity> appliedTeam=new ArrayList<ViewTeamDetailEntity>();
        long currentId=getCurrentUser().getId();
        //从所有用户加入的团队中找到自己已经加入的团队
        for(int i=0;i<allTeamUser.size();i++){
            if(allTeamUser.get(i).getUserId()==currentId){
                if(allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered) || (allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.isLocked)))
                    alreadyInTeamList.add(allTeamUser.get(i).getTeamId());
                else if( allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.inApplication))
                    appliedTeamList.add(allTeamUser.get(i).getTeamId());
            }
        }
        List<ViewTeamDetailEntity> list=viewTeamDetailDao.findAllByDeleted(false);
        for(int i=0;i<list.size();i++){
            if(list.get(i).getCreatorId()==currentId)
                myTeam.add(list.get(i));
            else if(alreadyInTeamList.contains(list.get(i).getId()))
                alreadyInTeam.add(list.get(i));
            else if(appliedTeamList.contains(list.get(i).getId()))
                appliedTeam.add(list.get(i));
            else
                otherTeam.add(list.get(i));
        }
        map.addAttribute("myList", myTeam);
        map.addAttribute("otherList",otherTeam);
        map.addAttribute("alreadyInList", alreadyInTeam);
        map.addAttribute("appliedList",appliedTeam);
        return "all_teams";
    }

    @RequestMapping(value = "/chosenTeam", method = RequestMethod.GET)
    public String chosenTeamListPage(ModelMap map) {
        List<TeamUserEntity> allTeamUser = teamUserService.findAll();
        List<Long> alreadyInTeamList = new ArrayList<Long>();
        long currentId=getCurrentUser().getId();
        for(int i=0;i<allTeamUser.size();i++){
            if(allTeamUser.get(i).getUserId()==currentId){
                if(allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered) || allTeamUser.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.isLocked))
                    alreadyInTeamList.add(allTeamUser.get(i).getTeamId());
            }
        }
        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        map.addAttribute("alreadyInList", alreadyInTeamList);
        return "chosen_teams";
    }

    @RequestMapping(value = "/addUserToTeam", method = RequestMethod.POST)
    @ResponseBody
    public String addUserToTeam(@RequestParam List<Long> teamIDList) {
        long userId=getCurrentUser().getId();
        for(int i=0;i<teamIDList.size();i++){
            TeamUserEntity teamUser = new TeamUserEntity();
            teamUser.setTeamId(teamIDList.get(i));
            teamUser.setUserId(userId);
            teamUser.setStatus(TeamUserStatus.inApplication);
            teamUserService.addUserToTeam(teamUser);
        }
        JSONObject result = new JSONObject();
        result.put("msg","ok");
        return result.toString();
    }

    @RequestMapping(value = "/quiteFromTeam", method = RequestMethod.POST)
    @ResponseBody
    public String deleteUserFromTeam(@RequestParam List<Long> teamIDList) {
        JSONObject result = new JSONObject();
        long userId=getCurrentUser().getId();
        System.out.println("userId:"+userId);
        for(int i=0;i<teamIDList.size();i++){
            System.out.println("teamId:"+teamIDList.get(i));
            //用户状态是已加入
            TeamUserEntity teamUser = teamUserService.findByUserIdAndTeamIdAndStatus(userId,teamIDList.get(i),TeamUserStatus.alreadyEntered);
            if (teamUser!= null) {
                teamUser.setStatus(TeamUserStatus.isDeleted);
                teamUserService.saveTeamUser(teamUser);
                result.put("msg", "ok");
                return result.toString();
            }
            //已加入状态是被锁定
            teamUser = teamUserService.findByUserIdAndTeamIdAndStatus(userId,teamIDList.get(i),TeamUserStatus.isLocked);
            if (teamUser!= null) {
                teamUser.setStatus(TeamUserStatus.isDeleted);
                teamUserService.saveTeamUser(teamUser);
                result.put("msg", "ok");
                return result.toString();
            }
            else
                result.put("msg", "fail");
        }
        return result.toString();
    }

    //用户查看团队活动列表
    @RequestMapping(value = "/teamActivities", method = RequestMethod.GET)
    public String activities(ModelMap map) {
        List<ActivityPublishEntity> activityList = activityPublishService.findAllWaitingApplyActivityPublishEntity();
        //倒序排列
        Collections.reverse(activityList);

        //因为使用remove方法，此处循环用倒叙
        for(int i=activityList.size()-1;i>=0;i--){
            List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityList.get(i).getId(),true);
            //判断活动已报名人数是否达到活动要求人数，已达到的活动下架不显示
            if(userActivityList.size() >= activityList.get(i).getCount()){
                activityList.remove(i);
                continue;
            }

            //活动不公开
            if(!activityList.get(i).isPublic()){
                long teamID = activityList.get(i).getTeamId();
                List<TeamUserEntity> teamUsersList = teamUserService.findAllUsersOfOneTeam(teamID);

                //判断当前用户是否加入私有活动的团队，未加入则将该私有活动移除，不显示，当前用户无权限查看
                boolean isRemove = true;

                for(int j=0;j<teamUsersList.size();j++){
                    if(teamUsersList.get(j).getUserId()==getCurrentUser().getId()){
                        isRemove = false;
                        break;
                    }
                }

                if(isRemove){
                    activityList.remove(i);
                }
            }
        }

        map.addAttribute("activityList",activityList);
        return "team_activities";
    }

    // 团队活动详情页面
    @RequestMapping(value = "/teamActivityDetails", method = RequestMethod.GET)
    public String teamActivityDetails(ModelMap map, @RequestParam long activityID) {

        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityID);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityID,true);

        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("userActivityList", userActivityList);
        return "activities_details";
    }

    //申请发布团体活动页面
    @RequestMapping(value = "/startPublishActivity", method = RequestMethod.GET)
    public String startPublishActivity(ModelMap map) {
        UserEntity user = getCurrentUser();
        List<TeamEntity> teamList = teamService.findTeamsByCreatorId(user.getId());

        //判断是否是团队管理者，若不是则无法发布服务
        if(teamList.size()==0){
            map.addAttribute("msg", "notManagerUser");
            return "start_publish_activity_result";
        }

        map.addAttribute("teamList", teamList);
        return "activities_add";
    }

    // 发布活动
    @RequestMapping(value = "/publishActivity", method = RequestMethod.POST)
    @ResponseBody
    public String publishActivity(ModelMap map, @RequestParam long teamId,@RequestParam String activityType, @RequestParam boolean isPublic, @RequestParam String activityName, @RequestParam String description, @RequestParam String beginTime
            ,@RequestParam String endTime ,@RequestParam String applyEndTime, @RequestParam int count, @RequestParam String address) {
        try {
            ActivityPublishEntity activityPublishEntity = new ActivityPublishEntity();
            activityPublishEntity.setTeamId(teamId);
            if(activityType.equalsIgnoreCase("志愿者"))
                activityPublishEntity.setType(ActivityType.volunteerActivity);
            else
                activityPublishEntity.setType(ActivityType.communityActivity);
            activityPublishEntity.setPublic(isPublic);
            activityPublishEntity.setDeleted(false);
            activityPublishEntity.setName(activityName);
            activityPublishEntity.setDescription(description);
            activityPublishEntity.setStatus(ActivityStatus.waitingForApply);
            Date beginDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(beginTime.replace("T", " "));
            Date endDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(endTime.replace("T", " "));
            Date applyEndDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").parse(applyEndTime.replace("T", " "));
            activityPublishEntity.setBeginTime(new Timestamp(beginDate.getTime()));
            activityPublishEntity.setEndTime(new Timestamp(endDate.getTime()));
            activityPublishEntity.setApplyEndTime(new Timestamp(applyEndDate.getTime()));
            activityPublishEntity.setAddress(address);
            activityPublishEntity.setCount(count);
            activityPublishService.saveActivityPublishEntity(activityPublishEntity);
        } catch (ParseException e) {
            e.printStackTrace();
            return "error";
        }
        return "ok";
    }

    // 申请加入活动
    @RequestMapping(value = "/applyToJoinActivity", method = RequestMethod.POST)
    @ResponseBody
    public String applyToJoinActivity(ModelMap map, @RequestParam long activityID) {
        ViewActivityPublishDetailEntity viewActivityPublishDetailEntity = viewActivityPublishDetailDao.findOne(activityID);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityID,true);
        //判断活动已报名人数是否达到活动要求人数，已达到报名人数上限的活动不允许报名
        if(userActivityList.size() >= viewActivityPublishDetailEntity.getCount()){
            return "upperLimit";
        }

        //判断是否重复申请
        UserActivityEntity userActivity = userActivityService.findUserFromActivity(getCurrentUser().getId(),activityID);
        if(userActivity!=null){
            return "alreadyApply";
        }

        //判断是否是团队管理者
        if(viewActivityPublishDetailEntity.getCreatorId()==getCurrentUser().getId()){
            return "managerError";
        }

        UserActivityEntity userActivityEntity = new UserActivityEntity();
        userActivityEntity.setActivityId(activityID);
        userActivityEntity.setUserId(getCurrentUser().getId());
        userActivityEntity.setAllow(true);

        userActivityService.addUserActivity(userActivityEntity);

        return "ok";
    }

    //待申请活动的状态（发布活动）
    @RequestMapping(value = "/activitiesWaitingForApply", method = RequestMethod.GET)
    public String activitiesWaitingForApply(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.waitingForApply);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);
        return "activities_daishenqing_publish";
    }

    //发布者管理待申请的活动
    @RequestMapping(value = "/manageActivities", method = RequestMethod.GET)
    public String manageActivities(ModelMap map, @RequestParam long activityId) {
        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityId);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityId,true);

        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("userActivityList", userActivityList);
        return "manage_activities";
    }

    //带申请活动中移除报名用户
    @RequestMapping(value = "/removeApplyUser", method = RequestMethod.POST)
    @ResponseBody
    public String removeApplyUser(ModelMap map, @RequestParam long userActivityID) {
        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityID);
        userActivityEntity.setAllow(false);
        userActivityService.updateUserActivityEntity(userActivityEntity);

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

    //待执行团体活动页面（发布活动）
    @RequestMapping(value = "/activitiesWaitingToExecute", method = RequestMethod.GET)
    public String activitiesWaitingToExecute(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.waitingForExecute);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);
        return "activities_daizhixing_publish";
    }

    // 发布者开始执行活动、勾选实际参与人员页面
    @RequestMapping(value = "/prepareStartActivity", method = RequestMethod.GET)
    public String startActivities(ModelMap map, @RequestParam long activityID) {
        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityID);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllow(activityID,true);

        map.addAttribute("activityPublishDetail", activityPublishDetail);
        map.addAttribute("userActivityList", userActivityList);
        return "manage_activities_start";
    }

    @RequestMapping(value = "/startActivity", method = RequestMethod.POST)
    @ResponseBody
    public String startActivity(ModelMap map, @RequestParam List<Long> userActivityIDList) {
        for(int i=0;i<userActivityIDList.size();i++){
            UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityIDList.get(i));
            userActivityEntity.setPresent(true);
            userActivityService.updateUserActivityEntity(userActivityEntity);
        }

        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityIDList.get(0));
        ActivityPublishEntity activityPublishEntity = activityPublishService.findActivityPublishEntityByID(userActivityEntity.getActivityId());
        activityPublishEntity.setStatus(ActivityStatus.alreadyStart);
        activityPublishService.saveActivityPublishEntity(activityPublishEntity);

        JSONObject result = new JSONObject();
        result.put("msg","ok");
        return result.toString();
    }

    //已开始团体活动页面（发布活动）
    @RequestMapping(value = "/alreadyStartedActivities", method = RequestMethod.GET)
    public String alreadyStartedActivities(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.alreadyStart);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);
        return "activities_yikaishi_publish";
    }

    // 发布者结束活动、勾选实际参与人员页面
    @RequestMapping(value = "/prepareTerminateActivity", method = RequestMethod.GET)
    public String prepareTerminateActivity(ModelMap map, @RequestParam long activityID) {
        ViewActivityPublishDetailEntity activityPublishDetail = viewActivityPublishDetailDao.findOne(activityID);
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresent(activityID,true, true);

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
        if(activityPublishEntity.getType().equalsIgnoreCase(ActivityType.volunteerActivity)){//志愿者活动结算志愿者时间
            double diff=activityPublishEntity.getEndTime().getTime() - activityPublishEntity.getBeginTime().getTime();
            diff=diff/(1000*60*60);
            List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresent(activityID,true, true);//获取实际参加人员
            for(int i=0;i<userActivityList.size();i++)
            {
                UserEntity user=userService.findUserEntityById(userActivityList.get(i).getUserId());
                user.setTimeVol(user.getTimeVol()+diff);//增加志愿者时间
                userService.saveUserEntity(user);//更新志愿者时间
            }
            return "ok_vol";
        }
        return "ok";
    }

    //申请已完成团体活动页面（发布活动）
    @RequestMapping(value = "/alreadyCompleteActivities", method = RequestMethod.GET)
    public String alreadyCompleteActivities(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByCreatorIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.alreadyTerminate);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);

        return "activities_yiwancheng_publish";
    }

    //跳转到待评价团员列表页面
    @RequestMapping(value = "/managerUserGetEvaluateList",method = RequestMethod.GET)
    public String managerUserGetEvaluateList(ModelMap map,@RequestParam long activityID){
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresentAndStatus(activityID, true, true, ActivityStatus.alreadyTerminate);

        map.addAttribute("userActivityList",userActivityList);
        return "user_activity_rate_list";
    }

    //获取成员对活动的评价
    @RequestMapping(value = "/managerGetEvaluateList",method = RequestMethod.GET)
    public String managerGetEvaluateList(ModelMap map,@RequestParam long activityID){
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByActivityIdAndAllowAndPresentAndStatus(activityID, true, true, ActivityStatus.alreadyTerminate);
        map.addAttribute("userActivityList",userActivityList);
        return "user_activity_comment_list";
    }

    //跳转到待评价团员评价页面
    @RequestMapping(value = "/managerUserStartEvaluateUser",method = RequestMethod.GET)
    public String managerUserStartEvaluateUser(ModelMap map,@RequestParam long userActivityID){
        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityID);

        map.addAttribute("userActivityEntity",userActivityEntity);
        return "user_activity_rate";
    }

    //申请者评价团员
    @RequestMapping(value = "/managerUserEvaluateUser",method = RequestMethod.POST)
    @ResponseBody
    public String managerUserEvaluateUser(@RequestParam long userActivityID,@RequestParam double rating,@RequestParam String comment){
        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityID);
        userActivityEntity.setManagerRating(rating);
        userActivityEntity.setManagerComment(comment);
        userActivityService.updateUserActivityEntity(userActivityEntity);

        return "ok";
    }

    //团员评价活动
    @RequestMapping(value = "/userEvaluateActivity",method = RequestMethod.POST)
    @ResponseBody
    public String userEvaluateActivity(@RequestParam long userActivityID,@RequestParam double rating,@RequestParam String comment){
        UserActivityEntity userActivityEntity = userActivityService.findUserFromActivity(getCurrentUser().getId(),userActivityID);
        userActivityEntity.setUserRating(rating);
        userActivityEntity.setUserComment(comment);
        userActivityService.updateUserActivityEntity(userActivityEntity);
        return "ok";
    }

    @RequestMapping(value = "/managerUserCheckUser",method = RequestMethod.GET)
    public String managerUserCheckUser(ModelMap map,@RequestParam long userActivityID){
        UserActivityEntity userActivityEntity = userActivityService.findUserActivityByID(userActivityID);
        long userID = userActivityEntity.getUserId();
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndAllowAndPresentAndStatus(userID,true,true,ActivityStatus.alreadyTerminate);
        for(int i=userActivityList.size()-1;i>=0;i--){
            if(userActivityList.get(i).getManagerRating()==null){
                userActivityList.remove(i);
            }
        }

        map.addAttribute("userActivityList",userActivityList);
        return "user_activity_info";
    }

    //申请已申请的活动页面（参与活动）
    @RequestMapping(value = "/alreadyApplyActivities", method = RequestMethod.GET)
    public String alreadyApplyActivities(ModelMap map) {
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndStatusAndAllow(getCurrentUser().getId(), ActivityStatus.waitingForApply, true);
        //倒序排列
        Collections.reverse(userActivityList);

        map.addAttribute("userActivityList", userActivityList);
        return "activities_yishenqin_volunteer";
    }

    //申请待执行的活动页面（参与活动）
    @RequestMapping(value = "/activitiesWaitingToExecute2", method = RequestMethod.GET)
    public String activitiesWaitingToExecute2(ModelMap map) {
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndStatusAndAllow(getCurrentUser().getId(), ActivityStatus.waitingForExecute, true);
        //倒序排列
        Collections.reverse(userActivityList);

        map.addAttribute("userActivityList", userActivityList);
        return "activities_daizhixing_volunteer";
    }

    //申请已完成的活动界面（参与活动）
    @RequestMapping(value = "/alreadyCompleteActivities2", method = RequestMethod.GET)
    public String alreadyCompleteActivities2(ModelMap map) {
        List<ViewUserActivityDetailEntity> userActivityList = viewUserActivityDetailDao.findViewUserActivityDetailEntitiesByUserIdAndStatusAndAllow(getCurrentUser().getId(), ActivityStatus.alreadyTerminate, true);
        //倒序排列
        Collections.reverse(userActivityList);

        map.addAttribute("userActivityList", userActivityList);
        return "activities_yiwancheng_volunteer";
    }

    @RequestMapping(value="/teamIndex",method = RequestMethod.GET)
    public String teamIndexView(ModelMap map, @RequestParam String teamId)
    {
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity=teamService.findById(id);
        UserEntity Manager=userService.findUserEntityById(teamEntity.getCreatorId());
        map.addAttribute("teamEntity",teamEntity);
        map.addAttribute("managerName",Manager.getName());
        return "team_index";
    }

    @RequestMapping(value="/teamMember",method = RequestMethod.GET)
    public String teamMemberView(ModelMap map, @RequestParam String teamId)
    {
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity=teamService.findById(id);
        UserEntity Manager=userService.findUserEntityById(teamEntity.getCreatorId());
        List<TeamUserEntity> userList=teamUserService.findAllUsersOfOneTeam(id);//only find user id
        List<UserEntity> memberList=new ArrayList<UserEntity>();
        for(int i=0;i<userList.size();i++)
        {
            if(!userList.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.isLocked))
            {
                UserEntity user=userService.findUserEntityById(userList.get(i).getUserId());
                memberList.add(user);
            }
        }
        map.addAttribute("userList",memberList);
        map.addAttribute("managerName",Manager.getName());
        map.addAttribute("teamId",teamId);
        return "team_member";
    }

    @RequestMapping(value="/myTeams",method = RequestMethod.GET)
    public String teamActivityView(ModelMap map)
    {
        long userId=getCurrentUser().getId();
        map.addAttribute("allTeamList",teamService.findTeamsByCreatorId(userId));
        return "my_teams";
    }

    @RequestMapping(value="/myTeamMember",method = RequestMethod.GET)
    public String myTeamMemberView(ModelMap map, @RequestParam String teamId)
    {
        long id = Long.parseLong(teamId);
        List<TeamUserEntity> userList=teamUserService.findAllUsersOfOneTeam(id);//only find user id
        List<UserEntity> memberList=new ArrayList<UserEntity>();
        List<UserEntity> ManagerList=new ArrayList<UserEntity>();
        List<UserEntity> lockedList=new ArrayList<UserEntity>();
        List<UserEntity> appliedList=new ArrayList<UserEntity>();
        for(int i=0;i<userList.size();i++)
        {
            UserEntity user=userService.findUserEntityById(userList.get(i).getUserId());
            if(userList.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.alreadyEntered)){
                if(!userList.get(i).isManager())
                    memberList.add(user);//已经加入成员
                else
                    ManagerList.add(user);
            }
            else if(userList.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.isLocked))
                lockedList.add(user);//锁定成员
            else if(userList.get(i).getStatus().equalsIgnoreCase(TeamUserStatus.inApplication))
                appliedList.add(user);
        }
        map.addAttribute("teamId",teamId);
        map.addAttribute("ManagerList",ManagerList);
        map.addAttribute("userList",memberList);
        map.addAttribute("lockedList",lockedList);
        map.addAttribute("appliedList",appliedList);
        return "my_team_member";
    }

    @RequestMapping(value="/lockMember",method=RequestMethod.POST)
    @ResponseBody
    public String blockTeamMember(@RequestParam String userId,@RequestParam String teamId)
    {
        return TeamManage(userId,teamId,"lock");
    }

    @RequestMapping(value="/UnlockMember",method=RequestMethod.POST)
    @ResponseBody
    public String UnblockTeamMember(@RequestParam String userId,@RequestParam String teamId)
    {
        return TeamManage(userId,teamId,"unlock");
    }

    @RequestMapping(value="/approveUser",method=RequestMethod.POST)
    @ResponseBody
    public String ApproveUser(@RequestParam String userId,@RequestParam String teamId)
    {
        return TeamManage(userId,teamId,"approve");
    }

    @RequestMapping(value="/demoteManager",method=RequestMethod.POST)
    @ResponseBody
    public String DemoteManager(@RequestParam String userId,@RequestParam String teamId)
    {
        return TeamManage(userId,teamId,"demote");
    }

    @RequestMapping(value="/promoteManager",method=RequestMethod.POST)
    @ResponseBody
    public String promteManager(@RequestParam String userId,@RequestParam String teamId)
    {
        return TeamManage(userId,teamId,"promote");
    }

    private String TeamManage(String userId,String teamId,String type){
        long t_id = Long.parseLong(teamId);
        long u_id = Long.parseLong(userId);
        try {
            TeamUserEntity teamUser=new TeamUserEntity();
            if(type.equalsIgnoreCase("lock")){//锁定
                teamUser = teamUserService.findByUserIdAndTeamIdAndStatus(u_id, t_id,TeamUserStatus.alreadyEntered);
                teamUser.setStatus(TeamUserStatus.isLocked);}
            else if(type.equalsIgnoreCase("unlock")){//解锁
                teamUser = teamUserService.findByUserIdAndTeamIdAndStatus(u_id, t_id,TeamUserStatus.isLocked);
                teamUser.setStatus(TeamUserStatus.alreadyEntered);}
            else if(type.equalsIgnoreCase("approve")){//同意加入
                teamUser = teamUserService.findByUserIdAndTeamIdAndStatus(u_id, t_id,TeamUserStatus.inApplication);
                teamUser.setStatus(TeamUserStatus.alreadyEntered);}
            else if(type.equalsIgnoreCase("demote")){//解除管理员
                teamUser = teamUserService.findByUserIdAndTeamIdAndStatus(u_id, t_id,TeamUserStatus.alreadyEntered);
                teamUser.setManager(false);
            }else if(type.equalsIgnoreCase("promote")){//提升管理员
                teamUser = teamUserService.findByUserIdAndTeamIdAndStatus(u_id, t_id,TeamUserStatus.alreadyEntered);
                teamUser.setManager(true);
            }else//非法操作
                return "failure";
            teamUserService.saveTeamUser(teamUser);
            System.out.println("The user " + userId + " has been locked");
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "failure";
        }
    }

    @RequestMapping(value="/historyActivity",method = RequestMethod.GET)
    public String teamHistoryActivity(ModelMap map, @RequestParam String teamId)
    {
        boolean isMember=false;
        long id = Long.parseLong(teamId);
        List<ActivityPublishEntity> activityList=activityPublishService.findAllByTeamIdAndStatus(id,"已结束");
        List<ActivityPublishEntity> publicActivity=new ArrayList<ActivityPublishEntity>();
        List<ActivityPublishEntity> privateActivity=new ArrayList<ActivityPublishEntity>();
        long userId=getCurrentUser().getId();
        //判断用户在这个团体内
        TeamUserEntity team=teamUserService.findByUserIdAndTeamIdAndStatus(userId,id,TeamUserStatus.alreadyEntered);
        if(team!=null)
            isMember=true;
        for(int i=0;i<activityList.size();i++)
        {
            if(activityList.get(i).isPublic())
                publicActivity.add(activityList.get(i));
            else
                privateActivity.add(activityList.get(i));
        }
        map.addAttribute("isMember",isMember);
        map.addAttribute("publicActivity",publicActivity);
        map.addAttribute("privateActivity",privateActivity);
        map.addAttribute("teamId",teamId);
        return "team_history";
    }

    @RequestMapping(value="/createPage",method = RequestMethod.GET)
    public String goToCreatePage(){
        return "create_team";
    }

    @RequestMapping(value="/createTeam",method = RequestMethod.POST)
    @ResponseBody
    public String createTeam(HttpServletRequest request,
                             @RequestParam(value = "file1", required = false) MultipartFile file,
                             String team_name,
                             String describe,
                             String team_location){
        String idImg ="";
        if(checkTeamNameExist(team_name))
            return "nameExist";
        if (file != null && !file.isEmpty()) {
            File uploadDir = new File(request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/teamHeadImg/");
            if (!uploadDir.exists()){
                uploadDir.mkdir();
            }
            String suffix1 = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
            idImg = team_name + "_headImg" + suffix1;
            String path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF/img/teamHeadImg/";
            File imgFile = new File(path, idImg);
            try {
                TeamEntity newTeam = new TeamEntity();
                newTeam.setName(team_name);
                newTeam.setAddress(team_location);
                newTeam.setHeadImg(idImg);
                file.transferTo(imgFile);
                long userId = getCurrentUser().getId();
                newTeam.setCreatorId(userId);
                newTeam.setCreateDate(new java.sql.Date(System.currentTimeMillis()));
                newTeam.setDeleted(false);
                newTeam.setDescription(describe);
                teamService.addTeamEntity(newTeam);
                return "success";
            } catch (Exception e) {
                return "failure";
            }
        }
        return "failure";
    }

    @RequestMapping(value="/viewTeamInfoPage",method = RequestMethod.GET)
    public String goToViewTeamInfoPage(ModelMap map,@RequestParam String teamId){
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity=teamService.findById(id);
        map.addAttribute("teamEntity",teamEntity);
        return "view_teamInfo";
    }

    @RequestMapping(value="/modifyPage",method = RequestMethod.GET)
    public String goToModifyPage(ModelMap map,@RequestParam String teamId){
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity=teamService.findById(id);
        map.addAttribute("teamEntity",teamEntity);
        return "modify_team";
    }

    @RequestMapping(value="/modifyTeam",method = RequestMethod.POST)
    @ResponseBody
    public String modifyTeam(@RequestParam String teamId,@RequestParam String teamName,@RequestParam String describe){
        try {
            TeamEntity team=teamService.findById(Long.parseLong(teamId));
            if(!team.getName().equalsIgnoreCase(teamName)){
                if(checkTeamNameExist(teamName))
                    return "nameExist";
                else
                    team.setName(teamName);
            }
            team.setDescription(describe);
            teamService.saveTeamEntity(team);
            return "success";
        }catch (Exception e) {
            return "failure";
        }
    }

    @RequestMapping(value="/deleteTeam",method = RequestMethod.POST)
    @ResponseBody
    public String deleteTeam(@RequestParam String teamId){
        try {
            TeamEntity Team=teamService.findById(Long.parseLong(teamId));
            Team.setDeleted(true);
            teamService.saveTeamEntity(Team);
            List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByTeamIdAndDeletedAndStatus(Team.getId(),false ,ActivityStatus.waitingForApply);
            for(int i=0;i<activityDetailList.size();i++)
            {
                ActivityPublishEntity activity=activityPublishService.findActivityPublishEntityByID(activityDetailList.get(i).getId());
                activity.setDeleted(true);
                activityPublishService.saveActivityPublishEntity(activity);
            }
            return "success";
        }catch (Exception e) {
            System.out.println(e.toString());
            return "failure";
        }
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

    private boolean checkTeamNameExist(String teamName){
        System.out.println("TeamName   "+teamName);
        TeamEntity team;
        team=teamService.findTeamByName(teamName);
        if(team==null) {
            return false;
        }
        else {
            return true;
        }
    }
}
