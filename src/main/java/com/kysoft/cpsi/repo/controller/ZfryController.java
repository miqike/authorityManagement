package com.kysoft.cpsi.repo.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.Zfry;
import com.kysoft.cpsi.repo.service.ZfryService;

import net.sf.husky.exception.ExceptionUtils;
import net.sf.husky.log.MongoLogger;
import net.sf.husky.utils.HuskyConstants;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.WebUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 5/6/2015.
 */
@RestController
@RequestMapping("/21/2102")
public class ZfryController extends net.sf.husky.web.controller.BaseController {

    @Resource
    ZfryService zfryService;
    
    String moduleName = HuskyConstants.MODULE_SYSTEM;
    
    @RequestMapping(value = "", method = RequestMethod.GET)
    public Map<String, Object> query(HttpServletRequest request) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            Map<String, Object> params = WebUtils.getParametersStartingWith(request, "");
            List<Zfry> queryResult = zfryService.query(params);
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
    public Map<String, Object> add(Zfry zfry) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "保存成功");
            result.put(STATUS, SUCCESS);
            zfryService.insert(zfry);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.PUT)
    public Map<String, Object> update(Zfry zfry) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "修改成功");
            result.put(STATUS, SUCCESS);
            zfryService.update(zfry);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "修改失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public Map<String, Object> delete(String code) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "删除成功");
            result.put(STATUS, SUCCESS);
            zfryService.delete(code);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "删除失败");
        }
        return result;
    }
    
    @RequestMapping(value = "{code}/lock", method = RequestMethod.GET)
    public Map<String, Object> lock(@PathVariable String code) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(STATUS, SUCCESS);
            int targetStatus = zfryService.lock(code);
            MongoLogger.info(moduleName, "管理员" + (targetStatus == 1 ? "注销" : "解除注销") + "执法人员成功: " + code, null, code);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, e.getMessage());
            String errCode = MongoLogger.error(moduleName, "管理员注销/解除注销执法人员成功: " + code, ExceptionUtils.getStackTrace(e), code);
            result.put(ERROR, errCode);
        }
        return result;
    }
    
    @RequestMapping(value = "/{code}/{userId}", method = RequestMethod.POST)
    public Map<String, Object> addSysUser(@PathVariable String code, @PathVariable String userId) {
        Map<String, Object> result = Maps.newHashMap();
        try {
        	zfryService.addSysUser(code, userId);
            result.put(MESSAGE, "添加操作员成功,用户初始密码已发送至用户手机");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, e.getMessage());
        }
        return result;
    }
}
