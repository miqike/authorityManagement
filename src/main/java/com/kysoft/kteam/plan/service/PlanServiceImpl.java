package com.kysoft.kteam.plan.service;

import com.kysoft.kteam.plan.entity.Plan;
import com.kysoft.kteam.plan.entity.PlanUserOrg;
import com.kysoft.kteam.plan.mapper.PlanMapper;
import com.kysoft.kteam.plan.mapper.PlanUserOrgMapper;
import net.sf.husky.security.entity.SysOrganization;
import net.sf.husky.security.entity.User;
import net.sf.husky.security.mapper.SysOrganizationMapper;
import net.sf.husky.security.mapper.UserMapper;
import net.sf.husky.security.service.UserService;
import net.sf.husky.sms.SMSService;
import net.sf.husky.utils.HuskyConstants;
import net.sf.husky.utils.WebUtils;
import org.apache.commons.beanutils.BeanUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

/**
 * Created by Tommy on 9/18/2015.
 */
@Service
public class PlanServiceImpl implements PlanService {
    @Resource
    PlanMapper planMapper;

    @Resource
    UserMapper userMapper;

    @Resource
    SysOrganizationMapper sysOrganizationMapper;

    @Resource
    PlanUserOrgMapper planUserOrgMapper;

    @Resource
    SMSService smsService;

    @Resource
    UserService userService;

    //根据计划开始处理对应的任务（包含子计划）
    int getTaskStatusByPlanStatus(int planStatus) {
        int status = 0;
        switch (planStatus) {
            case 1:
                status = 1;
                break;
            case 2:
                status = 1;
                break;
            case 3:
                status = 1;
                break;
            case 4:
                status = 2;
                break;
            case 5:
                status = 6;
                break;
            case 6:
                status = 5;
                break;
            case 7:
                status = 5;
                break;
            default:
                status = 1;
                break;
        }
        return status;
    }

    /*
    void issueUserPlanFromDeptPlan(String deptPlanId) throws Exception{
        Plan deptPlan=planMapper.selectByPrimaryKey(deptPlanId);
        if (deptPlan.getIsDeptPlan() == 1) {
            if (deptPlan.getStatus() == 3 || deptPlan.getStatus() == 4) {
                Map<String, Object> params = new HashMap<>();
                params.put("parentId", deptPlanId);
                params.put("isDeptPlan", 0);
                List<Plan> userPlans = planMapper.queryByParentId(params);
                if (userPlans.size() == 0) {
                    Plan userPlan = new Plan();
                    deptPlan.setIsParent(deptPlan.getIsParent()==null?false:deptPlan.getIsParent());
                    BeanUtils.copyProperties(userPlan, deptPlan);
                    userPlan.setId(UUID.randomUUID().toString().replaceAll(HuskyConstants.DASH, HuskyConstants.BLANK));
                    userPlan.setIsDeptPlan(0);
                    userPlan.setStatus(1);
                    userPlan.setParentId(deptPlan.getId());
                    userPlan.setParentName(deptPlan.getName());
                    planMapper.insert(userPlan);
                }
            }
        }
        List<Plan> childPlanList = planMapper.selectPlanItemsByParentId(deptPlanId,"1");
        for(Plan plan:childPlanList) {
            issueUserPlanFromDeptPlan(plan.getId());
        }
    }
    void dealTaskOfPlan(String planId) throws Exception{
        Plan parentPlan=planMapper.selectByPrimaryKey(planId);
        if(parentPlan.getIsDeptPlan()==0) {
            //只有个人计划才会自动产生任务
            List<Plan> childPlanList = planMapper.selectPlanItemsByParentId(planId,"0");
            if (childPlanList.size() > 0) {
                //有子计划，将当前计划对应的任务删除
                taskMapper.deleteByPlanId(planId);
                for (Plan childPlan : childPlanList) {
                    childPlan.setStatus(parentPlan.getStatus());
                    planMapper.updateByPrimaryKeySelective(childPlan);//更新子计划的状态，保持与父计划一致
                    dealTaskOfPlan(childPlan.getId());
                }
            } else {
                List<Task> taskList = taskMapper.seleteByPlanId(planId);
                if (taskList.size() > 0) {
                    for (Task task : taskList) {
                        if(parentPlan.getStatus()==7){
                            task.setProgress(100);
                        }
                        task.setStatus(getTaskStatusByPlanStatus(parentPlan.getStatus()));
                        taskMapper.updateByPrimaryKeySelective(task);
                    }
                } else {
                    Task task = new Task();
                    BeanUtils.copyProperties(task, parentPlan);
                    if(parentPlan.getStatus()==7){
                        task.setProgress(100);
                    }
                    task.setStatus(getTaskStatusByPlanStatus(parentPlan.getStatus()));
                    task.setPlanId(parentPlan.getId());
                    task.setPlanName(parentPlan.getTitle());
                    taskMapper.insertSelective(task);
                }
            }
        }
    }*/
    void updateChildPlanSn(Plan parentPlan) {
        List<Plan> childPlans = planMapper.selectPlanItemsByParentId(parentPlan.getId(), null, null, null);
        for (Plan plan : childPlans) {
            String newSn = parentPlan.getSn() + plan.getSn().substring(parentPlan.getSn().length(), plan.getSn().length());
            plan.setSn(newSn);
            planMapper.updateByPrimaryKeySelective(plan);
            updateChildPlanSn(plan);
        }
    }

