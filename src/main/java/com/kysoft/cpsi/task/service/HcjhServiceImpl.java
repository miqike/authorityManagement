package com.kysoft.cpsi.task.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.entity.Hcjh;
import com.kysoft.cpsi.task.mapper.HcjhMapper;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.JhSxMapper;

import net.sf.husky.attachment.utils.DownloadUtils;
import net.sf.husky.exception.BaseException;
import net.sf.husky.log.MongoLogger;
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
    public void dispatch(String hcjhId, Integer xdzt) {
    	if (xdzt == 0) {
    		User user = WebUtils.getCurrentUser();
    		hcjhMapper.updateDispatchById(hcjhId, 1, user.getUserId(), user.getName());
    		hcrwMapper.updateDispatchByPlanId(hcjhId, 1);
    		hcrwMapper.updateRequiredDocByPlanId(hcjhId);
    		MongoLogger.info("task", "用户下达核查计划", null, hcjhId);
    	} else {
    		int yrls = hcrwMapper.selectYrlsByPlanId(hcjhId);
    		if(yrls == 0) {
    			hcjhMapper.updateDispatchById(hcjhId, 0, "", "");
    			hcrwMapper.updateDispatchByPlanId(hcjhId, 0);
    			MongoLogger.info("task", "用户取消下达核查计划", null, hcjhId);
    		} else {
    			throw new BaseException("下级单位已经认领,不能进行取消下达操作");
    		}
    	}
    }

    @Override
    public String save(Hcjh hcjh) {
        if (hcjh.getId() != null && !hcjh.getId().equals("")) {
        	MongoLogger.info("task", "用户对计划进行修改", null, hcjh.getId());
            hcjhMapper.updateByPrimaryKey(hcjh);
        } else {
            hcjh.setId(UUID.randomUUID().toString().replace("-", ""));
            MongoLogger.info("task", "用户创建新计划", null, hcjh.getId());
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
    	MongoLogger.info("task", "系统为新计划添加核查事项: " + hcsxIdList.size(), null, hcjhId);
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
		 MongoLogger.info("task", "用户删除核查事项" + hcsxIds.length, null, hcjhId);
		 
	}

	@Override
	public boolean validateGsjh(String gsjhbh) {
		int count = hcjhMapper.selectCountByGsjhbh(gsjhbh);
		return count == 0;
	}

	@Override
	public void addEnterprise(String hcjhId, String[] zchs) {
		User zfry = WebUtils.getCurrentUser();
		Map<String, Object> param = Maps.newHashMap();
        param.put("hcjhId", hcjhId);
        param.put("zchList", StringUtils.join(zchs, ","));
        param.put("zfryId", zfry.getUserId());
        param.put("zfryName", zfry.getName());
        hcjhMapper.addTask(param);
        MongoLogger.info("task", "用户为日常监管计划增加被核查单位: " + zchs.length, null, hcjhId);
	}
	
	@Override
	public void removeEnterprise(String hcjhId, String[] hcrwIds) {
		Map<String, Object> param = Maps.newHashMap();
		param.put("hcjhId", hcjhId);
		param.put("hcrwList", StringUtils.join(hcrwIds, ","));
		hcjhMapper.removeTask(param);
		MongoLogger.info("task", "用户从日常监管计划中移除被核查单位: " + hcrwIds.length, null, hcjhId);
	}
	

	@Override
	public void delete(String hcjhId) {
		hcjhMapper.deleteByPrimaryKey(hcjhId);
		MongoLogger.info("task", "用户删除核查计划", null,hcjhId);
	}

	@Override
	public void updateStatement(String hcjhId, String statement) {
		Hcjh hcjh = hcjhMapper.selectByPrimaryKey(hcjhId);
		
		if(null != hcjh.getStatement()) {
			DownloadUtils.mongoDelete(hcjh.getStatement());
		}
		
		hcjhMapper.updateStatement(hcjhId, statement);
		
	}
}
