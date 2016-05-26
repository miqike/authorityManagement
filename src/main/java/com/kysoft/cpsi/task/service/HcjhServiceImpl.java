package com.kysoft.cpsi.task.service;

import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.entity.Hcjh;
import com.kysoft.cpsi.task.mapper.HcjhMapper;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.JhSxMapper;

import net.sf.husky.security.entity.User;
import net.sf.husky.utils.WebUtils;

@Service("hcjhService")
public class HcjhServiceImpl implements HcjhService {
	
	@Resource 
	HcjhMapper hcjhMapper;
	
	@Resource 
	HcrwMapper hcrwMapper;
	
	@Resource 
	JhSxMapper jhSxMapper;

	@Override
	public void saveCheckList(String hcjhId, String[] hcsxIds) {
		// TODO Auto-generated method stub
        if(hcsxIds.length > 0)
        	jhSxMapper.insertBatch(hcjhId, hcsxIds);
	}

	@Override
	public void audit(String hcjhId, Integer shzt) {
//		shzt = shzt == 1? 2: 1;
		if(shzt == 1) {
			User user = WebUtils.getCurrentUser();
			hcjhMapper.updateAuditById(hcjhId, 2, user.getUserId(), user.getName());
		} else {
			hcjhMapper.updateAuditById(hcjhId, 1, "", "");
		}
	}

	@Override
	public String save(Hcjh hcjh) {
		if(hcjh.getId() != null) {
			hcjhMapper.updateByPrimaryKey(hcjh);
		} else {
			hcjh.setId(UUID.randomUUID().toString().replace("-", ""));
			hcjhMapper.insert(hcjh);
		}
		return hcjh.getId();
	}

	@Override
	public Map<String, Object> testDblink() {
		Map<String, Object> param = Maps.newHashMap();
		hcjhMapper.testDblink(param);
		return param;
	}

	@Override
	public Map<String, Object> importDblink(String hcjhId) {
		Map<String, Object> param = Maps.newHashMap();
		param.put("hcjhId", hcjhId);
		hcjhMapper.importDblink(param);
		Integer hcrwsl = hcrwMapper.selectCountByPlanId(hcjhId);
		param.put("hcrws", hcrwsl);
		return param;
	}

}
