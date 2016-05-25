package com.kysoft.cpsi.found.controller;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.kysoft.cpsi.found.entity.UserOrg;
import com.kysoft.cpsi.found.entity.UserOrgKey;
import com.kysoft.cpsi.found.service.UserOrgService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.WebUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 5/6/2015.
 */
@RestController
@RequestMapping("/11/1106")
public class UserOrgController extends net.sf.husky.web.controller.BaseController {

    @Resource
    UserOrgService userOrgService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public Map<String, Object> query(HttpServletRequest request) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            Map<String, Object> params = WebUtils.getParametersStartingWith(request, "");
            List<UserOrg> queryResult = userOrgService.query(params);
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
    public Map<String, Object> add(UserOrg userOrg) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "保存成功");
            result.put(STATUS, SUCCESS);
            userOrgService.insert(userOrg);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存失败");
        }
        return result;
    }

    @RequestMapping(value = "/batch", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> add(@RequestBody List<JSONObject> userOrgs) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "批量保存成功");
            result.put(STATUS, SUCCESS);
            for (JSONObject jsonObject : userOrgs) {
                UserOrg userOrg = new UserOrg();
                userOrg.setOrgId(jsonObject.getString("orgId"));
                userOrg.setOrgName(jsonObject.getString("orgName"));
                userOrg.setUserId(jsonObject.getString("userId"));
                userOrg.setUserName(jsonObject.getString("userName"));
                userOrgService.insert(userOrg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "批量保存失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.PUT)
    public Map<String, Object> update(UserOrg userOrg) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "修改成功");
            result.put(STATUS, SUCCESS);
            userOrgService.update(userOrg);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "修改失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public Map<String, Object> delete(UserOrgKey userOrgKey) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "删除成功");
            result.put(STATUS, SUCCESS);
            userOrgService.delete(userOrgKey);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "删除失败");
        }
        return result;
    }

    @RequestMapping(value = "/batch", method = RequestMethod.DELETE)
    @ResponseBody
    public Map<String, Object> delete(@RequestBody List<JSONObject> userOrgs) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "批量删除成功");
            result.put(STATUS, SUCCESS);
            for (JSONObject jsonObject : userOrgs) {
                UserOrg userOrg = new UserOrg();
                userOrg.setOrgId(jsonObject.getString("orgId"));
                userOrg.setOrgName(jsonObject.getString("orgName"));
                userOrg.setUserId(jsonObject.getString("userId"));
                userOrg.setUserName(jsonObject.getString("userName"));
                userOrgService.delete(userOrg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "批量删除失败");
        }
        return result;
    }
}
