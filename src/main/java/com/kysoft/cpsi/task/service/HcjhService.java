package com.kysoft.cpsi.task.service;

import java.util.Map;

import com.kysoft.cpsi.task.entity.Hcjh;

public interface HcjhService {

	void saveCheckList(String hcjhId, String[] hcsxIds);

	void audit(String hcjhId, Integer shzt);

	String save(Hcjh hcjh);

	Map<String, Object> testDblink();

	Map<String, Object> importDblink(String hcjhId);

}
