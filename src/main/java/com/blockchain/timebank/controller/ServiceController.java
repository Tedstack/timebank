package com.blockchain.timebank.controller;

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
@RequestMapping("/service")
public class ServiceController {

    @Autowired
    ServiceService serviceService;

    //添加服务页面
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addPage(ModelMap map) {
        return "service_add";
    }

    //显示服务列表页面
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listPage(ModelMap map) {
        List<ServiceEntity> list = serviceService.findAllServiceEntity();
        map.addAttribute("list", list);
        return "service_list";
    }

    //添加服务提交
    @RequestMapping(value = "/add/submit", method = RequestMethod.POST)
    public String addSubmitPage(ModelMap map, @RequestParam String type, @RequestParam String name, @RequestParam double price) {
        System.out.println(type + " " + name);
        ServiceEntity serviceEntity = new ServiceEntity();
        serviceEntity.setType(type);
        serviceEntity.setName(name);
        serviceEntity.setPrice(price);
        serviceEntity.setUpdateTime(new Timestamp(System.currentTimeMillis()));
        serviceService.saveServiceEntity(serviceEntity);
        return "redirect:/service/list";
    }
}
