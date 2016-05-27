package com.kysoft.cpsi.task.service;

import java.util.List;
import java.util.Map;

import com.kysoft.cpsi.task.entity.Hcclmx;

public interface HcrwService {

	void initTaskItem(String hcrwId);

	void pullData(String hcrwId);

	List<Map> getHcsxCode(String hcrwId);

	void addHccl(Hcclmx hcclmx);


}
