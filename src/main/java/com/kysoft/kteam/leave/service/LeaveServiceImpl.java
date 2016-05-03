package com.kysoft.kteam.leave.service;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.kysoft.kteam.leave.domain.Leave;
import com.kysoft.kteam.leave.mapper.LeaveMapper;

import net.sf.husky.activiti.service.HuskyFormDataAccessService;
import net.sf.husky.activiti.service.HuskyRepositoryService;
import net.sf.husky.activiti.service.HuskyRuntimeService;
import net.sf.husky.utils.WebUtils;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("leaveService")
public class LeaveServiceImpl implements LeaveService, HuskyFormDataAccessService {

    @Resource
    LeaveMapper leaveMapper;

    @Resource
    HuskyRepositoryService huskyRepositoryService;

    @Resource
    HuskyRuntimeService huskyRuntimeService;

    @Override
    public void askForLeave(Leave leave) {
        String userName = WebUtils.getCurrentUser().getUserId();
        leave.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
        leave.setProposer(userName);
        String processInstanceId = huskyRuntimeService.startProcessInstanceByKey("leave", leave.getId() + ":leaveService", null, null);
        leave.setProcessInstanceId(processInstanceId);
        leaveMapper.insert(leave);
    }

    @Override
    public Object load(String businessKey) {
        return leaveMapper.selectByPrimaryKey(businessKey);
    }

    @Override
    public String save(String businessKey, JSONObject businessObject) {
        boolean isNew = (null == businessKey);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Leave leave = new Leave();
        leave.setProposer(WebUtils.getCurrentUser().getUserId());

        try {
            if (businessObject.containsKey("startDate"))
                leave.setStartDate(df.parse((String) businessObject.get("startDate")));
            if (businessObject.containsKey("endDate"))
                leave.setEndDate(businessObject.getDate("endDate"));
            if (businessObject.containsKey("reason"))
                leave.setReason(businessObject.getString("reason"));
            if (businessObject.containsKey("leaveType"))
                leave.setLeaveType(businessObject.getInteger("leaveType"));
//            if (businessObject.containsKey("days"))
//                leave.setDays(businessObject.getInteger("days"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if(isNew) {
            businessKey = UUID.randomUUID().toString().trim().replaceAll("-", "");
            leave.setId(businessKey);
            leave.setProcessStatus(0);
            leaveMapper.insertSelective(leave);
        } else {
            leave.setId(businessKey);
            leave.setProcessInstanceId(businessObject.getString("processInstanceId"));
            leave.setProcessStartTime(new Date());
            leave.setProcessStatus(1);
            leaveMapper.updateByPrimaryKeySelective(leave);
        }
        return businessKey;
    }

    public void delete(String businessKey) {
    	leaveMapper.deleteByPrimaryKey(businessKey);
    }
    
    public void complete(String businessKey) {
    	leaveMapper.completeByPrimaryKey(businessKey);
    }
}
