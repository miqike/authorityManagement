package com.kysoft.cpsi.audit.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.Sczt;
import com.kysoft.cpsi.repo.service.HcclService;
import com.kysoft.cpsi.repo.service.ScztService;
import com.kysoft.cpsi.task.service.HcrwService;

/**
 * Created by Tommy on 5/6/2015.
 */
@RestController
@RequestMapping("/docUpload/")
public class DocUploadController extends net.sf.husky.web.controller.BaseController {

    @Resource
    ScztService scztService;
    
    @Resource
    HcrwService hcrwService;
    
    @Resource
    HcclService hcclService;
    
    @RequestMapping(value = "{xydm}", method = RequestMethod.GET)
    public Map<String, Object> load(@PathVariable String xydm) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            Sczt sczt = scztService.loadByXydm(xydm);
            result.put(STATUS, SUCCESS);
            result.put(DATA, sczt);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "查询失败");
        }
        return result;
    }
    
    @RequestMapping(value = "{xydm}/sendToken/{mobile}", method = RequestMethod.GET)
    public Map<String, Object> sendToken(@PathVariable String xydm, @PathVariable() String mobile) {
    	Map<String, Object> result = Maps.newHashMap();
    	try {
    		String tokenId = scztService.sendToken(xydm, mobile);
    		result.put(STATUS, SUCCESS);
    		result.put("tokenId", tokenId);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result.put(STATUS, FAIL);
    		result.put(MESSAGE, "发送口令失败");
    	}
    	return result;
    }
    
    @RequestMapping(value = "{xydm}/login", method = RequestMethod.POST)
    public Map<String, Object> login(@PathVariable String xydm, String tokenId, String password, HttpSession session) {
    	Map<String, Object> result = Maps.newHashMap();
    	try {
    		scztService.login(xydm, tokenId, password);
    		session.setAttribute("xydm", xydm);
    		session.setAttribute("token", password);
    		result.put(STATUS, SUCCESS);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result.put(STATUS, FAIL);
    		result.put(MESSAGE, "企业登录失败");
    	}
    	return result;
    }


    @RequestMapping(value = "{hcrwId}/furtherDocist", method = RequestMethod.GET)
    public Map<String, Object> getFurtherDocistt(@PathVariable String hcrwId) {
    	Map<String, Object> result = Maps.newHashMap();
    	try {
    		result.put(DATA, hcclService.queryForTask2(hcrwId));
    		result.put(STATUS, SUCCESS);
    	} catch (Exception e) {
    		e.printStackTrace();
    		result.put(STATUS, FAIL);
    		result.put(MESSAGE, "企业登录失败");
    	}
    	return result;
    }
}
