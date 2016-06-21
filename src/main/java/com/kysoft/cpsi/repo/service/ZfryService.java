package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Zfry;

import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 7/20/2015.
 */
public interface ZfryService {
    void insert(Zfry zfry);

    void delete(String code);

    void update(Zfry zfry);

    List<Zfry> query(Map<String, Object> params);

	int lock(String code);

	void addSysUser(String code, String userId);
}
