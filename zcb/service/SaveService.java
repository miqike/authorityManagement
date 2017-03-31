package com.kysoft.cpsi.zcb.service;

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

public interface SaveService {
	void saveZCFZ(SctZcfzb zcfz);
	void saveDWDB(SctDwdb dwdb);
	void saveGDCZ(SctGdcz gdcz);
	void saveGQBG(SctGqbg gqbg);
	void saveLR(SctLrb lrb);
	void saveGSXXZCB(SctGsxxzcb gsxxzcb);
	void saveDWTZ(SctDwtz dwtz);
	void saveXJLL(SctXjllb xjllb);
	void saveXZCF(SctXzcf xzcf);
	void saveXZXK(SctXzxk xzxk);
	void saveZSCQ(SctZscq zscq);
	
}
