package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Sczt;

import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 7/20/2015.
 */
public interface ScztService {
    void insert(Sczt sczt);

    void delete(String xydm);

    void update(Sczt sczt);

    List<Sczt> query(Map<String, Object> params);

    List<Map<String, Object>> queryHccl(String xydm);
}
