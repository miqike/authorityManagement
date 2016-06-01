package com.kysoft.cpsi.repo.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.Sczt;
import com.kysoft.cpsi.repo.service.ScztService;

/**
 * Created by Tommy on 5/6/2015.
 */
@RestController
@RequestMapping("/21/2101")
public class ScztController extends net.sf.husky.web.controller.BaseController {

    @Resource
    ScztService scztService;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public Map<String, Object> query(HttpServletRequest request) {
    	Map<String, Object> result = Maps.newHashMap();
    	try {
    		Map<String, Object> params = WebUtils.getParametersStartingWith(request, "");
    		List<Sczt> queryResult = scztService.query(params);
    		result.put(MESSAGE, "查询成功");
    		result.put(STATUS, SUCCESS);
    		result.put(DATA, queryResult);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result.put(STATUS, FAIL);
    		result.put(MESSAGE, "查询失败");
    	}
    	return result;
    }

    @RequestMapping(value = "", method = RequestMethod.POST)
    public Map<String, Object> add(Sczt sczt) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "保存成功");
            result.put(STATUS, SUCCESS);
            scztService.insert(sczt);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.PUT)
    public Map<String, Object> update(Sczt sczt) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "修改成功");
            result.put(STATUS, SUCCESS);
            scztService.update(sczt);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "修改失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public Map<String, Object> delete(String xydm) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "删除成功");
            result.put(STATUS, SUCCESS);
            scztService.delete(xydm);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "删除失败");
        }
        return result;
    }

    @RequestMapping(value = "/hccl", method = RequestMethod.GET)
    public Map<String, Object> queryHccl(String xydm) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            List<Map<String, Object>> queryResult = scztService.queryHccl(xydm);
            result.put(MESSAGE, "查询成功");
            result.put(STATUS, SUCCESS);
            result.put(DATA, queryResult);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "查询失败");
        }
        return result;
    }

}
