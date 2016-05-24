package com.kysoft.cpsi.audit.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.audit.service.AuditService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/audit")
public class AuditController extends BaseController {

	@Resource
	AuditService auditService;

	@RequestMapping(value = "/sentVerifyMail", method = RequestMethod.POST)
	public Map<String, Object> sentVerifyMail(String hcrwId,
			String hcsxId,
			String mail) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			auditService.sentVerifyMail(hcrwId, hcsxId, mail);
			result.put(MESSAGE, "保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "保存失败");
		}
		return result;
	}
	
	
	
}
