package com.blockchain.timebank.admin;

import com.blockchain.timebank.dao.ViewRequestDetailDao;
import com.blockchain.timebank.entity.RequestEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.entity.ViewPublishDetailEntity;
import com.blockchain.timebank.entity.ViewRequestDetailEntity;
import com.blockchain.timebank.service.RequestService;
import com.blockchain.timebank.service.ServiceService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class RequestManageController {
    @Autowired
    ServiceService serviceService;

    @Autowired
    RequestService requestService;

    @Autowired
    UserService userService;

    @Autowired
    private ViewRequestDetailDao viewRequestDetailDao;

    @RequestMapping(value = "/requestList", method = RequestMethod.GET)
    public String requestListPage(ModelMap map) {
        List<ViewRequestDetailEntity> viewRequestDetailEntities = (List<ViewRequestDetailEntity>) viewRequestDetailDao.findAll();
        map.addAttribute("list", viewRequestDetailEntities);
        return "../admin/request_list";

        /*List<ViewPublishDetailEntity> list = (List<ViewPublishDetailEntity>)viewPublishDetailDao.findAll();
        map.addAttribute("list", list);
        map.addAttribute("link_publishView","1");
        return "../admin/publish_list";*/
    }

    @RequestMapping(value = "/requestAdd", method = RequestMethod.GET)
    public String requestAddPage(ModelMap map) {
        map.addAttribute("service_list", serviceService.findAllServiceEntity());
        return "../admin/request_add";
    }

    //发布服务提交接口
    @RequestMapping(value = "/requestAddSubmit", method = RequestMethod.POST)
    public String requestAddSubmit(ModelMap map, @RequestParam String requestType, @RequestParam String requestName, @RequestParam String phone, @RequestParam String description, @RequestParam String beginTime, @RequestParam String endTime, @RequestParam BigDecimal price, @RequestParam String address) {
        try {
            RequestEntity requestEntity = new RequestEntity();
            UserEntity requestUser = userService.findUserEntityByPhone(phone);
            requestEntity.setServiceId(serviceService.findFirstByTypeAndName(requestType, requestName).getId());
            requestEntity.setUserId(requestUser.getId());
            requestEntity.setDescription(description);
            Date beginDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(beginTime);//SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
            Date endDateTime = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(endTime);
            requestEntity.setBeginTime(new Timestamp(beginDateTime.getTime()));
            requestEntity.setEndTime(new Timestamp(endDateTime.getTime()));
            requestEntity.setPrice(price);
            requestEntity.setAddress(address);
            requestEntity.setRequesterName(requestUser.getName());
            requestEntity.setRequesterPhone(requestUser.getPhone());
            requestEntity.setPayway(1);

            try{
                requestService.saveRequestEntity(requestEntity);
            }catch (Exception e){
                e.printStackTrace();
            }
            //requestService.saveRequestEntity(requestEntity);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/admin/requestList";
    }
}
