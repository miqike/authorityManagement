package com.kysoft.cpsi.repo.service;

import java.util.List;

import com.kysoft.cpsi.repo.entity.Hccl;

public interface HcclService {
	List<Hccl> getHcclCode(String hcsxId);

	void addHccl(Hccl hccl);

	void delete(String id);
}
