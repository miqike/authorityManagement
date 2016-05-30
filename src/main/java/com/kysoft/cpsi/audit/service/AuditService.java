package com.kysoft.cpsi.audit.service;

import java.util.Map;

import com.kysoft.cpsi.audit.entity.MailVerifyException;

public interface AuditService {

	void sentVerifyMail(String hcrwId, String hcsxId, String mail) throws MailVerifyException;

	void verifyMail(String id);

	Map<String, Object> getCompareInfo(String hcrwId, String hcsxId);

}
