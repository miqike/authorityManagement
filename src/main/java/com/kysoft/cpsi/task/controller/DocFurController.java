package com.kysoft.cpsi.task.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.entity.Hcclmx;
import com.kysoft.cpsi.task.service.HcclmxService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/51")
public class DocFurController extends BaseController {

	@Resource
	HcclmxService hcclmxService;

	
	@RequestMapping(value = "/docFur/{id}", method = RequestMethod.DELETE)
	public Map<String, Object> delete(@PathVariable String id) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclmxService.delete2(id);
			result.put(MESSAGE, "附加检查材料删除成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "附加检查材料删除失败");
		}
		return result;
	}
	
	@RequestMapping(value = "/docFur", method = RequestMethod.POST)
	public Map<String, Object> addHcclmx(Hcclmx hcclmx) {
		
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclmxService.addHcclmx2(hcclmx);
			result.put(MESSAGE, "附加检查材料保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "附加检查材料保存失败");
		}
		return result;
	}
	
	
	
	@RequestMapping(value = "/docFur2", method = RequestMethod.POST)
	public Map<String, Object> updateHcclmx(Hcclmx hcclmx) {
		
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclmxService.updateHcclmx2(hcclmx);
			result.put(MESSAGE, "附加检查材料保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "附加检查材料保存失败");
		}
		return result;
	}
	
	
}
