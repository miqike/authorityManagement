package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.Gssx;
import com.kysoft.cpsi.found.mapper.GssxMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.UUID;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("gssxService")
public class GssxServiceImpl implements GssxService {

    @Resource
    GssxMapper gssxMapper;

    @Override
    public void insert(Gssx gssx) {
        if (gssx.getId() == null || gssx.getId().equals("")) {
            gssx.setId(UUID.randomUUID().toString().replace("-", ""));
        }
        gssxMapper.insert(gssx);
    }

    @Override
    public void delete(String id) {
        gssxMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Gssx gssx) {
        gssxMapper.updateByPrimaryKey(gssx);
    }

    @Override
    public List<Gssx> query(Map<String, Object> params) {
        return gssxMapper.query(params);
    }
}
