package com.kysoft.kteam.task.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kysoft.kteam.plan.entity.Plan;
import com.kysoft.kteam.task.service.TaskService;

import net.sf.husky.utils.HuskyConstants;
import net.sf.husky.web.controller.BaseController;

/**
 * Created by Tommy on 10/10/2015.
 */

@RestController
@RequestMapping("/task")
public class TaskController extends BaseController {

    @Resource
    TaskService kteamTaskService;

    @RequestMapping(value = HuskyConstants.BLANK, method = RequestMethod.GET)
    public List<Plan> getTask(Date start, Date end) {

        List result = kteamTaskService.getTask(start, end);

        return result;
    }


    /*@RequestMapping(value = HuskyConstants.BLANK, method = RequestMethod.POST)
    public Map<String, Object> saveTask(Task task) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            task = kteamTaskService.save(task);
            result.put(DATA, task);
            result.put(STATUS, SUCCESS);
            result.put(MESSAGE, "保存任务信息成功");
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存任务信息失败: " + e.getMessage());
        }
        return result;
    }*/
}
