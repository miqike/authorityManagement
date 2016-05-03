package com.kysoft.kteam.leave.controller;

import com.google.common.collect.Maps;
import com.kysoft.kteam.leave.domain.Leave;
import com.kysoft.kteam.leave.service.LeaveService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by Tommy on 5/6/2015.
 */
@RestController
@RequestMapping("/22/leave")
public class LeaveController extends net.sf.husky.web.controller.BaseController {
    @Resource
    LeaveService leaveService;

    @RequestMapping(value = "", method = RequestMethod.POST)
    public Map<String, Object> save(Leave leave) {
        Map<String, Object> result = Maps.newHashMap();
        try {
            leaveService.askForLeave(leave);
            result.put(MESSAGE,  "保存成功");
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            result.put(STATUS, FAIL);
            result.put(MESSAGE, "保存失败");
        }
        return result;
    }


}
