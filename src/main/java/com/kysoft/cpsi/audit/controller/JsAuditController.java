package com.kysoft.cpsi.audit.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.audit.entity.MailVerifyException;
import com.kysoft.cpsi.audit.service.JsAuditService;
import com.kysoft.cpsi.task.service.JsHcsxjgService;
import net.sf.husky.log.service.LogService;
import net.sf.husky.web.controller.BaseController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
@RequestMapping("/js/audit")
public class JsAuditController extends BaseController {

    @Resource
    JsAuditService jsAuditService;

    @Resource
    JsHcsxjgService jsHcsxjgService;

    @Resource
    LogService logService;

    @RequestMapping(value = "/complete", method = RequestMethod.POST)
    public Map<String, Object> complete(String hcrwId, String hcsxId, Integer hcjg, String qymc, String hcsxmc, String sm) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            logService.info("audit", "检查[" + qymc + "]的" + "[" + hcsxmc + "]完成", "检查结果[" + hcjg + "]", hcrwId + "-" + hcsxId);
            jsHcsxjgService.complete(hcrwId, hcsxId, hcjg, sm);
            result.put(MESSAGE, "检查[" + qymc + "]的" + "[" + hcsxmc + "]完成");
            result.put(STATUS, SUCCESS);
        } catch (MailVerifyException e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "检查[" + qymc + "]的" + "[" + hcsxmc + "]失败");
            logService.info("audit", "检查[" + qymc + "]的" + "[" + hcsxmc + "]异常", e.toString(), hcrwId + "-" + hcsxId);
        }
        return result;
    }
    
    @RequestMapping(value = "/getCompareInfo", method = RequestMethod.POST)
    public Map<String, Object> getCompareInfo(String hcrwId, String hcsxId) {
        Map<String, Object> result = Maps.newHashMap();
        try {
        	result.putAll(jsAuditService.getCompareInfo(hcrwId, hcsxId));
            result.put(MESSAGE, "获得比对数据成功");
            result.put(STATUS, SUCCESS);
        } catch (MailVerifyException e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "获得比对数据失败: " + e.getMessage());
        }
        return result;
    }


}
