package com.kysoft.kteam.plan.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.kteam.plan.entity.Plan;
import com.kysoft.kteam.plan.service.PlanAllService;

import net.sf.husky.web.controller.BaseController;

/**
 * Created by Tommy on 5/6/2015.
 */
@RestController
@RequestMapping("/plan")
public class PlanAllController extends BaseController {
    @Resource
    PlanAllService planAllService;

    @RequestMapping(value = "/new", method = RequestMethod.POST)
    public Map<String, Object> save(Plan plan) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            String id=planAllService.save(plan);
            result.put(MESSAGE,  "保存成功!");
            result.put(STATUS, SUCCESS);
            result.put("id", id);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存失败");
        }
        return result;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            planAllService.delete(id);
            result.put(MESSAGE,  "删除成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "删除失败");
        }
        return result;
    }

    @RequestMapping(value = "/getPlanById", method = RequestMethod.GET)
    public Plan getPlanById(String id) {
        return planAllService.getPlanById(id);
    }

    @RequestMapping(value = "/getPlansByParentId", method = RequestMethod.GET)
    public List<Plan> getPlansByParentId(String id) {
        return planAllService.getPlansByParentId(id);
    }

    @RequestMapping(value = "/getPlanTreeByParentId", method = RequestMethod.GET)
    public List<Plan> getPlanTreeByParentId(String id) {

        return planAllService.getPlanTreeByParentId(id);
    }

    @RequestMapping(value = "/projectItems", method = RequestMethod.POST)
    public List<Plan> getProjectItems(@RequestParam String planId, @RequestParam(required = false)String id) {

        String parentId = id == null? planId: id;
        try {
            planAllService.getPlanDetailByParentId(parentId);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return  planAllService.getPlanDetailByParentId(parentId);
    }

}
