package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.repo.entity.AuditItemEnterpriseType;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.AuditItemEnterpriseTypeMapper;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import net.sf.husky.codelist.service.CodeListProvider;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AuditItemEnterpriseTypeServiceImpl implements AuditItemEnterpriseTypeService {

	@Resource
	HcsxMapper hcsxMapper;
	
	@Resource
	AuditItemEnterpriseTypeMapper auditItemEnterpriseTypeMapper;
	
	@Resource
	CodeListProvider codeListProvider;
	
	@Override
	public void save(String hcsxId, String[] ztlxIds) {
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
