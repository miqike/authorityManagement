package com.kysoft.cpsi.zcb.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kysoft.cpsi.zcb.entity.SctZcfzb;
import com.kysoft.cpsi.zcb.service.SaveService;
@RestController
@RequestMapping("/zcb")
public class SaveController {
	@Resource
	SaveService saveService;
	@RequestMapping("/saveZCFZ")
	public void saveZCFZ(SctZcfzb zcfz,Map<String , Object>map){
		
		saveService.saveZCFZ(zcfz);
		map.put("zcfz", zcfz);
	}
}
