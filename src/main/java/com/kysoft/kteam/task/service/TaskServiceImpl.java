package com.kysoft.kteam.task.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.kteam.plan.entity.Plan;
import com.kysoft.kteam.plan.mapper.PlanMapper;

import net.sf.husky.utils.WebUtils;

/**
 * Created by Tommy on 10/10/2015.
 */
@Service("kteamTaskService")
public class TaskServiceImpl implements TaskService {
//    @Resource
//    TaskMapper taskMapper;

    @Resource
    PlanMapper planMapper;

    @Override
    public List<Plan> getTask(Date start, Date end) {
        String ownerId = WebUtils.getCurrentUser().getUserId();
//        return planMapper.selectByOwnerId(ownerId);
        return planMapper.selectByParticipantId(ownerId, start, end);
    }

   /* @Override
    public Task save(Task task) {
        if(task.getId() != null) {
            taskMapper.updateByPrimaryKeySelective(task);
        } else {
            task.setId(UUID.randomUUID().toString().trim().replaceAll(HuskyConstants.DASH, HuskyConstants.BLANK));
            String ownerId = WebUtils.getCurrentUser().getId();
            task.setOwnerId(ownerId);
            task.setStatus(1);
            task.setProgress(0);
            taskMapper.insert(task);
        }
        return task;
    }*/
}
