package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.task.entity.JsHcsxjg;
import com.kysoft.cpsi.task.entity.JsHcsxjgKey;
import com.kysoft.cpsi.task.mapper.JsHcsxjgMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("jsHcsxjgService")
public class JsHcsxjgServiceImpl implements JsHcsxjgService {

	@Resource
	JsHcsxjgMapper jsHcsxjgMapper;
	
	@Override
	public void start(String hcrwId, String hcsxId) {
		JsHcsxjgKey key = new JsHcsxjgKey();
		key.setHcrwId(hcrwId);
		key.setHcsxId(hcsxId);

		JsHcsxjg jsHcsxjg = jsHcsxjgMapper.selectByPrimaryKey(key);
		jsHcsxjg.setHczt(2);
		jsHcsxjgMapper.updateByPrimaryKeySelective(jsHcsxjg);
	}

	@Override
	public void complete(String hcrwId, String hcsxId, Integer hcjg, String sm) {
		JsHcsxjgKey key = new JsHcsxjgKey();
		key.setHcrwId(hcrwId);
		key.setHcsxId(hcsxId);
		
		JsHcsxjg jsHcsxjg = jsHcsxjgMapper.selectByPrimaryKey(key);
		jsHcsxjg.setHczt(3);
		jsHcsxjg.setHcjg(hcjg);
		jsHcsxjg.setSm(sm);
		jsHcsxjgMapper.updateByPrimaryKeySelective(jsHcsxjg);
	}

	

}
