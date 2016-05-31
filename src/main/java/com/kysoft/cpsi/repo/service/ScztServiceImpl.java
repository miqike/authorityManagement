package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Sczt;
import com.kysoft.cpsi.repo.mapper.ScztMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("scztService")
public class ScztServiceImpl implements ScztService {

    @Resource
    ScztMapper scztMapper;

    @Override
    public void insert(Sczt sczt) {
        if (sczt.getXydm() == null || sczt.getXydm().equals("")) {
            sczt.setXydm(UUID.randomUUID().toString().replace("-", ""));
        }
        scztMapper.insert(sczt);
    }

    @Override
    public void delete(String xydm) {
        scztMapper.deleteByPrimaryKey(xydm);
    }

    @Override
    public void update(Sczt sczt) {
        scztMapper.updateByPrimaryKey(sczt);
    }

    @Override
    public List<Sczt> query(Map<String, Object> params) {
        return scztMapper.query(params);
    }

    @Override
    public List<Map<String, Object>> queryHccl(String xydm) {
        Map<String, Object> params = new HashMap<>();
        params.put("xydm", xydm);
        return scztMapper.queryHccl(params);
    }
}
