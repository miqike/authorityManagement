package com.kysoft.kteam.plan.service;

import java.util.List;

import com.kysoft.kteam.plan.entity.Plan;

/**
 * Created by Tommy on 9/18/2015.
 */
public interface PlanAllService {
    String save(Plan plan);
    void update(Plan plan);
    void delete(String id);
    Plan getPlanById(String id);
    List<Plan> getPlansByParentId(String id);
    List<Plan> getPlanTreeByParentId(String id);

    List<Plan> getPlanDetailByParentId(String id);

}
