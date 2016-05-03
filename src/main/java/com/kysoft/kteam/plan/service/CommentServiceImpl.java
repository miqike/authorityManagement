package com.kysoft.kteam.plan.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.kteam.plan.entity.Comment;
import com.kysoft.kteam.plan.mapper.CommentMapper;

import net.sf.husky.security.entity.User;
import net.sf.husky.utils.HuskyConstants;
import net.sf.husky.utils.WebUtils;

/**
 * Created by Tommy on 12/1/2015.
 */

@Service
public class CommentServiceImpl implements CommentService {

    @Resource
    CommentMapper commentMapper;

    @Override
    public List<Comment> getPlanComments(String planId) {
        return commentMapper.selectByPlanId(planId);
    }

    @Override
    public void save(Comment comment) {
        comment.setId(UUID.randomUUID().toString().trim().replaceAll(HuskyConstants.DASH, HuskyConstants.BLANK));
        User user = WebUtils.getCurrentUser();
        comment.setAuthorId(user.getUserId());
        comment.setAuthorName(user.getName());
        comment.setCreateTime(new Date());
        commentMapper.insert(comment);
    }
}
