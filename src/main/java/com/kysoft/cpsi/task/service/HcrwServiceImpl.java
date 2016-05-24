package com.kysoft.cpsi.task.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.entity.Hcsxjg;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.HcsxjgMapper;

@Service("hcrwService")
public class HcrwServiceImpl implements HcrwService {
	
	@Resource 
	HcrwMapper hcrwMapper;
	
	@Resource 
	HcsxMapper hcsxMapper;
	
	@Resource 
	HcsxjgMapper hcsxjgMapper;

	@Override
	public void initTaskItem(String hcrwId) {
		List<Hcsx> hcsxList = hcsxMapper.selectByTaskId(hcrwId);
		for(Hcsx hcsx: hcsxList) {
			Hcsxjg hcsxjg = new Hcsxjg();
			hcsxjg.setHcrwId(hcrwId);
			hcsxjg.setHcsxId(hcsx.getId());
			hcsxjg.setName(hcsx.getName());
			hcsxjg.setHcfs(hcsx.getType());
			hcsxjg.setHczt(0);
			hcsxjg.setSm(hcsx.getDescript());
			hcsxjgMapper.insert(hcsxjg);
		}
	}

}
