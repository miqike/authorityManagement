package com.kysoft.cpsi.task.service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.entity.Hcsxjg;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.HcsxjgMapper;

import net.sf.husky.security.entity.User;
import net.sf.husky.utils.WebUtils;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("hcrwService")
public class HcrwServiceImpl implements HcrwService {

    @Resource
    HcrwMapper hcrwMapper;

    @Resource
    HcsxMapper hcsxMapper;

    @Resource
    HcsxjgMapper hcsxjgMapper;
    
    @Resource
    HcjhService hcjhService;

    @Override
    public void initTaskItem(String hcrwId, int pullDataFlag) {
        List<Hcsx> hcsxList = hcsxMapper.selectByTaskId(hcrwId);
        for (Hcsx hcsx : hcsxList) {
            Hcsxjg hcsxjg = new Hcsxjg();
            hcsxjg.setHcrwId(hcrwId);
            hcsxjg.setHcsxId(hcsx.getId());
            hcsxjg.setName(hcsx.getName());
            hcsxjg.setHcfs(hcsx.getHcff());
            hcsxjg.setPage(hcsx.getPage());
            hcsxjg.setHclx(hcsx.getHclx());
            hcsxjg.setHczt(1);
            hcsxjgMapper.insert(hcsxjg);
        }
        if(pullDataFlag == 1) {
        	pullData(hcrwId);
        }
    }

    @Override
    public void pullData(String hcrwId) {
        Map<String, Object> param = Maps.newHashMap();
        param.put("hcrwId", hcrwId);
        hcrwMapper.pullData(param);
        hcrwMapper.updateLoadedByPrimaryKey(hcrwId);
        
        //TODO 处理错误消息..
    }

    @Override
    public List<Map> getHcsxCode(String hcrwId) {
        return hcsxMapper.getHcsxCode(hcrwId);
    }

    @Override
    public Hcrw getHcrwById(String hcrwId) {
        return hcrwMapper.selectByPrimaryKey(hcrwId);
    }

    @Override
    public void updateHcrw(Hcrw hcrw) {
        hcrwMapper.updateByPrimaryKey(hcrw);
    }

    @Override
    public List<Hcrw> queryForOrg(Map<String, Object> params) {
        return hcrwMapper.queryForOrg(params);
    }

    @Override
    public Integer getTaskInitStatus(String hcrwId) {
        return hcsxjgMapper.selectCountByTaskId(hcrwId);
    }

	@Override
	public void accept(String planId, List<String> taskIds) {
		User user = WebUtils.getCurrentUser();
		hcrwMapper.updateAccept(taskIds, user.getUserId(), user.getName());
		hcjhService.reCalcAcceptStatus(planId);
	}
	
	public void unAccept(String planId, List<String> taskIds) {
		User user = WebUtils.getCurrentUser();
		hcrwMapper.updateUnAccept(taskIds);
		hcjhService.reCalcAcceptStatus(planId);
	}

	@Override
	public void setTaskStatus(String hcrwId, Integer statusCode) {
		hcrwMapper.updateStatusByPrimaryKey(hcrwId, statusCode);
	}


}
