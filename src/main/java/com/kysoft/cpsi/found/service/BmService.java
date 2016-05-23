package com.kysoft.cpsi.found.service;

import com.kysoft.cpsi.found.entity.Bm;

import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 7/20/2015.
 */
public interface BmService {
    void insert(Bm bm);

    void delete(String id);

    void update(Bm bm);

    List<Bm> query(Map<String, Object> params);
}
