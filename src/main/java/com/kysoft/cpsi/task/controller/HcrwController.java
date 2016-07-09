package com.kysoft.cpsi.task.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.service.HcrwService;

import net.sf.husky.utils.HuskyConstants;
import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/51")
public class HcrwController extends BaseController {

    @Resource
    HcrwService hcrwService;

    @RequestMapping(value = "/{hcrwId}/jieguo", method = RequestMethod.POST)
    public Map<String, Object> updateJieguo(@PathVariable String hcrwId, int jieguo) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            Hcrw hcrw = hcrwService.getHcrwById(hcrwId);
            //核查结果为6种,只要设定核查结果,任务设为完成状态:5
            hcrw.setRwzt(5);
            hcrw.setHcjieguo(jieguo);
            hcrwService.updateHcrw(hcrw);
            result.put(MESSAGE, "更新核查结果成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "更新核查结果失败");
        }
        return result;
    }

    @RequestMapping(value = "/queryForOrg", method = RequestMethod.GET)
    public List<Hcrw> queryForOrg(ServletRequest request) {
        Map<String, Object> param = WebUtils.getParametersStartingWith(request, HuskyConstants.BLANK);

        return hcrwService.queryForOrg(param);
    }

    @RequestMapping(value = "/{hcrwId}/initStatus", method = RequestMethod.GET)
    public Map<String, Object> getHcrwInitStatus(@PathVariable String hcrwId) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            Integer count = hcrwService.getTaskInitStatus(hcrwId);
            result.put(MESSAGE, "检查列表项初始成功");
            result.put(STATUS, SUCCESS);
            result.put(DATA, count);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "检查列表项初始失败");
        }
        return result;
    }

    @RequestMapping(value = "/{hcrwId}/init", method = RequestMethod.POST)
    public Map<String, Object> init(@PathVariable String hcrwId) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            hcrwService.initTaskItem(hcrwId, 1);
            result.put(MESSAGE, "检查列表项初始成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "检查列表项初始失败");
        }
        return result;
    }

    @RequestMapping(value = "/{hcrwId}/pull", method = RequestMethod.GET)
    public Map<String, Object> pullData(@PathVariable String hcrwId) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            hcrwService.pullData(hcrwId);
            result.put(MESSAGE, "检查任务在线数据加载成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "检查任务在线数据加载失败");
        }
        return result;
    }

    @RequestMapping(value = "/{hcrwId}/hcsx", method = RequestMethod.GET)
    public List<Map> getHcsxCode(@PathVariable String hcrwId) {
        return hcrwService.getHcsxCode(hcrwId);
    }

    @RequestMapping(value = "/{planId}/accept", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> accept(@PathVariable String planId, @RequestBody List<String> taskIds) {
        Map<String, Object> result = Maps.newHashMap();
        try {
        	hcrwService.accept(planId, taskIds);
            result.put(MESSAGE, "认领任务成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "批量保存失败");
        }
        return result;
    }
    @RequestMapping(value = "/{planId}/unAccept", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> unAccept(@PathVariable String planId, @RequestBody List<String> taskIds) {
    	Map<String, Object> result = Maps.newHashMap();
    	try {
    		hcrwService.unAccept(planId, taskIds);
    		result.put(MESSAGE, "认领任务成功");
    		result.put(STATUS, SUCCESS);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result.put(STATUS, FAIL);
    		result.put(MESSAGE, "批量保存失败");
    	}
    	return result;
    }
    
    
    @RequestMapping(value = "/{hcrwId}/{statusCode}", method = RequestMethod.POST)
    public Map<String, Object> setTaskStatus(@PathVariable String hcrwId, @PathVariable Integer statusCode) {
    	Map<String, Object> result = Maps.newHashMap();
    	try {
    		hcrwService.setTaskStatus(hcrwId, statusCode);
    		result.put(MESSAGE, "认领任务成功");
    		result.put(STATUS, SUCCESS);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result.put(STATUS, FAIL);
    		result.put(MESSAGE, "批量保存失败");
    	}
    	return result;
    }
    
    @RequestMapping(value = "/{hcrwId}/docReadyReportFlag", method = RequestMethod.POST)
    public Map<String, Object> updateDocReadyFlag(@PathVariable String hcrwId, int docReadyReportFlag) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            hcrwService.updateDocReadyFlag(hcrwId, docReadyReportFlag);
            result.put(MESSAGE, "上报操作成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "上报操作失败");
        }
        return result;
    }
    
    
}
