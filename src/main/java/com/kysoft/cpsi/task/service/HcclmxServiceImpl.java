package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.repo.entity.Hccl;
import com.kysoft.cpsi.repo.mapper.HcclMapper;
import com.kysoft.cpsi.task.entity.Hcclmx;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.entity.JsHcrw;
import com.kysoft.cpsi.task.mapper.HcclmxMapper;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.JsHcrwMapper;
import net.sf.husky.attachment.utils.DownloadUtils;
import net.sf.husky.log.MongoLogger;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.UUID;

@Service("hcclmxService")
public class HcclmxServiceImpl implements HcclmxService {

    @Resource
    HcclmxMapper hcclmxMapper;
    
    @Resource
    HcrwMapper hcrwMapper;

    @Resource
    JsHcrwMapper jsHcrwMapper;

    @Resource
    HcclMapper hcclMapper;

    @Override
    public void delete(String id) {
        Hcclmx hcclmx = hcclmxMapper.selectByPrimaryKey(id);
        hcclmxMapper.deleteByPrimaryKey(id);
        DownloadUtils.mongoDelete(hcclmx.getMongoId());
//        MongoLogger.info("task", "用户删除附加核查材料", null, id);
    }

    @Override
    public void addHcclmx(Hcclmx hcclmx) {
        Hccl hccl=hcclMapper.selectByPrimaryKey(hcclmx.getHcclId());

        //删除旧数据
        String oldMongoId=hcclmxMapper.getMongoIdByMaterialId(hcclmx.getHcrwId(),hcclmx.getHcclId(),hcclmx.getHcsxId());
        if(null!=oldMongoId) {
            DownloadUtils.mongoDelete(oldMongoId);
        }

        hcclmxMapper.deleteByMaterialId(hcclmx.getHcrwId(),hccl.getMaterialId());
        hcclmxMapper.insertByMaterialId(hccl.getMaterialId(),hcclmx.getHcdwXydm(),hcclmx.getHcjhnd(),hcclmx.getHcrwId(),hcclmx.getMongoId());
/*
        Hcclmx oldHcclmx = hcclmxMapper.selectBy(hcclmx.getHcrwId(), hcclmx.getHcsxId(), hcclmx.getHcdwXydm(), hcclmx.getHcjhnd(), hcclmx.getHcclId());
        if (null != oldHcclmx) {
            hcclmxMapper.deleteByPrimaryKey(oldHcclmx.getId());
        }

        hcclmx.setId(UUID.randomUUID().toString().replace("-", ""));
        hcclmx.setUploadTime(new Date());
        hcclmxMapper.insert(hcclmx);
*/
        MongoLogger.info("task", "附加核查材料添加成功");
        calcDoc(hcclmx.getHcrwId());
    }

    @Override
    public void addHcclmxJs(Hcclmx hcclmx) {
        Hcclmx oldHcclmx = hcclmxMapper.selectJsBy(hcclmx.getHcrwId(), hcclmx.getHcsxId(), hcclmx.getHcdwXydm(), hcclmx.getHcclId());
        if (null != oldHcclmx) {
            DownloadUtils.mongoDelete(oldHcclmx.getMongoId());
            hcclmxMapper.deleteByPrimaryKey(oldHcclmx.getId());
        }

        hcclmx.setId(UUID.randomUUID().toString().replace("-", ""));
        hcclmx.setUploadTime(new Date());
        hcclmxMapper.insert(hcclmx);
        MongoLogger.info("task", "附加核查材料添加成功");
        calcDocJs(hcclmx.getHcrwId());
    }

    public void calcDoc(String hcrwId) {
    	 hcrwMapper.updateHcclStatByPrimaryKey(hcrwId);
         Hcrw hcrw = hcrwMapper.selectByPrimaryKey(hcrwId);
         int uploaded = hcrw.getUploadFiles();
         int required = hcrw.getRequiredFiles();
         int docReadyFlag = 0;
         if(required > 0) {
         	if(uploaded == required) {
         		docReadyFlag = 2;
         	} else if(uploaded > 0) {
         		docReadyFlag = 1;
         	} else {
         		docReadyFlag = 0;
         	}
         }
         hcrwMapper.updateDocReadyFlag(hcrwId, docReadyFlag);
    }

