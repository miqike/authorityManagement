package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.Hcsx;

import java.util.List;
import java.util.Map;

/**
 * Created by Tommy on 7/20/2015.
 */
public interface HcsxService {
    void insert(Hcsx hcsx);

    void delete(String id);

    void update(Hcsx hcsx);

    List<Hcsx> query(Map<String, Object> params);
}