    //更新子计划状态为父计划状态
    void updateChildPlanStatus(Plan parentPlan) {
        List<Plan> childPlans = planMapper.selectPlanItemsByParentId(parentPlan.getId(), null, null, null);
        for (Plan plan : childPlans) {
            plan.setStatus(parentPlan.getStatus());
            planMapper.updateByPrimaryKeySelective(plan);
            updateChildPlanStatus(plan);
        }
    }

    @Override
    public List<Plan> getPlanItemsByParentId(String id, String isDeptPlan, String sort, String order) {
        return planMapper.selectPlanItemsByParentId(id, isDeptPlan, sort, order);
    }

    @Override
    public Plan getPlanItemsById(String id) {
        return planMapper.selectByPrimaryKey(id);
    }

    @Override
    public Plan save(Plan plan) throws Exception {

        boolean reCalculateWeightAndProgress = false;

        if (plan.getId() != null && !plan.getId().equals(HuskyConstants.BLANK)) {

            if (plan.getStatus() == 7) {
                plan.setProgress(100);
                reCalculateWeightAndProgress = true;
            }

            //更新子节点SN
            Plan oldPlan = planMapper.selectByPrimaryKey(plan.getId());
            if (!oldPlan.getSn().equals(plan.getSn())) {
                updateChildPlanSn(plan);
            }

            if (oldPlan.getProgress() != plan.getProgress() || oldPlan.getWeight() != plan.getWeight()) {
                reCalculateWeightAndProgress = true;
            }
            //如果父计划状态变更为（1 草稿）（2 审批中）（3 已审批），将子计划状态改成与父计划一致
            if (oldPlan.getStatus() != plan.getStatus() && (plan.getStatus() == 1 || plan.getStatus() == 2 || plan.getStatus() == 3)) {
                updateChildPlanStatus(plan);
            }
            planMapper.updateByPrimaryKeySelective(plan);
        } else {
            plan.setId(UUID.randomUUID().toString().replaceAll(HuskyConstants.DASH, HuskyConstants.BLANK));
            plan.setCreateTime(new Date());
/*
            User user = WebUtils.getCurrentUser();
            plan.setAuthorId(user.getId());
            plan.setOwnerId(user.getId());
            plan.setAuthorName(user.getName());
            plan.setOwnerName(user.getName());
*/
            planMapper.insertSelective(plan);
        }

        if (reCalculateWeightAndProgress) {
            calculateWeightPer(plan);
        }
//        dealTaskOfPlan(plan.getId());
//        issueUserPlanFromDeptPlan(plan.getId());
        return plan;
    }


    @Override
    public Plan update(Plan plan) throws Exception {
        if (null != plan.getStatus() && plan.getStatus() == 7) {
            plan.setProgress(100);
        }

        Plan oldPlan = planMapper.selectByPrimaryKey(plan.getId());
        //如果父计划状态变更为（1 草稿）（2 审批中）（3 已审批），将子计划状态改成与父计划一致
        if (plan.getStatus() != null && oldPlan.getStatus() != plan.getStatus() && (plan.getStatus() == 1 || plan.getStatus() == 2 || plan.getStatus() == 3)) {
            updateChildPlanStatus(plan);
        }

        if (oldPlan.getSuperintendentId() != null) {
            User user = userService.findByUserId(oldPlan.getSuperintendentId());
            if (plan.getStatus() != null && plan.getStatus() == 3 && oldPlan.getSuperintendentId() != null && user.getMobile() != null) {
                smsService.sendSMS(user.getMobile(), "计划" + oldPlan.getSn() + ": " + oldPlan.getTitle() + " 已经审批通过!");
            }
        }

        planMapper.updateByPrimaryKeySelective(plan);
//        dealTaskOfPlan(plan.getId());
//        issueUserPlanFromDeptPlan(plan.getId());
        return plan;
    }

