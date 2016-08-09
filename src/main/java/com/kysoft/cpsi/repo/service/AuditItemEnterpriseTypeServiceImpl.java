package com.kysoft.cpsi.repo.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.AuditItemEnterpriseType;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.AuditItemEnterpriseTypeMapper;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;

import net.sf.husky.codelist.service.CodeListProvider;

@Service
public class AuditItemEnterpriseTypeServiceImpl implements AuditItemEnterpriseTypeService {

	@Resource
	HcsxMapper hcsxMapper;
	
	@Resource
	AuditItemEnterpriseTypeMapper auditItemEnterpriseTypeMapper;
	
	@Resource
	CodeListProvider codeListProvider;
	
	@Override
	public void save(String hcsxId, Integer[] ztlxIds) {
		Hcsx hcsx = hcsxMapper.selectByPrimaryKey(hcsxId);
		auditItemEnterpriseTypeMapper.deleteByHcsxId(hcsxId);
		for(int i=0; i<ztlxIds.length; i++) {
			AuditItemEnterpriseType aiet = new AuditItemEnterpriseType();
			aiet.setHcsxId(hcsxId);
			aiet.setHcsxName(hcsx.getName());
			aiet.setZtlxId(ztlxIds[i]);
			aiet.setZtlxName(codeListProvider.trans("qylxdl", String.valueOf(ztlxIds[i])));
			auditItemEnterpriseTypeMapper.insert(aiet);
		}
		
	}


}
