package com.kysoft.cpsi.repo.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.service.AuditItemEnterpriseTypeService;
import net.sf.husky.web.controller.BaseController;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;

@RestController
@RequestMapping("/21")
public class AuditItemEnterpriseTypeController extends BaseController {

	@Resource
	AuditItemEnterpriseTypeService auditItemEnterpriseTypeService;
	
	@RequestMapping(value = "/auditItemEnterpriseType/{hcsxId}", method = RequestMethod.POST)
	public Map<String, Object> save( @RequestBody String[] ztlxId, @PathVariable String hcsxId) {
		
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
