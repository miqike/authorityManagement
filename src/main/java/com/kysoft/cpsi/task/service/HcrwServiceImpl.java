package com.kysoft.cpsi.task.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
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
			hcsxjg.setHcfs(hcsx.getHcff());
			hcsxjg.setPage(hcsx.getPage());
			hcsxjg.setHczt(1);
			hcsxjgMapper.insert(hcsxjg);
		}
	}

	@Override
	public void pullData(String hcrwId) {
		Map<String, Object> param = Maps.newHashMap();
		param.put("hcrwId", hcrwId);
		hcrwMapper.pullData(param);
	}

}
