package com.kysoft.cpsi.task.service;

import com.alibaba.fastjson.JSONArray;
import com.kysoft.cpsi.task.entity.Hcrw;

import java.util.List;
import java.util.Map;

public interface HcrwService {

    Integer getTaskInitStatus(String hcrwId);

    void initTaskItem(String hcrwId, int pullDataFlag);

    void pullData(String hcrwId);

    List<Map> getHcsxCode(String hcrwId);

    Hcrw getHcrwById(String hcrwId);

    void updateHcrw(Hcrw hcrw);

    List<Hcrw> queryForOrg(Map<String, Object> params);

	void accept(String planId, List<String> taskIds);
	
	void unAccept(String planId, List<String> taskIds);

	void setTaskStatus(String hcrwId, Integer statusCode);

	void updateDocReadyFlag(String hcrwId, int docReadyReportFlag);

	void auditHcrw(Hcrw hcrw);

	void cancelAuditHcrw(String hcrwId);

	void batchAuditHcrw(Hcrw hcrw);
	
	void batchCancelAuditHcrw(List<String> taskIds);

	JSONArray getHcsxJg(String hcrwId);

	Map<String,Object> exportExcelHcsxJg(String hcrwId) throws Exception;
}
