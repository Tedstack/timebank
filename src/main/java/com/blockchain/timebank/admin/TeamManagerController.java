package com.blockchain.timebank.admin;

import com.blockchain.timebank.dao.ViewTeamDetailDao;
import com.blockchain.timebank.entity.TeamEntity;
import com.blockchain.timebank.entity.ViewTeamDetailEntity;
import com.blockchain.timebank.service.TeamService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class TeamManagerController {

    @Autowired
    TeamService teamService;

    @Autowired
    UserService userService;

    @Autowired
    ViewTeamDetailDao viewTeamDetailDao;

    @RequestMapping(value = "/teamList", method = RequestMethod.GET)
    public String teamListPage(ModelMap map) {
        map.addAttribute("list", viewTeamDetailDao.findAll());
        return "../admin/team_list";
    }

    @RequestMapping(value = "/teamAdd", method = RequestMethod.GET)
    public String teamAddPage(ModelMap map) {
        return "../admin/team_add";
    }

    @RequestMapping(value = "/teamAddSubmit", method = RequestMethod.POST)
    public String teamAddPage(ModelMap map, @RequestParam String name, @RequestParam String phone, @RequestParam String description) {
        if (phone.equals("") || name.equals("")) {
            map.addAttribute("error", "团队名称和手机号不能为空");
            return "../admin/team_add";
        }
        else if (userService.findUserEntityByPhone(phone) == null) {
            map.addAttribute("error", "添加失败，管理者手机号不存在！");
            return "../admin/team_add";
        }else {
            TeamEntity teamEntity = new TeamEntity();
            teamEntity.setName(name);
            teamEntity.setManagerUserId(userService.findUserEntityByPhone(phone).getId());
            teamEntity.setDescription(description);
            teamEntity.setCreateDate(new Date(System.currentTimeMillis()));
            teamService.saveTeamEntity(teamEntity);
            map.addAttribute("ok", "添加成功！");
            return "../admin/team_add";
        }
    }

}
