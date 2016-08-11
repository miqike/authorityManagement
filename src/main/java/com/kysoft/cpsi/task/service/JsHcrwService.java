package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.task.entity.JsHcrw;
import com.kysoft.cpsi.task.entity.JsHcsxjg;

import java.util.List;

public interface JsHcrwService {

    void update(JsHcrw jsHcrw);
    void renLing(String id,int zt);
    Integer getTaskInitStatus(String hcrwId);
    List<JsHcsxjg> pullData(String hcrwId,Integer reNewFlag);

}
