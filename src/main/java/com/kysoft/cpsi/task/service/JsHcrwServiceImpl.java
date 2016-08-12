package com.kysoft.cpsi.task.service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.entity.JsHcrw;
import com.kysoft.cpsi.task.entity.JsHcsxjg;
import com.kysoft.cpsi.task.mapper.JsHcrwMapper;
import com.kysoft.cpsi.task.mapper.JsHcsxjgMapper;
import net.sf.husky.log.MongoLogger;
import net.sf.husky.security.entity.User;
import net.sf.husky.utils.WebUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service("jsHcrwService")
public class JsHcrwServiceImpl implements JsHcrwService {

    @Resource
    JsHcrwMapper jsHcrwMapper;
    @Resource
    JsHcsxjgMapper jsHcsxjgMapper;
    @Resource
    HcsxMapper hcsxMapper;

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
            MongoLogger.info("task", "认领操作成功");
        }else{
            JsHcrw jsHcrw = jsHcrwMapper.selectByPrimaryKey(id);
            jsHcrw.setRlr("");
            jsHcrw.setRlrmc("");
            jsHcrw.setRlrq(null);
            jsHcrw.setZfryCode("");
            jsHcrw.setZfryName("");
            jsHcrw.setRwzt(1);//未认领
            jsHcrwMapper.updateByPrimaryKey(jsHcrw);
            MongoLogger.info("task", "取消认领操作");
        }
    }

    @Override
    public Integer getTaskInitStatus(String hcrwId) {
        return jsHcsxjgMapper.selectCountByTaskId(hcrwId);
    }

    @Override
    public List<JsHcsxjg> pullData(String hcrwId,Integer reNewFlag) {
        Map<String, Object> param = Maps.newHashMap();
        param.put("hcrwId", hcrwId);
        List<JsHcsxjg> hcsxjgs=jsHcsxjgMapper.queryForTask(param);
        if(reNewFlag==0) {
            if (hcsxjgs.size() > 0) {
                return hcsxjgs;
            } else {
                jsHcrwMapper.pullData(param);
                jsHcrwMapper.compareData(param);
                hcsxjgs = jsHcsxjgMapper.queryForTask(param);
                return hcsxjgs;
            }
        }else{
            jsHcrwMapper.pullData(param);
            jsHcrwMapper.compareData(param);
            hcsxjgs = jsHcsxjgMapper.queryForTask(param);
            return hcsxjgs;
        }
    }

    @Override
    public JsHcrw getHcrwById(String hcrwId) {
        return jsHcrwMapper.selectByPrimaryKey(hcrwId);
    }

    @Override
    public void updateHcrw(JsHcrw jsHcrw) {
        jsHcrwMapper.updateByPrimaryKey(jsHcrw);
    }

    @Override
    public List<Map> getHcsxCode() {
        return hcsxMapper.getJsHcsxCode();
    }
}
