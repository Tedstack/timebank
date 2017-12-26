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
        List<Long> alreadyInTeamList = new ArrayList<Long>();
        List<Long> lockedInTeamList = new ArrayList<Long>();
        long currentId=getCurrentUser().getId();
        //从所有用户加入的团队中找到自己已经加入的团队
        for(int i=0;i<allTeamUser.size();i++){
            if(allTeamUser.get(i).getUserId()==currentId){
                if(!allTeamUser.get(i).isLocked() && !allTeamUser.get(i).isDeleted())
                    alreadyInTeamList.add(allTeamUser.get(i).getTeamId());
                else if( !allTeamUser.get(i).isDeleted())
                    lockedInTeamList.add(allTeamUser.get(i).getTeamId());
            }
        }
        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        map.addAttribute("alreadyInList", alreadyInTeamList);
        map.addAttribute("lockedList",lockedInTeamList);
        return "all_teams";
    }

    @RequestMapping(value = "/chosenTeam", method = RequestMethod.GET)
    public String chosenTeamListPage(ModelMap map) {
        List<TeamUserEntity> allTeamUser = teamUserService.findAll();
        List<Long> alreadyInTeamList = new ArrayList<Long>();
        long currentId=getCurrentUser().getId();
        for(int i=0;i<allTeamUser.size();i++){
            if(allTeamUser.get(i).getUserId()==currentId){
                if(!allTeamUser.get(i).isLocked() && !allTeamUser.get(i).isDeleted())
                    alreadyInTeamList.add(allTeamUser.get(i).getTeamId());
            }
        }
        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        map.addAttribute("alreadyInList", alreadyInTeamList);
        return "chosen_teams";
    }

    @RequestMapping(value = "/addUserToTeam", method = RequestMethod.POST)
    @ResponseBody
    public String addUserToTeam(ModelMap map, @RequestParam List<Long> teamIDList) {
        for(int i=0;i<teamIDList.size();i++){
                TeamUserEntity teamUser = new TeamUserEntity();
                teamUser.setTeamId(teamIDList.get(i));
                teamUser.setUserId(getCurrentUser().getId());
                teamUser.setLocked(true);
                teamUser.setDeleted(false);
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
        for(int i=0;i<teamIDList.size();i++){
            TeamUserEntity teamUser = teamUserService.findById(teamIDList.get(i));
            if (teamUser != null) {
                teamUser.setDeleted(true);
                teamUserService.saveTeamUser(teamUser);
                result.put("msg", "ok");
            } else
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
        List<TeamEntity> teamList = teamService.findTeamsByManagerUserId(user.getId());

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
    public String publishActivity(ModelMap map, @RequestParam long teamId, @RequestParam boolean isPublic, @RequestParam String activityName, @RequestParam String description, @RequestParam String beginTime
            ,@RequestParam String endTime ,@RequestParam String applyEndTime, @RequestParam int count, @RequestParam String address) {
        try {
            ActivityPublishEntity activityPublishEntity = new ActivityPublishEntity();
            activityPublishEntity.setTeamId(teamId);
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
        if(viewActivityPublishDetailEntity.getManagerUserId()==getCurrentUser().getId()){
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
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByManagerUserIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.waitingForApply);
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
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByManagerUserIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.waitingForExecute);
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
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByManagerUserIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.alreadyStart);
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

        return "ok";
    }

    //申请已完成团体活动页面（发布活动）
    @RequestMapping(value = "/alreadyCompleteActivities", method = RequestMethod.GET)
    public String alreadyCompleteActivities(ModelMap map) {
        List<ViewActivityPublishDetailEntity> activityDetailList = viewActivityPublishDetailDao.findViewActivityPublishDetailEntitiesByManagerUserIdAndDeletedAndStatus(getCurrentUser().getId(),false ,ActivityStatus.alreadyTerminate);
        //倒序排列
        Collections.reverse(activityDetailList);
        map.addAttribute("activityDetailList", activityDetailList);

        return "activities_yiwancheng_publish";
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
        UserEntity Manager=userService.findUserEntityById(teamEntity.getManagerUserId());
        map.addAttribute("teamEntity",teamEntity);
        map.addAttribute("managerName",Manager.getName());
        return "team_index";
    }

    @RequestMapping(value="/teamMember",method = RequestMethod.GET)
    public String teamMemberView(ModelMap map, @RequestParam String teamId)
    {
        long id = Long.parseLong(teamId);
        TeamEntity teamEntity=teamService.findById(id);
        UserEntity Manager=userService.findUserEntityById(teamEntity.getManagerUserId());
        List<TeamUserEntity> userList=teamUserService.findAllUsersOfOneTeam(id);//only find user id
        List<UserEntity> memberList=new ArrayList<UserEntity>();
        for(int i=0;i<userList.size();i++)
        {
            if(!userList.get(i).isLocked())
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
        map.addAttribute("allTeamList",teamService.findTeamsByManagerUserId(userId));
        return "my_teams";
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
}
