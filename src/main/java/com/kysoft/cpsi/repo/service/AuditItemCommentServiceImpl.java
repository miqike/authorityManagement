package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.AuditItemComment;
import com.kysoft.cpsi.repo.mapper.AuditItemCommentMapper;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service("auditItemCommentService")
public class AuditItemCommentServiceImpl implements AuditItemCommentService {

	@Resource 
	AuditItemCommentMapper auditItemCommentMapper;
	
	@Resource 
	HcsxMapper hcsxMapper;

	@Override
	public List<AuditItemComment> getComment(String hcsxId) {
		return auditItemCommentMapper.selectByHcsxId(hcsxId);
	}

	@Override
	public void addComment(AuditItemComment comment) {
		if(null==comment.getId() || comment.getId().equals("")) {
			comment.setId(UUID.randomUUID().toString().replace("-", ""));
			auditItemCommentMapper.insert(comment);
		}else{
			auditItemCommentMapper.updateByPrimaryKey(comment);
		}
	}

	@Override
	public void delete(String id) {
		auditItemCommentMapper.deleteByPrimaryKey(id);
	}

}
