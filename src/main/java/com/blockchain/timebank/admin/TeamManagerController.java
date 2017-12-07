package com.blockchain.timebank.admin;

import com.blockchain.timebank.dao.ViewTeamDetailDao;
import com.blockchain.timebank.dao.ViewTeamUserDetailDao;
import com.blockchain.timebank.entity.TeamEntity;
import com.blockchain.timebank.entity.ViewTeamDetailEntity;
import com.blockchain.timebank.entity.ViewTeamUserDetailEntity;
import com.blockchain.timebank.service.TeamService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Date;

@Controller
@RequestMapping("/admin")
public class TeamManagerController {

    @Autowired
    TeamService teamService;

    @Autowired
    UserService userService;

    @Autowired
    ViewTeamDetailDao viewTeamDetailDao;

    @Autowired
    ViewTeamUserDetailDao viewTeamUserDetailDao;

    @RequestMapping(value = "/teamList", method = RequestMethod.GET)
    public String teamListPage(ModelMap map) {
        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        return "../admin/team_list";
    }

    @RequestMapping(value = "/teamAdd", method = RequestMethod.GET)
    public String teamAddPage(ModelMap map) {
        return "../admin/team_add";
    }

    @RequestMapping(value = "/teamAddSubmit", method = RequestMethod.POST)
    public String teamAddSubmit(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String description) {
        if (phone.equals("") || name.equals("")) {
            map.addAttribute("error", "团队名称和手机号不能为空");
            return "../admin/team_add";
        }
        else if (userService.findUserEntityByPhone(phone) == null) {
            map.addAttribute("error", "添加失败，管理者手机号不存在！");
            return "../admin/team_add";
        }else {
            TeamEntity teamEntity = new TeamEntity();
            teamEntity.setDeleted(false);
            teamEntity.setName(name);
            teamEntity.setManagerUserId(userService.findUserEntityByPhone(phone).getId());
            teamEntity.setDescription(description);
            teamEntity.setCreateDate(new Date(System.currentTimeMillis()));
            teamService.saveTeamEntity(teamEntity);
            map.addAttribute("ok", "添加成功！");
            return "../admin/team_add";
        }
    }

    @RequestMapping(value = "/teamEdit", method = RequestMethod.GET)
    public String teamEditPage(ModelMap map, @RequestParam long teamId) {
        map.addAttribute("team",viewTeamDetailDao.findOne(teamId));
        return "../admin/team_edit";
    }

    @RequestMapping(value = "/teamEditSubmit", method = RequestMethod.POST)
    public String teamEditSubmit(ModelMap map, @RequestParam long teamId, @RequestParam String name, @RequestParam String phone, @RequestParam String description) {
        ViewTeamDetailEntity teamDetail=viewTeamDetailDao.findOne(teamId);
        teamDetail.setName(name);
        teamDetail.setManagerUserPhone(phone);
        teamDetail.setDescription(description);
        map.addAttribute("team",teamDetail);
        if (phone.equals("") || name.equals("")) {
            map.addAttribute("error", "团队名称和手机号不能为空");
            return "../admin/team_edit";
        }
        else if (userService.findUserEntityByPhone(phone) == null) {
            map.addAttribute("error", "修改失败，管理者手机号不存在！");
            return "../admin/team_edit";
        }else {
            TeamEntity teamEntity = teamService.findById(teamId);
            teamEntity.setDeleted(false);
            teamEntity.setName(name);
            teamEntity.setManagerUserId(userService.findUserEntityByPhone(phone).getId());
            teamEntity.setDescription(description);
            teamEntity.setCreateDate(new Date(System.currentTimeMillis()));
            teamService.saveTeamEntity(teamEntity);
            map.addAttribute("ok", "修改成功！");
            return "../admin/team_edit";
        }
    }


    @RequestMapping(value = "/teamDeleteSubmit", method = RequestMethod.POST)
    public String teamEditSubmit(ModelMap map, @RequestParam long teamId) {
        TeamEntity teamEntity = teamService.findById(teamId);
        teamEntity.setDeleted(true);
        teamService.saveTeamEntity(teamEntity);
        return "redirect:/admin/teamList";
    }


    @RequestMapping(value = "/teamUserList", method = RequestMethod.GET)
    public String teamUserListPage(ModelMap map, @RequestParam long teamId) {
        map.addAttribute("teamDetail", viewTeamDetailDao.findOne(teamId));
        map.addAttribute("list", viewTeamUserDetailDao.findAllByTeamId(teamId));
        return "../admin/team_user_list";
    }


    @RequestMapping(value = "/teamUserDeleteSubmit", method = RequestMethod.POST)
    public String teamUserDeleteSubmit(ModelMap map, @RequestParam long teamId, @RequestParam long userId) {
        // to do
        return "../admin/team_user_list";
    }

}
