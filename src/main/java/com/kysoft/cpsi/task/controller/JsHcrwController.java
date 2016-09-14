package com.kysoft.cpsi.task.controller;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.entity.JsHcrw;
import com.kysoft.cpsi.task.service.JsHcrwService;
import net.sf.husky.web.controller.BaseController;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/51/js")
public class JsHcrwController extends BaseController {

    @Resource
    JsHcrwService jsHcrwService;

    @RequestMapping(value = "/update", method = RequestMethod.POST)
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

    @RequestMapping(value = "/renLing", method = RequestMethod.POST)
    public Map<String, Object> renLing(String id,int zt) {
        Map<String, Object> result = Maps.newHashMap();
        String renLingMessage;
        if(zt==1){
            renLingMessage="认领";
        }else{
            renLingMessage="取消认领";
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

    @RequestMapping(value = "/{hcrwId}/initStatus", method = RequestMethod.GET)
    public Map<String, Object> getHcrwInitStatus(@PathVariable String hcrwId) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            Integer count = jsHcrwService.getTaskInitStatus(hcrwId);
            result.put(MESSAGE, "检查事项初始成功");
            result.put(STATUS, SUCCESS);
            result.put(DATA, count);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "检查事项初始失败");
        }
        return result;
    }

    //加载在线数据
    @RequestMapping(value = "/{hcrwId}/pull", method = RequestMethod.GET)
    public Map<String, Object> pullData(@PathVariable String hcrwId,Integer reNewFlag) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            result.put(DATA, jsHcrwService.pullData(hcrwId,reNewFlag));
            result.put(MESSAGE, "检查任务在线数据加载成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "检查任务在线数据加载失败");
        }
        return result;
    }

    @RequestMapping(value = "/{hcrwId}/jieguo", method = RequestMethod.POST)
    public Map<String, Object> updateJieguo(@PathVariable String hcrwId, Integer jieguo) {
        Map<String, Object> result = Maps.newHashMap();

        try {
            JsHcrw hcrw = jsHcrwService.getHcrwById(hcrwId);
            //核查结果为6种,只要设定核查结果,任务设为完成状态:5
            hcrw.setRwzt(5);
            hcrw.setHcjieguo(jieguo);
            hcrw.setSjwcrq(new Date());
            hcrw.setRwzt(2);
            jsHcrwService.updateHcrw(hcrw);
            result.put(MESSAGE, "更新核查结果成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "更新核查结果失败");
        }
        return result;
    }

    @RequestMapping(value = "/hcsx", method = RequestMethod.GET)
    public List<Map> getHcsxCode() {
        return jsHcrwService.getHcsxCode();
    }
}
