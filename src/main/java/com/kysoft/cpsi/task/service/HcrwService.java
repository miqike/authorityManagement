package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.task.entity.Hcrw;

import java.util.List;
import java.util.Map;

public interface HcrwService {

    Integer getTaskInitStatus(String hcrwId);

    void initTaskItem(String hcrwId);

    void pullData(String hcrwId);

    List<Map> getHcsxCode(String hcrwId);

    Hcrw getHcrwById(String hcrwId);

    void updateHcrw(Hcrw hcrw);

    List<Hcrw> queryForOrg(Map<String, Object> params);

	void accept(String planId, List<String> taskIds);

}
