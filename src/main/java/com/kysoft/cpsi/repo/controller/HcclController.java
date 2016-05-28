package com.kysoft.cpsi.repo.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.Hccl;
import com.kysoft.cpsi.repo.service.HcclService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/21")
public class HcclController extends BaseController {

	@Resource
	HcclService hcclService;

	@RequestMapping(value = "/{hcsxId}/hccl", method = RequestMethod.GET)
	public List<Hccl> getHcclCode(@PathVariable String hcsxId) {
		return hcclService.getHcclCode(hcsxId);
	}
	
	@RequestMapping(value = "/hccl", method = RequestMethod.POST)
	public Map<String, Object> addHccl(Hccl hccl) {
		
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclService.addHccl(hccl);
			result.put(MESSAGE, "核查材料保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "核查材料保存失败");
		}
		return result;
	}
}
