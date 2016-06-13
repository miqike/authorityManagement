package com.kysoft.cpsi.repo.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.AuditItemComment;
import com.kysoft.cpsi.repo.service.AuditItemCommentService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/21")
public class CommentController extends BaseController {

	@Resource
	AuditItemCommentService auditItemCommentService;

	@RequestMapping(value = "/{hcsxId}/comment", method = RequestMethod.GET)
	public List<AuditItemComment> getComment(@PathVariable String hcsxId) {
		return auditItemCommentService.getComment(hcsxId);
	}
	
	@RequestMapping(value = "/comment", method = RequestMethod.POST)
	public Map<String, Object> addComment(AuditItemComment hccl) {
		
		Map<String, Object> result = Maps.newHashMap();
		try {
			auditItemCommentService.addComment(hccl);
			result.put(MESSAGE, "常见问题说明保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "常见问题说明保存失败");
		}
		return result;
	}
	

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
	}
}
