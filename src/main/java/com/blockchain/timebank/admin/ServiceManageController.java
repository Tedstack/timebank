package com.blockchain.timebank.admin;

import com.blockchain.timebank.entity.ServiceEntity;
import com.blockchain.timebank.service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class ServiceManageController {

    @Autowired
    ServiceService serviceService;

    @RequestMapping(value = "/serviceList", method = RequestMethod.GET)
    public String serviceListPage(ModelMap map) {
        List<ServiceEntity> list_service = serviceService.findAllServiceEntity();
        map.addAttribute("list_service", list_service);
        return "../admin/service_manage";
    }
}
