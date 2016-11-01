package com.kysoft.cpsi.audit.service;

import java.io.InputStream;
import java.util.Map;

public interface SelfCheckService {

	void uploadSelfCheckData(InputStream is, String hcrwId, String fileName) throws Exception;
	Map<String,Object> getDXNHccl(Map<String,Object> params);//取鼎鑫诺的核查材料相关信息
	void judgeRepeatExcle(InputStream is, int row,int col,String fileName) throws Exception;
}
