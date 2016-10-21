package com.kysoft.cpsi.task.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.entity.Hcclmx;
import com.kysoft.cpsi.task.service.HcclmxService;
import net.sf.husky.web.controller.BaseController;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
@RequestMapping("/51")
public class HcclmxController extends BaseController {

	@Resource
	HcclmxService hcclmxService;

	
	@RequestMapping(value = "/hcclmx/{id}", method = RequestMethod.DELETE)
	public Map<String, Object> delete(@PathVariable String id) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclmxService.delete(id);
			result.put(MESSAGE, "检查材料删除成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查材料删除失败");
		}
		return result;
	}
	
	@RequestMapping(value = "/hcclmx", method = RequestMethod.POST)
	public Map<String, Object> addHcclmx(Hcclmx hcclmx) {
		
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclmxService.addHcclmx(hcclmx);
			result.put(MESSAGE, "检查材料保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查材料保存失败");
		}
		return result;
	}

	@RequestMapping(value = "/js/hcclmx", method = RequestMethod.POST)
	public Map<String, Object> addHcclmxJs(Hcclmx hcclmx) {

		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclmxService.addHcclmxJs(hcclmx);
			result.put(MESSAGE, "检查材料保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查材料保存失败");
		}
		return result;
	}

	@RequestMapping(value = "/hcclmx/dxnMongoId", method = RequestMethod.GET)
	public Map<String, Object> getDxnMongoId(String hcrwId,String dxnType) {

		Map<String, Object> result = Maps.newHashMap();
		try {
			String mongoId=hcclmxService.getDxnMongoIdByHcrwId(hcrwId,dxnType);
			result.put(MESSAGE, "查询成功");
			result.put(STATUS, SUCCESS);
			result.put(DATA, mongoId);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "查询失败");
		}
		return result;
	}
}
