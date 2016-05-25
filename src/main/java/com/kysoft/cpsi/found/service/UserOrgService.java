package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.UserOrg;
import com.kysoft.cpsi.found.entity.UserOrgKey;

import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 7/20/2015.
 */
public interface UserOrgService {
    void insert(UserOrg userOrg);

    void delete(UserOrgKey userOrgKey);

    void update(UserOrg userOrg);

    List<UserOrg> query(Map<String, Object> params);
}
