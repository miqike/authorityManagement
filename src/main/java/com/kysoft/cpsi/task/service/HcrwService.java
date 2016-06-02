package com.kysoft.cpsi.task.service;

import java.util.List;
import java.util.Map;

public interface HcrwService {

	Integer getTaskInitStatus(String hcrwId);

	void initTaskItem(String hcrwId);

	void pullData(String hcrwId);

	List<Map> getHcsxCode(String hcrwId);


}
