package com.kysoft.cpsi.repo.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.Hccl;
import com.kysoft.cpsi.repo.mapper.HcclMapper;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;

@Service("hcclService")
public class HcclServiceImpl implements HcclService {

	@Resource 
	HcclMapper hcclMapper;
	
	@Resource 
	HcsxMapper hcsxMapper;

	@Override
	public List<Hccl> getHcclCode(String hcsxId) {
		return hcclMapper.selectByHcsxId(hcsxId);
	}

	@Override
	public void addHccl(Hccl hccl) {
		hccl.setId(UUID.randomUUID().toString().replace("-", ""));
		hcclMapper.insert(hccl);
		String hcsxId = hccl.getHcsxId();
		List<Hccl> hcclList = hcclMapper.selectByHcsxId(hcsxId);
		StringBuilder hcclInHcsx = new StringBuilder();
		for(int i=0; i<hcclList.size(); i++) {
			hcclInHcsx.append(hcclList.get(i).getName());
			if(i<(hcclList.size()-1)) {
				hcclInHcsx.append(",");
			}
		}
		
		hcsxMapper.updateHcclByPrimaryKey(hcsxId, hcclInHcsx.toString());
	}

	@Override
	public void delete(String id) {
		hcclMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Map<String, Object>>  queryForTask2(String hcrwId) {
		return hcclMapper.queryForTask2(hcrwId);
	}

}
