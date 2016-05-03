package com.kysoft.kteam.task.service;

import java.util.Date;
import java.util.List;

import com.kysoft.kteam.plan.entity.Plan;

/**
 * Created by Tommy on 10/10/2015.
 */
public interface TaskService {
    List<Plan> getTask(Date start, Date end);

//    Task save(Task task);

}
