package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.task.entity.Hcclmx;

public interface HcclmxService {

	void delete(String id);

	void addHcclmx(Hcclmx hcclmx);
	void addHcclmxJs(Hcclmx hcclmx);

	void delete2(String id);
	
	void addHcclmx2(Hcclmx hcclmx);
	void addJsHcclmx2(Hcclmx hcclmx);

	void updateHcclmx2(Hcclmx hcclmx);

	String getDxnMongoIdByHcrwId(String hcrwId,String dxnType);

}
