package com.kysoft.cpsi.zcb.service;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.zcb.entity.SctZcfzb;
import com.kysoft.cpsi.zcb.mapper.SctZcfzbMapper;
@Service("saveService")
public class SaveServiceImpl implements SaveService {
	@Resource
	SctZcfzbMapper zcfzbMapper;

	@Override
	public void saveZCFZ(SctZcfzb zcfz) {
		// TODO Auto-generated method stub
		zcfzbMapper.insert(zcfz);
	}

}
