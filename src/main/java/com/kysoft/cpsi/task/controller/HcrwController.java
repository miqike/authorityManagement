package com.kysoft.cpsi.task.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.service.HcrwService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/51")
public class HcrwController extends BaseController {

	@Resource
	HcrwService hcrwService;

	@RequestMapping(value = "/{hcrwId}/initStatus", method = RequestMethod.GET)
	public Map<String, Object> getHcrwInitStatus(@PathVariable String hcrwId) {
		Map<String, Object> result = Maps.newHashMap();
		
		try {
			Integer count = hcrwService.getTaskInitStatus(hcrwId);
			result.put(MESSAGE, "检查列表项初始成功");
			result.put(STATUS, SUCCESS);
			result.put(DATA, count);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查列表项初始失败");
		}
		return result;
	}
	
	@RequestMapping(value = "/{hcrwId}/init", method = RequestMethod.POST)
	public Map<String, Object> init(@PathVariable String hcrwId) {
		Map<String, Object> result = Maps.newHashMap();
		
		try {
			hcrwService.initTaskItem(hcrwId);
			result.put(MESSAGE, "检查列表项初始成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查列表项初始失败");
		}
		return result;
	}
	
	@RequestMapping(value = "/{hcrwId}/pull", method = RequestMethod.GET)
	public Map<String, Object> pullData(@PathVariable String hcrwId) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcrwService.pullData(hcrwId);
			result.put(MESSAGE, "检查任务在线数据加载成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查任务在线数据加载失败");
		}
		return result;
	}
	
	@RequestMapping(value = "/{hcrwId}/hcsx", method = RequestMethod.GET)
	public List<Map> getHcsxCode(@PathVariable String hcrwId) {
		return hcrwService.getHcsxCode(hcrwId);
	}
	
}
