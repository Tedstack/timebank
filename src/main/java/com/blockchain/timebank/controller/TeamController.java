package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.ViewActivityPublishDetailDao;
import com.blockchain.timebank.dao.ViewTeamDetailDao;
import com.blockchain.timebank.entity.*;
import com.blockchain.timebank.service.ActivityPublishService;
import com.blockchain.timebank.service.TeamService;
import com.blockchain.timebank.service.TeamUserService;
import com.blockchain.timebank.service.UserService;
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

    @RequestMapping(value = "/teamList", method = RequestMethod.GET)
    public String teamListPage(ModelMap map) {
        List<TeamUserEntity> allTeamUser = teamUserService.findAll();
        List<Long> alreadyInTeamList = new ArrayList<Long>();

        //从所有用户加入的团队中找到自己已经加入的团队
        for(int i=0;i<allTeamUser.size();i++){
            if(allTeamUser.get(i).getUserId()==getCurrentUser().getId()){
                alreadyInTeamList.add(allTeamUser.get(i).getTeamId());
            }
        }

        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        map.addAttribute("alreadyInList", alreadyInTeamList);
        return "choose_team";
    }

    @RequestMapping(value = "/addUserToTeam", method = RequestMethod.POST)
    @ResponseBody
    public String addUserToTeam(ModelMap map, @RequestParam List<Long> teamIDList) {
        List<TeamUserEntity> allTeamUser = teamUserService.findAll();
        for(int i=0;i<teamIDList.size();i++){
            boolean add = true;
            for(int j=0;j<allTeamUser.size();j++){
                //判断要加入的团队是否之前已经加入过
                if((allTeamUser.get(j).getTeamId()==teamIDList.get(i))&&(allTeamUser.get(j).getUserId()==getCurrentUser().getId())){
                    add = false;
                    break;
                }
            }

            if(add){
                TeamUserEntity teamUser = new TeamUserEntity();

                teamUser.setTeamId(teamIDList.get(i));
                teamUser.setUserId(getCurrentUser().getId());
                teamUserService.addUserToTeam(teamUser);
            }
        }
        JSONObject result = new JSONObject();
        result.put("msg","ok");
        return result.toString();
    }

    // 所有团队活动列表页面
    @RequestMapping(value = "/teamActivities", method = RequestMethod.GET)
    public String activities(ModelMap map) {
        map.addAttribute("activityList",activityPublishService.findAllByDeleted(false));
        return "team_activities";
    }

    // 团队活动详情页面
    @RequestMapping(value = "/teamActivityDetails", method = RequestMethod.GET)
    public String teamActivityDetails(ModelMap map, @RequestParam long activityID) {
        ViewActivityPublishDetailEntity activityPublishDetailEntity = viewActivityPublishDetailDao.findOne(activityID);
        //ActivityPublishEntity activity = activityPublishService.findActivityPublishEntityByID(activityID);
        map.addAttribute("activity",activityPublishDetailEntity);
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