    @Override
    public Map<String, Object> delete(String planId) {
        Map<String, Object> result = new HashMap<String, Object>();
        if (planMapper.selectPlanItemsByParentId(planId, null, null, null).size() > 0) {
            result.put("status", -1);
            result.put("message", "有子数据，不能删除");
        } else {
            result.put("status", 1);
            result.put("message", "删除成功");
            planMapper.deleteByPrimaryKey(planId);
//            taskMapper.deleteByPlanId(planId);//删除对应的计划
        }
        return result;
    }

    @Override
    public String getNextSn(String parentPlanId, int isDeptPlan, String orgId) {
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("id", parentPlanId);
        param.put("isDeptPlan", isDeptPlan);
        User user = WebUtils.getCurrentUser();
        param.put("userId", user.getUserId());
        param.put("orgId", null == orgId || orgId.equals(HuskyConstants.BLANK) ? user.getOrgId() : orgId);
        String maxSn = planMapper.selectNextSnByParentId(param);
        String nextSn;

        /*if(maxSn!=null && !maxSn.equals(HuskyConstants.BLANK)) {
            String[] snList = maxSn.split("\\.");
            if (snList.length > 0) {
                nextSn = snList[snList.length - 1];
                snList[snList.length - 1] = ((Integer) (Integer.valueOf(nextSn) + 1)).toString();
                nextSn = HuskyConstants.BLANK;
                for (int i = 0; i < snList.length - 1; i++) {
                    nextSn = nextSn + snList[i] + ".";
                }
                nextSn = nextSn + snList[snList.length - 1];
            } else {
                nextSn = ((Integer) (Integer.valueOf(maxSn) + 1)).toString();
            }
        }else{
            Plan plan=planMapper.selectByPrimaryKey(parentPlanId);
            nextSn=plan.getSn()+".1";
        }*/
        String[] snList = maxSn.split("\\.");
        if (snList.length > 2) {
            nextSn = snList[snList.length - 1];
            snList[snList.length - 1] = ((Integer) (Integer.valueOf(nextSn) + 1)).toString();
            nextSn = HuskyConstants.BLANK;
            for (int i = 0; i < snList.length - 1; i++) {
                nextSn = nextSn + snList[i] + ".";
            }
            nextSn = nextSn + snList[snList.length - 1];
        } else {
//            nextSn = maxSn + ".1";
            if (null != parentPlanId && !parentPlanId.equals(HuskyConstants.BLANK)) {
                Plan plan = planMapper.selectByPrimaryKey(parentPlanId);
                nextSn = plan.getSn() + ".1";
            } else {
                nextSn = maxSn + ".1";
            }
        }

        return nextSn;
    }

    @Override
    public List<Plan> getPlan(Map<String, Object> params) {
        return planMapper.query(params);
    }

    @Override
    public List<Plan> getDeptPlanItems(Integer year, Integer cycleType, Integer cycle, String orgId, String isSelfDeptFlag, String sort, String order) {
        cycleType = cycleType == null ? 1 : cycleType;
        DateTime start, end;
        start = getStartDate(year, cycleType, cycle);
        end = getEndDate(start, cycleType);

        System.out.println("时间段开始: " + start + ", 时间段结束: " + end);
        User user = WebUtils.getCurrentUser();
        if (null != orgId && orgId != HuskyConstants.BLANK) {
            return planMapper.selectDeptPlanItems(orgId, start.toDate(), end.toDate(), isSelfDeptFlag, null, sort, order);
        } else {
            if (null != user) {
                return planMapper.selectDeptPlanItems(null, start.toDate(), end.toDate(), isSelfDeptFlag, user.getUserId(), sort, order);
            } else {
                return null;
            }
        }
    }

