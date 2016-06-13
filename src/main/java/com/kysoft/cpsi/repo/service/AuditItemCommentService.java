package com.kysoft.cpsi.repo.service;

import java.util.List;

import com.kysoft.cpsi.repo.entity.AuditItemComment;

public interface AuditItemCommentService {

	List<AuditItemComment> getComment(String hcsxId);

	void addComment(AuditItemComment hccl);

	void delete(String id);

}
