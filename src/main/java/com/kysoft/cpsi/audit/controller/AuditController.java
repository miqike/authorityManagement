package com.kysoft.cpsi.audit.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.audit.entity.MailVerifyException;
import com.kysoft.cpsi.audit.service.AuditService;
import com.kysoft.cpsi.task.service.HcsxjgService;
import net.sf.husky.log.service.LogService;
import net.sf.husky.web.controller.BaseController;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
@RequestMapping("/audit")
public class AuditController extends BaseController {

    @Resource
    AuditService auditService;

    @Resource
    HcsxjgService hcsxjgService;

    @Resource
    LogService logService;

    @RequestMapping(value = "/sentVerifyMail", method = RequestMethod.POST)
    public Map<String, Object> sentVerifyMail(String hcrwId,
                                              String hcsxId,
                                              String mail) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            auditService.sentVerifyMail(hcrwId, hcsxId, mail);
            result.put(MESSAGE, "验证邮件发送成功");
            result.put(STATUS, SUCCESS);
        } catch (MailVerifyException e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "验证邮件发送失败: " + e.getMessage());
        }
        return result;
    }


    @RequestMapping(value = "/mail/{id}", method = RequestMethod.GET)
    public Map<String, Object> verifyMail(@PathVariable String id) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            auditService.verifyMail(id);
            result.put(MESSAGE, "邮件验证成功");
            result.put(STATUS, SUCCESS);
        } catch (MailVerifyException e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "邮件验证失败: " + e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/complete", method = RequestMethod.POST)
    public Map<String, Object> complete(String hcrwId, String hcsxId, Integer hcjg, String qymc, String hcsxmc) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            logService.info("audit", "核查[" + qymc + "]的" + "[" + hcsxmc + "]完成", "核查结果[" + hcjg + "]", hcrwId + "-" + hcsxId);
            hcsxjgService.complete(hcrwId, hcsxId, hcjg);
            result.put(MESSAGE, "核查[" + qymc + "]的" + "[" + hcsxmc + "]完成");
            result.put(STATUS, SUCCESS);
        } catch (MailVerifyException e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "核查[" + qymc + "]的" + "[" + hcsxmc + "]失败");
            logService.info("audit", "核查[" + qymc + "]的" + "[" + hcsxmc + "]异常", e.toString(), hcrwId + "-" + hcsxId);
        }
        return result;
    }
    
    @RequestMapping(value = "/getCompareInfo", method = RequestMethod.POST)
    public Map<String, Object> getCompareInfo(String hcrwId, String hcsxId) {
        Map<String, Object> result = Maps.newHashMap();
        try {
        	result.putAll(auditService.getCompareInfo(hcrwId, hcsxId));
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
