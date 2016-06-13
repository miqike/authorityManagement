package com.kysoft.cpsi.repo.service;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.AuditItemComment;
import com.kysoft.cpsi.repo.entity.Hccl;
import com.kysoft.cpsi.repo.mapper.AuditItemCommentMapper;
import com.kysoft.cpsi.repo.mapper.HcclMapper;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;

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
		comment.setId(UUID.randomUUID().toString().replace("-", ""));
		auditItemCommentMapper.insert(comment);
	}

	@Override
	public void delete(String id) {
		auditItemCommentMapper.deleteByPrimaryKey(id);
	}

}