    public void calcDocJs(String hcrwId) {
        jsHcrwMapper.updateHcclStatByPrimaryKey(hcrwId);
        JsHcrw jsHcrw = jsHcrwMapper.selectByPrimaryKey(hcrwId);
        int uploaded = jsHcrw.getUploadFiles();
        int required = jsHcrw.getRequiredFiles();
        int docReadyFlag = 0;
        if(required > 0) {
            if(uploaded == required) {
                docReadyFlag = 2;
            } else if(uploaded > 0) {
                docReadyFlag = 1;
            } else {
                docReadyFlag = 0;
            }
        }
        jsHcrwMapper.updateDocReadyFlag(hcrwId, docReadyFlag);
    }

    @Override
    public void delete2(String id) {
    	Hcclmx hcclmx = hcclmxMapper.selectByPrimaryKey2(id);
    	hcclmxMapper.deleteByPrimaryKey2(id);
    	calcDocFur(hcclmx.getHcrwId());
    	if(null != hcclmx.getMongoId()) {
    		DownloadUtils.mongoDelete(hcclmx.getMongoId());
    	}
    	 MongoLogger.info("task", "用户删除附加核查材料: " + id, null, hcclmx.getHcrwId());
    }
    
    @Override
    public void addHcclmx2(Hcclmx hcclmx) {
    	hcclmx.setId(UUID.randomUUID().toString().replace("-", ""));
    	hcclmxMapper.insert2(hcclmx);
    	calcDocFur(hcclmx.getHcrwId());
    	 MongoLogger.info("task", "用户添加附加核查材料: " + hcclmx.getHcclId(), null, hcclmx.getHcrwId());
    }
    @Override
    public void addJsHcclmx2(Hcclmx hcclmx) {
        hcclmx.setId(UUID.randomUUID().toString().replace("-", ""));
        hcclmxMapper.insert2(hcclmx);
        calcJsDocFur(hcclmx.getHcrwId());
        MongoLogger.info("task", "用户添加附加核查材料: " + hcclmx.getHcclId(), null, hcclmx.getHcrwId());
    }

    @Override
    public void updateHcclmx2(Hcclmx hcclmx) {
    	hcclmx.setUploadTime(new Date());
    	hcclmxMapper.updateByPrimaryKeySelective2(hcclmx);
    	calcDocFur(hcclmx.getHcrwId());
    }

    @Override
    public String getDxnMongoIdByHcrwId(String hcrwId, String dxnType) {
        return hcclmxMapper.getDxnMongoIdByHcrwlId(hcrwId,dxnType);
    }

    void calcDocFur(String hcrwId) {
    	hcrwMapper.updateHcclStatByPrimaryKey2(hcrwId);
    	Hcrw hcrw = hcrwMapper.selectByPrimaryKey(hcrwId);
    	int uploaded = hcrw.getUploadFilesFur();
    	int required = hcrw.getRequiredFilesFur();
    	int docReadyFlagFur = 0;
    	if(required > 0) {
    		if(uploaded == required) {
    			docReadyFlagFur = 2;
    		} else if(uploaded > 0) {
    			docReadyFlagFur = 1;
    		} else {
    			docReadyFlagFur = 0;
    		}
    	}
    	hcrwMapper.updateDocReadyFlag2(hcrwId, docReadyFlagFur);
    }

    void calcJsDocFur(String hcrwId) {
        jsHcrwMapper.updateHcclStatByPrimaryKey2(hcrwId);
        JsHcrw jsHcrw = jsHcrwMapper.selectByPrimaryKey(hcrwId);
        int uploaded = jsHcrw.getUploadFilesFur();
        int required = jsHcrw.getRequiredFilesFur();
        int docReadyFlagFur = 0;
        if(required > 0) {
            if(uploaded == required) {
                docReadyFlagFur = 2;
            } else if(uploaded > 0) {
                docReadyFlagFur = 1;
            } else {
                docReadyFlagFur = 0;
            }
        }
        hcrwMapper.updateDocReadyFlag2(hcrwId, docReadyFlagFur);
    }

}
