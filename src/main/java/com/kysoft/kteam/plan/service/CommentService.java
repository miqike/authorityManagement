package com.kysoft.kteam.plan.service;

import java.util.List;

import com.kysoft.kteam.plan.entity.Comment;

/**
 * Created by Tommy on 12/1/2015.
 */
public interface CommentService {

    List<Comment> getPlanComments(String planId);

    void save(Comment comment);
}
