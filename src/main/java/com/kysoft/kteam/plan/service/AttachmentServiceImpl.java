package com.kysoft.kteam.plan.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.kteam.plan.entity.Attachment;
import com.kysoft.kteam.plan.mapper.AttachmentMapper;

import net.sf.husky.attachment.utils.DownloadUtils;

/**
 * Created by Tommy on 12/1/2015.
 */

@Service
public class AttachmentServiceImpl implements AttachmentService {

    @Resource
    AttachmentMapper attachmentMapper;

    @Override
    public List<Attachment> getPlanAttachments(String planId) {
        return attachmentMapper.selectByPlanId(planId);
    }

    @Override
    public void save(Attachment attachment) {
        attachment.setCreateTime(new Date());
        attachmentMapper.insert(attachment);
    }

    @Override
    public void delte(String mongoId) {

        attachmentMapper.deleteByMongoId(mongoId);
        DownloadUtils.mongoDelete(mongoId);
    }
}



