package com.kysoft.cpsi.repo.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.service.AuditItemEnterpriseTypeService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/21")
public class AuditItemEnterpriseTypeController extends BaseController {

	@Resource
	AuditItemEnterpriseTypeService auditItemEnterpriseTypeService;
	
	@RequestMapping(value = "/auditItemEnterpriseType/{hcsxId}", method = RequestMethod.POST)
	public Map<String, Object> save( @RequestBody Integer[] ztlxId, @PathVariable String hcsxId) {
		
		Map<String, Object> result = Maps.newHashMap();
		try {
			auditItemEnterpriseTypeService.save(hcsxId, ztlxId);
			result.put(MESSAGE, "保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "保存失败");
		}
		return result;
	}
	
/*
	@RequestMapping(value = "/comment/{id}", method = RequestMethod.DELETE)
	public Map<String, Object> delete(@PathVariable String id) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			auditItemCommentService.delete(id);
			result.put(MESSAGE, "检查材料删除成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查材料删除失败");
		}
		return result;
	}*/
}
