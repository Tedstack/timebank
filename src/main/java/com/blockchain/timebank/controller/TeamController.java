package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.ViewTeamDetailDao;
import com.blockchain.timebank.entity.TeamUserEntity;
import com.blockchain.timebank.entity.UserEntity;
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

import java.util.List;

@Controller
@RequestMapping("/team")
public class TeamController {
    @Autowired
    private TeamUserService teamUserService;

    @Autowired
    UserService userService;

    @Autowired
    ViewTeamDetailDao viewTeamDetailDao;

    @RequestMapping(value = "/teamList", method = RequestMethod.GET)
    public String teamListPage(ModelMap map) {
        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        return "choose_team";
    }

    @RequestMapping(value = "/addUserToTeam", method = RequestMethod.POST)
    @ResponseBody
    public String addUserToTeam(ModelMap map, @RequestParam List<Long> teamIDList) {
        for(int i=0;i<teamIDList.size();i++){
            TeamUserEntity teamUser = new TeamUserEntity();

            teamUser.setTeamId(teamIDList.get(i));
            teamUser.setUserId(getCurrentUser().getId());
            teamUserService.addUserToTeam(teamUser);
        }
        JSONObject result = new JSONObject();
        result.put("msg","ok");
        return result.toString();
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
