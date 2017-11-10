package com.blockchain.timebank.admin;

import com.blockchain.timebank.entity.ServiceEntity;
import com.blockchain.timebank.service.ServiceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.sql.Timestamp;
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
        return "../admin/service_list";
    }


    @RequestMapping(value = "/serviceAdd", method = RequestMethod.GET)
    public String serviceAddPage(ModelMap map) {
        map.addAttribute("types", serviceService.findAllServiceType());
        return "../admin/service_add";
    }

    @RequestMapping(value = "/serviceAddSubmit", method = RequestMethod.POST)
    public String serviceAddSubmit(ModelMap map, @RequestParam String type, @RequestParam String type_detail, @RequestParam String name, @RequestParam double price) {
        if (type.equals("自定义") && type_detail.equals("")) {
            map.addAttribute("types", serviceService.findAllServiceType());
            map.addAttribute("error", "输入的类型不能为空！");
            return "../admin/service_add";
        } else if (name.equals("") || type.equals("")) {
            map.addAttribute("types", serviceService.findAllServiceType());
            map.addAttribute("error", "输入的服务类型或者名称不能为空！");
            return "../admin/service_add";
        } else {
            ServiceEntity serviceEntity = new ServiceEntity();
            if (type.equals("自定义")) serviceEntity.setType(type_detail);
            else serviceEntity.setType(type);
            serviceEntity.setName(name);
            serviceEntity.setPrice(price);
            serviceEntity.setUpdateTime(new Timestamp(System.currentTimeMillis()));
            serviceService.saveServiceEntity(serviceEntity);
            map.addAttribute("types", serviceService.findAllServiceType());
            map.addAttribute("ok", "添加成功！");
            return "../admin/service_add";
        }
    }


}
