package com.kysoft.cpsi.task.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.service.HcjhService;
import com.kysoft.kteam.leave.domain.Leave;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/31")
public class HcjhController extends BaseController {

	@Resource
	HcjhService hcjhService;

	@RequestMapping(value = "", method = RequestMethod.POST)
	public Map<String, Object> save(Leave leave) {
		Map<String, Object> result = Maps.newHashMap();
		/*try {
			hcjhService.askForLeave(leave);
			result.put(MESSAGE, "保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "保存失败");
		}*/
		return result;
	}
}
