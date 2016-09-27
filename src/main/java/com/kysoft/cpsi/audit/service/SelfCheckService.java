package com.kysoft.cpsi.audit.service;

import java.io.InputStream;

public interface SelfCheckService {

	void uploadSelfCheckData(InputStream is, String hcrwId, String fileName) throws Exception;

}
