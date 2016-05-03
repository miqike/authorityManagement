package com.kysoft.kteam.plan.service;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.kteam.plan.entity.Plan;
import com.kysoft.kteam.plan.mapper.PlanMapper;

import net.sf.husky.utils.HuskyConstants;

/**
 * Created by Tommy on 9/18/2015.
 */
@Service
public class PlanAllServiceImpl implements PlanAllService {
    @Resource
    PlanMapper planMapper;


    @Override
    public String save(Plan plan) {
        plan.setId(UUID.randomUUID().toString().trim().replaceAll(HuskyConstants.DASH, HuskyConstants.BLANK));
        planMapper.insert(plan);
        return plan.getId();
    }

    @Override
    public void update(Plan plan) {
        planMapper.updateByPrimaryKeySelective(plan);
    }

    @Override
    public void delete(String id) {
        planMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Plan getPlanById(String id) {
        return planMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Plan> getPlansByParentId(String id) {
        return planMapper.selectPlanItemsByParentId(id,null, null, null);
    }


    @Override
    public List<Plan> getPlanTreeByParentId(String id) {
        return planMapper.selectPlanItemsByParentId(id,null, null, null);
    }

    @Override
    public List<Plan> getPlanDetailByParentId(String id) {
        return planMapper.selectPlanItemsByParentId(id,null, null, null);
    }

}
