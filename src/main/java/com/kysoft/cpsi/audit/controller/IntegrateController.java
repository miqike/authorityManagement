package com.kysoft.cpsi.audit.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.audit.entity.MailVerifyException;
import net.sf.husky.web.controller.BaseController;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/eai")
public class IntegrateController extends BaseController {

    @RequestMapping(value = "", method = RequestMethod.POST)
    public Map<String, Object> sentVerifyMail(@RequestBody String eaiData) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            System.out.println(eaiData);
            result.put(MESSAGE, "数据接收成功");
            result.put(STATUS, SUCCESS);
        } catch (MailVerifyException e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "数据接收失败: " + e.getMessage());
        }
        return result;
    }

}
