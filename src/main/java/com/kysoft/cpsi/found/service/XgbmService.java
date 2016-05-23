package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.Xgbm;

import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 7/20/2015.
 */
public interface XgbmService {
    void insert(Xgbm xgbm);

    void delete(String id);

    void update(Xgbm xgbm);

    List<Xgbm> query(Map<String, Object> params);
}
