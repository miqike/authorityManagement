package com.kysoft.cpsi.task.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.task.mapper.HcjhMapper;
import com.kysoft.cpsi.task.mapper.JhSxMapper;

@Service("hcjhService")
public class HcjhServiceImpl implements HcjhService {
	
	@Resource 
	HcjhMapper hcjhMapper;
	
	@Resource 
	JhSxMapper jhSxMapper;

	@Override
	public void saveCheckList(String hcjhId, String[] hcsxIds) {
		// TODO Auto-generated method stub
        if(hcsxIds.length > 0)
        	jhSxMapper.insertBatch(hcjhId, hcsxIds);
	}

}
