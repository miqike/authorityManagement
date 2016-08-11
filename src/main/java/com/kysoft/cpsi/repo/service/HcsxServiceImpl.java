package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;

import net.sf.husky.log.MongoLogger;

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
        MongoLogger.info("repo", "增加核查事项",null,hcsx.getId());
    }

    @Override
    public void delete(String id) {
        hcsxMapper.deleteByPrimaryKey(id);
        MongoLogger.info("repo", "删除核查事项",null,id);
    }

    @Override
    public void update(Hcsx hcsx) {
        hcsxMapper.updateByPrimaryKey(hcsx);
        MongoLogger.info("repo", "修改查事项",null,hcsx.getId());
    }

    @Override
    public List<Hcsx> query(Map<String, Object> params) {
        return hcsxMapper.query(params);
    }

	@Override
	public void disable(String hcsxId, Integer disableFlag, String zxsm) {
		hcsxMapper.updateDisable(hcsxId, disableFlag, zxsm);
		 MongoLogger.info("repo", "注销核查事项",null,hcsxId);
	}
}
