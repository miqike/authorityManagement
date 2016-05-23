package com.kysoft.cpsi.found.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.found.entity.Xgbm;
import com.kysoft.cpsi.found.service.XgbmService;
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
@RequestMapping("/11/1107")
public class XgbmController extends net.sf.husky.web.controller.BaseController {

    @Resource
    XgbmService xgbmService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public Map<String, Object> query(HttpServletRequest request) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            Map<String, Object> params = WebUtils.getParametersStartingWith(request, "");
            List<Xgbm> queryResult = xgbmService.query(params);
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
    public Map<String, Object> add(Xgbm xgbm) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "保存成功");
            result.put(STATUS, SUCCESS);
            xgbmService.insert(xgbm);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.PUT)
    public Map<String, Object> update(Xgbm xgbm) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "修改成功");
            result.put(STATUS, SUCCESS);
            xgbmService.update(xgbm);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "修改失败");
        }
        return result;
    }

    @RequestMapping(value = "", method = RequestMethod.DELETE)
    public Map<String, Object> delete(String id) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(MESSAGE, "删除成功");
            result.put(STATUS, SUCCESS);
            xgbmService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "删除失败");
        }
        return result;
    }
}
