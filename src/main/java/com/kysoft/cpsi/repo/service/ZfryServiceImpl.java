package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Zfry;
import com.kysoft.cpsi.repo.mapper.ZfryMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("zfryService")
public class ZfryServiceImpl implements ZfryService {

    @Resource
    ZfryMapper zfryMapper;

    @Override
    public void insert(Zfry zfry) {
        zfryMapper.insert(zfry);
    }

    @Override
    public void delete(String code) {
        zfryMapper.deleteByPrimaryKey(code);
    }

    @Override
    public void update(Zfry zfry) {
        zfryMapper.updateByPrimaryKey(zfry);
    }

    @Override
    public List<Zfry> query(Map<String, Object> params) {
        return zfryMapper.query(params);
    }
}
