package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.UUID;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("hcsxService")
public class HcsxServiceImpl implements HcsxService {

    @Resource
    HcsxMapper hcsxMapper;

    @Override
    public void insert(Hcsx hcsx) {
        if (hcsx.getId() == null || hcsx.getId().equals("")) {
            hcsx.setId(UUID.randomUUID().toString().replace("-", ""));
        }
        hcsxMapper.insert(hcsx);
    }

    @Override
    public void delete(String id) {
        hcsxMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void update(Hcsx hcsx) {
        hcsxMapper.updateByPrimaryKey(hcsx);
    }

    @Override
    public List<Hcsx> query(Map<String, Object> params) {
        return hcsxMapper.query(params);
    }
}
