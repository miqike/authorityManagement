package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.Xgbm;
import com.kysoft.cpsi.found.mapper.XgbmMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.UUID;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("xgbmService")
public class XgbmServiceImpl implements XgbmService {

    @Resource
    XgbmMapper xgbmMapper;

    @Override
    public void insert(Xgbm xgbm) {
        if (xgbm.getId() == null || xgbm.getId().equals("")) {
            xgbm.setId(UUID.randomUUID().toString().replace("-", ""));
        }
        xgbmMapper.insert(xgbm);
    }

    @Override
    public void delete(String id) {
        xgbmMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Xgbm xgbm) {
        xgbmMapper.updateByPrimaryKey(xgbm);
    }

    @Override
    public List<Xgbm> query(Map<String, Object> params) {
        return xgbmMapper.query(params);
    }
}
