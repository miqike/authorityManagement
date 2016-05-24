package com.kysoft.cpsi.task.service;

public interface HcjhService {

	void saveCheckList(String hcjhId, String[] hcsxIds);

	void audit(String hcjhId, Integer shzt);

}
