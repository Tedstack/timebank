package com.blockchain.timebank.admin;

import com.blockchain.timebank.dao.ViewPublishDetailDao;
import com.blockchain.timebank.entity.PublishEntity;
import com.blockchain.timebank.entity.ServiceEntity;
import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import com.blockchain.timebank.service.PublishService;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class PublishManageController {

    @Autowired
    ViewPublishDetailDao viewPublishDetailDao;

    @Autowired
    ServiceService serviceService;

    @Autowired
    UserService userService;

    @Autowired
    PublishService publishService;

    @RequestMapping(value = "/publishList", method = RequestMethod.GET)
    public String publishListPage(ModelMap map) {
        List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>)viewPublishDetailDao.findAll();
        map.addAttribute("list", list);
        return "../admin/publish_list";
    }

    @RequestMapping(value = "/publishAdd", method = RequestMethod.GET)
    public String publishAddPage(ModelMap map) {
        map.addAttribute("service_list", serviceService.findAllServiceEntity());
        return "../admin/publish_add";
    }

    //发布服务提交接口
    @RequestMapping(value = "/publishAddSubmit", method = RequestMethod.POST)
    public String publishAddSubmit(ModelMap map, @RequestParam String serviceType, @RequestParam String serviceName, @RequestParam String phone, @RequestParam String description, @RequestParam String beginDate, @RequestParam String endDate, @RequestParam double price, @RequestParam String address) {
        try {
            PublishEntity publishEntity = new PublishEntity();
            publishEntity.setAddress(address);
            publishEntity.setDescription(description);
            publishEntity.setUserId(userService.findUserEntityByPhone(phone).getId());
            publishEntity.setPrice(price);
            publishEntity.setServiceId(serviceService.findFirstByTypeAndName(serviceType, serviceName).getId());//serviceId
            Date beginTime = new SimpleDateFormat("yyyy-MM-dd").parse(beginDate);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            Date endTime = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
            publishEntity.setBeginDate(new Timestamp(beginTime.getTime()));
            publishEntity.setEndDate(new Timestamp(endTime.getTime()));
            publishService.savePublishEntity(publishEntity);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        map.addAttribute("type", serviceType);
        return "redirect:/admin/publishList";
    }

}
