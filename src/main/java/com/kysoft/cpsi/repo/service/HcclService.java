package com.kysoft.cpsi.repo.service;

import java.util.List;
import java.util.Map;

import com.kysoft.cpsi.repo.entity.Hccl;

public interface HcclService {
	List<Hccl> getHcclCode(String hcsxId);

	void addHccl(Hccl hccl);

	void delete(String id);

	List<Map<String, Object>> queryForTask2(String hcrwId);
}
