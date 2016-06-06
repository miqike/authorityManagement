package com.kysoft.cpsi.task.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.task.entity.Hcsxjg;
import com.kysoft.cpsi.task.entity.HcsxjgKey;
import com.kysoft.cpsi.task.mapper.HcsxjgMapper;

@Service("hcsxjgService")
public class HcsxjgServiceImpl implements HcsxjgService {

	@Resource
	HcsxjgMapper hcsxjgMapper;
	
	@Override
	public void start(String hcrwId, String hcsxId) {
		HcsxjgKey key = new HcsxjgKey();
		key.setHcrwId(hcrwId);
		key.setHcsxId(hcsxId);
		
		Hcsxjg hcsxjg = hcsxjgMapper.selectByPrimaryKey(key);
		hcsxjg.setHczt(2);
		hcsxjgMapper.updateByPrimaryKeySelective(hcsxjg);
	}

	@Override
	public void complete(String hcrwId, String hcsxId, Integer hcjg, String sm) {
		HcsxjgKey key = new HcsxjgKey();
		key.setHcrwId(hcrwId);
		key.setHcsxId(hcsxId);
		
		Hcsxjg hcsxjg = hcsxjgMapper.selectByPrimaryKey(key);
		hcsxjg.setHczt(3);
		hcsxjg.setHcjg(hcjg);
		hcsxjg.setSm(sm);
		hcsxjgMapper.updateByPrimaryKeySelective(hcsxjg);
	}

	

}
