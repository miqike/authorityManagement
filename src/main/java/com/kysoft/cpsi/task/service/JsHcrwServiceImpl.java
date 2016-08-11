package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.task.entity.JsHcrw;
import com.kysoft.cpsi.task.mapper.JsHcrwMapper;
import net.sf.husky.security.entity.User;
import net.sf.husky.utils.WebUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

@Service("jsHcrwService")
public class JsHcrwServiceImpl implements JsHcrwService {

    @Resource
    JsHcrwMapper jsHcrwMapper;

    @Override
    public void update(JsHcrw jsHcrw) {
        jsHcrwMapper.updateByPrimaryKey(jsHcrw);
    }

    @Override
    public void renLing(String id,int zt) {
        if(zt==1) {
            User user = WebUtils.getCurrentUser();
            JsHcrw jsHcrw = jsHcrwMapper.selectByPrimaryKey(id);
            jsHcrw.setRlr(user.getUserId());
            jsHcrw.setRlrmc(user.getName());
            jsHcrw.setRlrq(new Date());
            jsHcrw.setZfryCode(user.getZfry());
            jsHcrw.setZfryName(user.getName());
            jsHcrw.setRwzt(2);//已认领
            jsHcrwMapper.updateByPrimaryKey(jsHcrw);
        }else{
            JsHcrw jsHcrw = jsHcrwMapper.selectByPrimaryKey(id);
            jsHcrw.setRlr("");
            jsHcrw.setRlrmc("");
            jsHcrw.setRlrq(null);
            jsHcrw.setZfryCode("");
            jsHcrw.setZfryName("");
            jsHcrw.setRwzt(1);//未认领
            jsHcrwMapper.updateByPrimaryKey(jsHcrw);
        }
    }
}
