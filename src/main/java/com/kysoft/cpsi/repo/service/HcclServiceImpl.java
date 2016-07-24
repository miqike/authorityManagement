package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Hccl;
import com.kysoft.cpsi.repo.mapper.HcclMapper;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
		if(null==hccl.getId() || hccl.getId().equals("")) {
			hccl.setId(UUID.randomUUID().toString().replace("-", ""));
			hcclMapper.insert(hccl);
		}else{
			hcclMapper.updateByPrimaryKey(hccl);
		}
		String hcsxId = hccl.getHcsxId();
		recalcHcclForHcsx(hcsxId);
	}

	@Override
	public void delete(String id) {
		Hccl hccl = hcclMapper.selectByPrimaryKey(id);
		String hcsxId = hccl.getHcsxId();
		
		hcclMapper.deleteByPrimaryKey(id);
		recalcHcclForHcsx(hcsxId);
	}
	
	void recalcHcclForHcsx(String hcsxId) {
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
	public List<Map<String, Object>>  queryForTask2(String hcrwId) {
		return hcclMapper.queryForTask2(hcrwId);
	}

}
