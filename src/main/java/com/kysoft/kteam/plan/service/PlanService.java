package com.kysoft.kteam.plan.service;

import java.util.List;
import java.util.Map;

import com.kysoft.kteam.plan.entity.Plan;

import net.sf.husky.security.entity.SysOrganization;

/**
 * Created by Tommy on 9/18/2015.
 */
public interface PlanService {

    List<Plan> getPlanItemsByParentId(String id,String isDeptPlan, String sort, String order);

    Plan getPlanItemsById(String id);

    Plan save(Plan plan) throws Exception;

    Plan update(Plan plan) throws Exception;

    Map<String, Object> delete(String planId);

    String getNextSn(String parentPlanId,int isDeptPlan,String orgId );

    List<Plan> getPlan(Map<String,Object> params);

    List<Plan> getDeptPlanItems(Integer year, Integer cycleType, Integer cycle,String orgId,String isSelfDeptFlag, String sort, String order);

    List<Plan> getPersonalPlanItems(Integer year, Integer cycleType, Integer cycle,String userId, String sort, String order);

    void changeStatus(Plan plan,String cascadeFlag);

    void changeProgress(String id, Integer progress,String cascadeFlag);
    void raisePlan(Plan personalPlan) throws Exception;

    List<SysOrganization> getManagedDept();

    void saveUserOrg(String userId, String[] orgIds);
    void deleteUserOrg(String userId, String[] orgIds);

}
