package com.kysoft.cpsi.task.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.task.mapper.HcjhMapper;

@Service("hcjhService")
public class HcjhServiceImpl implements HcjhService {
	
	@Resource 
	HcjhMapper hcjhMapper;

}