    @Override
    public List<Plan> getPersonalPlanItems(Integer year, Integer cycleType, Integer cycle, String userId, String sort, String order) {
        cycleType = cycleType == null ? 1 : cycleType;
        DateTime start, end;
        start = getStartDate(year, cycleType, cycle);
        end = getEndDate(start, cycleType);

        System.out.println("时间段开始: " + start + ", 时间段结束: " + end);
        User user = WebUtils.getCurrentUser();

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("userId", null == userId ? user.getUserId() : userId);
        params.put("start", start.toDate());
        params.put("end", end.toDate());
        params.put("sort", sort);
        params.put("order", order);

        return planMapper.selectPersonalPlan(params);
    }

    @Override
    public void changeStatus(Plan plan, String cascadeFlag) {
        Plan oriPlan = planMapper.selectByPrimaryKey(plan.getId());

        //设置审批通过时间/实际开始时间/实际结束时间/验证时间
        if (plan.getStatus() == Plan.STARTED && (oriPlan.getStatus() == Plan.DRAFT || oriPlan.getStatus() == Plan.APPROVED)) {
            plan.setStartAct(new Date());
        } else if (plan.getStatus() == Plan.TERMINATE) {
            plan.setEnd(new Date());
        } else if (plan.getStatus() == Plan.APPROVED) {
            plan.setApproveTime(new Date());

            if (plan.getSuperintendentId() != null) {
                User user = userService.findByUserId(plan.getSuperintendentId());
                smsService.sendSMS(user.getMobile(), "计划" + plan.getSn() + ": " + plan.getTitle() + " 已经审批通过!");
            }
        } else if (plan.getStatus() == Plan.COMPLETE) {
            plan.setProgress(100);
            plan.setEnd(new Date());
        } else if (plan.getStatus() == Plan.CLOSED) {
            if (oriPlan.getStatus() == Plan.COMPLETE) {
                plan.setVerifyTime(new Date());
            } else {
                plan.setProgress(100);
                plan.setEnd(new Date());
            }
        }

        planMapper.updateByPrimaryKeySelective(plan);
        if (null != cascadeFlag && cascadeFlag.equals("1")) {
            changChildStatus(plan);
        }
    }

    void changChildStatus(Plan parentPlan) {
        List<Plan> plans = planMapper.selectByParentId(parentPlan.getId());
        for (Plan plan : plans) {
            //设置审批通过时间/实际开始时间/实际结束时间/验证时间
            if (parentPlan.getStatus() == Plan.STARTED && (plan.getStatus() == Plan.DRAFT || plan.getStatus() == Plan.APPROVED)) {
                plan.setStartAct(new Date());
            } else if (plan.getStatus() == Plan.TERMINATE) {
                plan.setEnd(new Date());
            } else if (plan.getStatus() == Plan.APPROVED) {
                plan.setApproveTime(new Date());
            } else if (plan.getStatus() == Plan.COMPLETE) {
                plan.setProgress(100);
                plan.setEnd(new Date());
            } else if (plan.getStatus() == Plan.CLOSED) {
                if (parentPlan.getStatus() == Plan.COMPLETE) {
                    plan.setVerifyTime(new Date());
                } else {
                    plan.setProgress(100);
                    plan.setEnd(new Date());
                }
            }
            plan.setStatus(parentPlan.getStatus());
            planMapper.updateByPrimaryKeySelective(plan);
            changChildStatus(plan);
        }
    }

    private void calculateWeightPer(Plan plan) {
        System.out.println("结点权重改变,TITLE: " + plan.getTitle() + ", " + plan.getWeight());
        boolean needCalProgress = false;
        //1.  重新计算所有兄弟项的weightPer
        String parentId = plan.getParentId();
        //找到所有的兄弟节点
        List<Plan> siblings = planMapper.selectByParentId(parentId);

        Integer sigmaWeight = 0;
        for (Plan sibling : siblings) {
            sigmaWeight += sibling.getWeight();
        }

        if (sigmaWeight > 0) {
            for (Plan sibling : siblings) {
                sibling.setWeightPer(new Integer(sibling.getWeight() * 100 / sigmaWeight));
                //如果有进度不为零的项则重新计算父节点的进度,
                if (sibling.getProgress() != 0) {
                    needCalProgress = true;
                }
                //保存所有兄弟节点
                planMapper.updateByPrimaryKeySelective(sibling);
            }
        }
        //重新计算父节点的进度,
        if (needCalProgress) {
            Integer progress = 0;
            for (Plan sibling : siblings) {
                progress += sibling.getProgress() * sibling.getWeightPer() / 100;
            }
            changeProgress(parentId, progress, null);
        }
    }

