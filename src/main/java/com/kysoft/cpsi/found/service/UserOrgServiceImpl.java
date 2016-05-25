package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.UserOrg;
import com.kysoft.cpsi.found.entity.UserOrgKey;
import com.kysoft.cpsi.found.mapper.UserOrgMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("userOrgService")
public class UserOrgServiceImpl implements UserOrgService {

    @Resource
    UserOrgMapper userOrgMapper;

    @Override
    public void insert(UserOrg userOrg) {
        userOrgMapper.insert(userOrg);
    }

    @Override
    public void delete(UserOrgKey userOrgKey) {
        userOrgMapper.deleteByPrimaryKey(userOrgKey);
    }

    @Override
    public void update(UserOrg userOrg) {
        userOrgMapper.updateByPrimaryKey(userOrg);
    }

    @Override
    public List<UserOrg> query(Map<String, Object> params) {
        return userOrgMapper.query(params);
    }
}
