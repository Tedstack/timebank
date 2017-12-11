package com.blockchain.timebank.controller;

import com.blockchain.timebank.dao.ViewTeamDetailDao;
import com.blockchain.timebank.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/team")
public class TeamController {
    @Autowired
    private TeamService teamService;

    @Autowired
    ViewTeamDetailDao viewTeamDetailDao;

    @RequestMapping(value = "/teamList", method = RequestMethod.GET)
    public String teamListPage(ModelMap map) {
        map.addAttribute("list", viewTeamDetailDao.findAllByDeleted(false));
        return "choose_team";
    }
}
