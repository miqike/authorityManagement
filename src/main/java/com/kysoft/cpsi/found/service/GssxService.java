package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.Gssx;

import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 7/20/2015.
 */
public interface GssxService {
    void insert(Gssx gssx);

    void delete(String id);

    void update(Gssx gssx);

    List<Gssx> query(Map<String, Object> params);
}
