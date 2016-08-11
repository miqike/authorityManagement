package com.kysoft.cpsi.task.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.entity.JsHcrw;
import com.kysoft.cpsi.task.service.JsHcrwService;

import net.sf.husky.log.MongoLogger;
import net.sf.husky.web.controller.BaseController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

@RestController
@RequestMapping("/51")
public class JsHcrwController extends BaseController {

    @Resource
    JsHcrwService jsHcrwService;

    @RequestMapping(value = "/js/update", method = RequestMethod.POST)
    public Map<String, Object> update(JsHcrw jsHcrw) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            jsHcrwService.update(jsHcrw);
            result.put(MESSAGE, "更新操作成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "更新操作失败");
        }
        return result;
    }

    @RequestMapping(value = "/js/renLing", method = RequestMethod.POST)
    public Map<String, Object> renLing(String id,int zt) {
        Map<String, Object> result = Maps.newHashMap();
        String renLingMessage;
        if(zt==1){
            renLingMessage="认领";
            MongoLogger.info("task", "认领操作成功");
        }else{
            renLingMessage="取消认领";
            MongoLogger.info("task", "取消认领");
        }
        try {
            jsHcrwService.renLing(id,zt);
            result.put(MESSAGE, renLingMessage+"操作成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, renLingMessage+"操作失败");
        }
        return result;
    }

}
