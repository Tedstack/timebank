package com.blockchain.timebank.admin;

import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class PublishManageController {

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @RequestMapping(value = "/publishList", method = RequestMethod.GET)
    public String recordListPage(ModelMap map) {
        List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>)viewPublishDetailDao.findAll();
        map.addAttribute("list", list);
        return "../admin/publish_list";
    }

}
