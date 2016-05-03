package com.kysoft.kteam.plan.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import com.google.common.collect.Maps;
import com.kysoft.kteam.plan.entity.Attachment;
import com.kysoft.kteam.plan.entity.Comment;
import com.kysoft.kteam.plan.entity.Plan;
import com.kysoft.kteam.plan.service.AttachmentService;
import com.kysoft.kteam.plan.service.CommentService;
import com.kysoft.kteam.plan.service.PlanService;

import net.sf.husky.utils.HuskyConstants;
import net.sf.husky.web.controller.BaseController;

/**
 * Created by Tommy on 5/6/2015.
 */
@RestController
@RequestMapping("/plan")
public class PlanController extends BaseController {
    @Resource
    PlanService planService;

    @Resource
    AttachmentService attachmentService;

    @Resource
    CommentService commentService;
/*
    @RequestMapping(value = "/planItems", method = RequestMethod.POST)
    public List<Plan> getPlanItems(@RequestParam String planId, @RequestParam(required = false)String isDeptPlan, @RequestParam(required = false)String id) {
        String parentId = id == null? planId: id;
        return  planService.getPlanItemsByParentId(parentId,isDeptPlan);
    }
*/

    @RequestMapping(value = "/planItems", method = RequestMethod.GET)
    public List<Plan> getDeptPlanItems(@RequestParam(required = false)Integer year,
                                       @RequestParam(required = false)Integer cycleType,
                                       @RequestParam(required = false)Integer cycle,
                                       @RequestParam(required = false)String id,
                                       @RequestParam(required = false)String orgId,
                                       @RequestParam(required = false)String isDeptPlan,
                                       @RequestParam(required = false)String isSelfDeptPlan,
                                       @RequestParam(required = false)String userId,
                                       @RequestParam(required = false)String sort,
                                       @RequestParam(required = false)String order) {

        if(null != isDeptPlan && isDeptPlan.equals("0")){
            if (id != null) {
                return planService.getPlanItemsByParentId(id, null, sort, order);
            } else {
                return planService.getPersonalPlanItems(year, cycleType, cycle,userId, sort, order);
            }
        }else {
            if (id != null) {
                return planService.getPlanItemsByParentId(id, "1", sort, order);
            } else {
                return planService.getDeptPlanItems(year, cycleType, cycle, orgId, isSelfDeptPlan, sort, order);
            }
        }
    }

    @RequestMapping(value = HuskyConstants.BLANK, method = RequestMethod.POST)
    public Map<String, Object> savePlan(Plan plan) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            plan = planService.save(plan);
            result.put(DATA, plan);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "保存计划信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存计划信息失败: " + e.getMessage());
        }
        return result;
    }

    /*@RequestMapping(value = HuskyConstants.BLANK, method = RequestMethod.PUT)
    public Map<String, Object> updatePlan(Plan plan) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            plan = planService.update(plan);
            *//*User operator = (User) session.getAttribute(HuskyConstant.SESSION_USER);
			if(operator.getUserId().endsWith(user.getUserId()))
				session.setAttribute(HuskyConstant.SESSION_USER, user);*//*
            result.put(DATA, plan);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "更新计划信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "更新计划信息异常: " + e.getMessage());
        }
        return result;
    }*/

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public Map<String, Object> updatePlan2(Plan plan) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            plan = planService.update(plan);
            result.put(DATA, plan);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "更新计划信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "更新计划信息异常: " + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = HuskyConstants.BLANK, method = RequestMethod.DELETE)
    public Map<String, Object> deletePlan(@RequestParam String planId) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result=planService.delete(planId);
            result.put(DATA, planId);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "删除计划信息异常: " + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/getNextSn", method = RequestMethod.GET)
    public Map<String, Object> getNextSn(String parentPlanId,int isDeptPlan,@RequestParam(required = false) String orgId) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(STATUS,SUCCESS);
            result.put(DATA, planService.getNextSn(parentPlanId,isDeptPlan,orgId));
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "取得序号异常，请手工填写！" + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/getPlan", method = RequestMethod.GET)
    public Map<String, Object> getPlan(HttpServletRequest request) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            Map<String,Object> params = WebUtils.getParametersStartingWith(request, HuskyConstants.BLANK);
            result.put(STATUS,SUCCESS);
            result.put(DATA, planService.getPlan(params));
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "数据获取异常！" + e.getMessage());
        }
        return result;
    }


    @RequestMapping(value = "/attachment/{planId}", method = RequestMethod.GET)
    public List<Attachment> getPlanAttachment(@PathVariable String planId) {
        System.out.println(planId);
        return attachmentService.getPlanAttachments(planId);
    }

    @RequestMapping(value = "/comment/{planId}", method = RequestMethod.GET)
    public List<Comment> getPlanComment(@PathVariable String planId) {
        System.out.println(planId);
        return commentService.getPlanComments(planId);
    }

    @RequestMapping(value = "/attachment", method = RequestMethod.POST)
    public Map<String, Object> saveAttachment(Attachment attachment) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            attachmentService.save(attachment);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "保存附件信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存附件信息异常: " + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/attachment/{mongoId}", method = RequestMethod.DELETE)
    public Map<String, Object> saveAttachment(@PathVariable String mongoId) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            attachmentService.delte(mongoId);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "删除文件信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "删除文件信息异常: " + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/comment", method = RequestMethod.POST)
    public Map<String, Object> saveComment(Comment comment) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            commentService.save(comment);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "保存备注信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存备注信息异常: " + e.getMessage());
        }
        return result;
    }


    @RequestMapping(value = "/changeStatus", method = RequestMethod.POST)
    public Map<String, Object> changeStatus(Plan plan,@RequestParam(required = false)String cascadeFlag) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            planService.changeStatus(plan,cascadeFlag);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "计划状态修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "计划状态修改异常: " + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/changeProgress", method = RequestMethod.POST)
    public Map<String, Object> changeProgress(Plan plan,@RequestParam(required = false)String cascadeFlag) {
        Map<String, Object> result = Maps.newHashMap();
        try {
//            planService.changeProgress(plan);
            planService.changeProgress(plan.getId(), plan.getProgress(),cascadeFlag);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "计划状态修改成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "计划状态修改异常: " + e.getMessage());
        }
        return result;
    }

    //提升计划
    @RequestMapping(value = "/raisePlan", method = RequestMethod.POST)
    public Map<String, Object> raisePlan(Plan personalPlan) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            planService.raisePlan(personalPlan);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "计划提升成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "计划提升异常: " + e.getMessage());
        }
        return result;
    }

    //提升计划
    @RequestMapping(value = "/managedDept", method = RequestMethod.GET)
    public Map<String, Object> getManagedDept(Plan personalPlan) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(DATA,planService.getManagedDept());
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "成功取得可编写计划的单位");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "取得可编写计划的单位异常: " + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/saveUserOrg/{userId}", method = RequestMethod.PUT)
    public Map<String, Object> saveUserOrg(@PathVariable("userId") String userId, @RequestBody String[] orgIds) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            planService.saveUserOrg(userId, orgIds);
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            result.put(STATUS, FAIL);
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping(value = "/deleteUserOrg/{userId}", method = RequestMethod.DELETE)
    public Map<String, Object> deleteUserOrg(@PathVariable("userId") String userId, @RequestBody String[] orgIds) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            planService.deleteUserOrg(userId, orgIds);
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            result.put(STATUS, FAIL);
            e.printStackTrace();
        }
        return result;
    }
}
