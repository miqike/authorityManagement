package com.kysoft.cpsi.task.service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.entity.Hcsxjg;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.HcsxjgMapper;

import net.sf.husky.log.MongoLogger;
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
            hcsxjg.setDbxxly(hcsx.getDbxxly());
            hcsxjg.setHczt(1);
            hcsxjgMapper.insert(hcsxjg);
        }
        MongoLogger.info("task", "用户对核查任务进行初始操作,初始核查事项: " + hcsxList.size());
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
        MongoLogger.info("task", "用户对核查任务进行数据加载操作");
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
        MongoLogger.info("task", "用户更新任务检查结果: " + hcrw.getHcjieguo());
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
		MongoLogger.info("task", "用户认领任务: " + taskIds.size(), null, planId);
	}
	
	public void unAccept(String planId, List<String> taskIds) {
		hcrwMapper.updateUnAccept(taskIds);
		hcjhService.reCalcAcceptStatus(planId);
		MongoLogger.info("task", "用户取消认领任务: " + taskIds.size(), null, planId);
	}

	@Override
	public void setTaskStatus(String hcrwId, Integer statusCode) {
		hcrwMapper.updateStatusByPrimaryKey(hcrwId, statusCode);
		MongoLogger.info("task", "用户修改任务状态: " + statusCode, null, hcrwId);
	}

	@Override
	public void updateDocReadyFlag(String hcrwId, int docReadyReportFlag) {
		int flag = docReadyReportFlag == 0? 1: 0;
		User user = WebUtils.getCurrentUser();
		hcrwMapper.updateDocReadyReportFlag(hcrwId, flag, user.getName());
		MongoLogger.info("task", "用户对任务进行上报操作: " + docReadyReportFlag, null, hcrwId);
	}

	@Override
	public void auditHcrw(Hcrw hcrw) {
		User auditor = WebUtils.getCurrentUser();
		hcrw.setAuditor(auditor.getUserId());
		hcrw.setAuditorName(auditor.getName());
		hcrwMapper.updateAuditByPrimaryKey(hcrw);
		MongoLogger.info("task", "用户对任务结果进行审核");
	}

	@Override
	public void cancelAuditHcrw(String hcrwId) {
		hcrwMapper.updateCancelAuditByPrimaryKey(hcrwId);
		MongoLogger.info("task", "用户取消对任务结果的审核");
	}


}
