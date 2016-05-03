package com.kysoft.kteam.plan.service;

import java.util.List;

import com.kysoft.kteam.plan.entity.Attachment;

/**
 * Created by Tommy on 12/1/2015.
 */
public interface AttachmentService {

    List<Attachment> getPlanAttachments(String planId);

    void save(Attachment attachment);

    void delte(String mongoId);
}
