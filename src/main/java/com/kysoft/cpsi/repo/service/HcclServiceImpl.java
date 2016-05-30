package com.kysoft.cpsi.repo.service;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.Hccl;
import com.kysoft.cpsi.repo.mapper.HcclMapper;

@Service("hcclService")
public class HcclServiceImpl implements HcclService {

	@Resource 
	HcclMapper hcclMapper;

	@Override
	public List<Hccl> getHcclCode(String hcsxId) {
		return hcclMapper.selectByHcsxId(hcsxId);
	}

	@Override
	public void addHccl(Hccl hccl) {
		hccl.setId(UUID.randomUUID().toString().replace("-", ""));
		hcclMapper.insert(hccl);
	}

	@Override
	public void delete(String id) {
		hcclMapper.deleteByPrimaryKey(id);
	}

}