    @Override
    public void changeProgress(String id, Integer progress, String cascadeFlag) {
        planMapper.updateProgress(id, progress);
        if (null != cascadeFlag && cascadeFlag.equals("1")) {
            changChildProgress(id, progress);
        }
    }

    void changChildProgress(String id, Integer progress) {
        List<Plan> plans = planMapper.selectByParentId(id);
        for (Plan plan : plans) {
            plan.setProgress(progress);
            if (progress >= 100) {
                plan.setStatus(8);
            }
            planMapper.updateByPrimaryKey(plan);
            changChildProgress(plan.getId(), progress);
        }
    }

    @Override
    public void raisePlan(Plan personalPlan) throws Exception {
        User user = userMapper.selectByPrimaryKey(personalPlan.getOwnerId());
        Plan deptPlan = new Plan();
        BeanUtils.copyProperties(deptPlan, personalPlan);
        deptPlan.setSuperintendentId(personalPlan.getOwnerId());
        deptPlan.setSuperintendentName(personalPlan.getOwnerName());
        deptPlan.setSuperintendDeptId(user.getOrgId());
        deptPlan.setSuperintendDeptName(user.getOrgName());
        deptPlan.setId(UUID.randomUUID().toString().replaceAll(HuskyConstants.DASH, HuskyConstants.BLANK));
        deptPlan.setIsAssigned(0);
        deptPlan.setIsDeptPlan(1);
        planMapper.insert(deptPlan);
        personalPlan.setParentId(deptPlan.getId());
        personalPlan.setParentName(deptPlan.getTitle());
        personalPlan.setIsAssigned(1);
        personalPlan.setIsDeptPlan(1);
        planMapper.updateByPrimaryKeySelective(personalPlan);
    }

    @Override
    public List<SysOrganization> getManagedDept() {
        User user = WebUtils.getCurrentUser();
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("userId", user.getUserId());
        List<PlanUserOrg> planUserOrgList = planUserOrgMapper.queryByUserId(param);
        List<SysOrganization> result = new ArrayList<SysOrganization>();
        for (PlanUserOrg planUserOrg : planUserOrgList) {
            SysOrganization sysOrganization = new SysOrganization();
            sysOrganization.setId(planUserOrg.getOrgId());
            sysOrganization.setName(planUserOrg.getOrgName());
            result.add(sysOrganization);
        }
        return result;
    }

    @Override
    public void saveUserOrg(String userId, String[] orgIds) {
        if (orgIds.length > 0)
            planUserOrgMapper.insertUserOrgBatch(userId, orgIds);
    }

    @Override
    public void deleteUserOrg(String userId, String[] orgIds) {
        if (orgIds.length > 0)
            planUserOrgMapper.deleteUserOrgBatch(userId, orgIds);
    }

    private DateTime getStartDate(Integer year, Integer cycleType, Integer cycle) {
        DateTime now = new DateTime();
        Integer currentYear = now.getYear();
        Integer currentMonth = now.getMonthOfYear();
        year = year == null ? currentYear : year;
        DateTime startDateTime = null;

        switch (cycleType) {
            case 1:
                startDateTime = new DateTime(year, cycle == null ? currentMonth : cycle, 1, 0, 0, 0);
                break;
            case 2:
                startDateTime = new DateTime(year, (cycle - 1) * 3 + 1, 1, 0, 0, 0);
                break;
            case 3:
                startDateTime = new DateTime(year, 1, 1, 0, 0, 0);
                break;
            case 4:
                startDateTime = new DateTime(year, 1, 1, 0, 0, 0).plusWeeks(cycle - 1);
                startDateTime = startDateTime.minusDays(startDateTime.getDayOfWeek() - 1);
                break;
        }

        return startDateTime;
    }

    private DateTime getEndDate(DateTime start, Integer cycleType) {
        DateTime end = null;
        switch (cycleType) {
            case 1:
                end = start.plusMonths(1);
                break;
            case 2:
                end = start.plusMonths(3);
                break;
            case 3:
                end = start.plusYears(1);
                break;
            case 4:
                end = start.plusWeeks(1);
                break;
        }
        return end;
    }



    /*private Integer getCurrentCycle(Integer cycleType) {
        Integer cycle = null;
        Calendar calendar = Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH)+1;

        if(cycleType == 1) {
            cycle = month;
        } else if(cycleType == 2) {
            cycle = month /4 + 1;
        } else if(cycleType == 3) {
            cycle = calendar.get(Calendar.YEAR);
        }
        return cycle;
    }*/


}
