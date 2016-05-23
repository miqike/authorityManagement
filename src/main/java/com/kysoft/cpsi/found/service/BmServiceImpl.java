package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.Bm;
import com.kysoft.cpsi.found.mapper.BmMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.UUID;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("bmService")
public class BmServiceImpl implements BmService {

    @Resource
    BmMapper bmMapper;

    @Override
    public void insert(Bm bm) {
        if (bm.getId() == null || bm.getId().equals("")) {
            bm.setId(UUID.randomUUID().toString().replace("-", ""));
        }
        bmMapper.insert(bm);
    }

    @Override
    public void delete(String id) {
        bmMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Bm bm) {
        bmMapper.updateByPrimaryKey(bm);
    }

    @Override
    public List<Bm> query(Map<String, Object> params) {
        return bmMapper.query(params);
    }
}
