package com.kysoft.cpsi.audit.service;

import javax.servlet.http.HttpServletRequest;

public interface SelfCheckService {

	void uploadSelfCheckData(HttpServletRequest request, String hcrwId, String fileName) throws Exception;

}
