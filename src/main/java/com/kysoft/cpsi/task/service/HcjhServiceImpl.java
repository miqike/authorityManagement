package com.kysoft.cpsi.task.service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.entity.Hcjh;
import com.kysoft.cpsi.task.mapper.HcjhMapper;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.JhSxMapper;
import net.sf.husky.security.entity.User;
import net.sf.husky.utils.WebUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service("hcjhService")
public class HcjhServiceImpl implements HcjhService {

    @Resource
    HcjhMapper hcjhMapper;

    @Resource
    HcrwMapper hcrwMapper;

    @Resource
    JhSxMapper jhSxMapper;
    
    @Resource
    HcsxMapper hcsxMapper;

    @Override
    public void saveCheckList(String hcjhId, String[] hcsxIds) {
        if (hcsxIds.length > 0)
            jhSxMapper.insertBatch(hcjhId, hcsxIds);
    }

    @Override
    public void audit(String hcjhId, Integer shzt) {
//		shzt = shzt == 1? 2: 1;
        if (shzt == 1) {
            User user = WebUtils.getCurrentUser();
            hcjhMapper.updateAuditById(hcjhId, 2, user.getUserId(), user.getName());
        } else {
            hcjhMapper.updateAuditById(hcjhId, 1, "", "");
        }
    }

    @Override
    public String save(Hcjh hcjh) {
        if (hcjh.getId() != null && !hcjh.getId().equals("")) {
            hcjhMapper.updateByPrimaryKey(hcjh);
        } else {
            hcjh.setId(UUID.randomUUID().toString().replace("-", ""));
            hcjhMapper.insert(hcjh);
            
            insertAvailableAuditItem(hcjh.getId(), hcjh.getNr());
            /*Map<String, Object> param = Maps.newHashMap();
            param.put("hcjhId", hcjh.getId());
            jhSxMapper.insertAvailableAuditItem(param);*/
        }
        return hcjh.getId();
    }
    
    void insertAvailableAuditItem(String hcjhId, Integer nr) {
    	
    	List<String> hcsxIdList = hcsxMapper.selectAvailableAuditItemId(hcjhId, nr);
    	jhSxMapper.insertBatch(hcjhId, hcsxIdList.toArray());
    }

    @Override
    public Map<String, Object> testDblink(String hcjhId) {
        Map<String, Object> param = Maps.newHashMap();
        param.put("hcjhId", hcjhId);
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

	@Override
	public void reCalcAcceptStatus(String planId) {
		int yrls = hcrwMapper.selectYrlsByPlanId(planId);
		hcjhMapper.updateAcceptStatusByPrimaryKey(planId, yrls);
	}

	@Override
	public void deleteCheckList(String hcjhId, String[] hcsxIds) {
		 if (hcsxIds.length > 0)
	            jhSxMapper.deleteBatch(hcjhId, hcsxIds);
	}

	@Override
	public boolean validateGsjh(String gsjhbh) {
		int count = hcjhMapper.selectCountByGsjhbh(gsjhbh);
		return count == 0;
	}
}
