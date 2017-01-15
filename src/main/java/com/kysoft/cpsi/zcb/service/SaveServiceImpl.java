package com.kysoft.cpsi.zcb.service;


import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.zcb.entity.SctDwdb;
import com.kysoft.cpsi.zcb.entity.SctDwtz;
import com.kysoft.cpsi.zcb.entity.SctGdcz;
import com.kysoft.cpsi.zcb.entity.SctGqbg;
import com.kysoft.cpsi.zcb.entity.SctGsxxzcb;
import com.kysoft.cpsi.zcb.entity.SctLrb;
import com.kysoft.cpsi.zcb.entity.SctXjllb;
import com.kysoft.cpsi.zcb.entity.SctXzcf;
import com.kysoft.cpsi.zcb.entity.SctXzxk;
import com.kysoft.cpsi.zcb.entity.SctZcfzb;
import com.kysoft.cpsi.zcb.entity.SctZscq;
import com.kysoft.cpsi.zcb.mapper.SctDwdbMapper;
import com.kysoft.cpsi.zcb.mapper.SctDwtzMapper;
import com.kysoft.cpsi.zcb.mapper.SctGdczMapper;
import com.kysoft.cpsi.zcb.mapper.SctGqbgMapper;
import com.kysoft.cpsi.zcb.mapper.SctGsxxzcbMapper;
import com.kysoft.cpsi.zcb.mapper.SctLrbMapper;
import com.kysoft.cpsi.zcb.mapper.SctXjllbMapper;
import com.kysoft.cpsi.zcb.mapper.SctXzcfMapper;
import com.kysoft.cpsi.zcb.mapper.SctXzxkMapper;
import com.kysoft.cpsi.zcb.mapper.SctZcfzbMapper;
import com.kysoft.cpsi.zcb.mapper.SctZscqMapper;
@Service("saveService")
public class SaveServiceImpl implements SaveService {
	@Resource
	SctZcfzbMapper zcfzbMapper;
	@Resource
	SctDwdbMapper  dwdbMapper;
	@Resource
	SctGdczMapper gdczMapper;
	@Resource
	SctGqbgMapper gqbgMapper;
	@Resource
	SctLrbMapper lrbMapper;
	@Resource
	SctGsxxzcbMapper gsxxzcbMapper;
	@Resource
	SctDwtzMapper dwtzMapper;
	@Resource
	SctXjllbMapper xjllMapper;
	@Resource
	SctXzcfMapper xzcfMapper;
	@Resource
	SctXzxkMapper xzxkMapper;
	@Resource
	SctZscqMapper zscqMapper;
	@Override
	public void saveZCFZ(SctZcfzb zcfz) {
		// TODO Auto-generated method stub
		zcfzbMapper.insert(zcfz);
	}

	@Override
	public void saveDWDB(SctDwdb dwdb) {
		// TODO Auto-generated method stub
		dwdbMapper.insert(dwdb);
	}

	@Override
	public void saveGDCZ(SctGdcz gdcz) {
		// TODO Auto-generated method stub
		gdczMapper.insert(gdcz);
	}

	@Override
	public void saveGQBG(SctGqbg gqbg) {
		// TODO Auto-generated method stub
		gqbgMapper.insert(gqbg);
	}

	@Override
	public void saveLR(SctLrb lrb) {
		// TODO Auto-generated method stub
		lrbMapper.insert(lrb);
		
	}

	@Override
	public void saveGSXXZCB(SctGsxxzcb gsxxzcb) {
		// TODO Auto-generated method stub
		gsxxzcbMapper.insert(gsxxzcb);
	}

	@Override
	public void saveDWTZ(SctDwtz dwtz) {
		// TODO Auto-generated method stub
		dwtzMapper.insert(dwtz);
	}

	@Override
	public void saveXJLL(SctXjllb xjllb) {
		// TODO Auto-generated method stub
		xjllMapper.insert(xjllb);
	}

	@Override
	public void saveXZCF(SctXzcf xzcf) {
		// TODO Auto-generated method stub
		xzcfMapper.insert(xzcf);
	}

	@Override
	public void saveXZXK(SctXzxk xzxk) {
		// TODO Auto-generated method stub
		xzxkMapper.insert(xzxk);
	}

	@Override
	public void saveZSCQ(SctZscq zscq) {
		// TODO Auto-generated method stub
		zscqMapper.insert(zscq);
	}

}
