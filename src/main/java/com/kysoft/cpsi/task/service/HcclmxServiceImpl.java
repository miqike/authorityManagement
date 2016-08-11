package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.task.entity.Hcclmx;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.mapper.HcclmxMapper;
import com.kysoft.cpsi.task.mapper.HcrwMapper;

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

    @Override
    public void delete(String id) {
        Hcclmx hcclmx = hcclmxMapper.selectByPrimaryKey(id);
        hcclmxMapper.deleteByPrimaryKey(id);
        DownloadUtils.mongoDelete(hcclmx.getMongoId());
//        MongoLogger.info("task", "用户删除附加核查材料", null, id);
    }

    @Override
    public void addHcclmx(Hcclmx hcclmx) {
        Hcclmx oldHcclmx = hcclmxMapper.selectBy(hcclmx.getHcrwId(), hcclmx.getHcsxId(), hcclmx.getHcdwXydm(), hcclmx.getHcjhnd(), hcclmx.getHcclId());
        if (null != oldHcclmx) {
            hcclmxMapper.deleteByPrimaryKey(oldHcclmx.getId());
        }

        hcclmx.setId(UUID.randomUUID().toString().replace("-", ""));
        hcclmx.setUploadTime(new Date());
        hcclmxMapper.insert(hcclmx);
        MongoLogger.info("task", "附加核查材料添加成功");
        calcDoc(hcclmx.getHcrwId());
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
    
    @Override
    public void delete2(String id) {
    	Hcclmx hcclmx = hcclmxMapper.selectByPrimaryKey2(id);
    	hcclmxMapper.deleteByPrimaryKey2(id);
    	calcDocFur(hcclmx.getHcrwId());
    	if(null != hcclmx.getMongoId()) {
    		DownloadUtils.mongoDelete(hcclmx.getMongoId());
    	}
    	 MongoLogger.info("task", "删除附加核查材料", null, id);
    }
    
    @Override
    public void addHcclmx2(Hcclmx hcclmx) {
    	hcclmx.setId(UUID.randomUUID().toString().replace("-", ""));
    	hcclmxMapper.insert2(hcclmx);
    	calcDocFur(hcclmx.getHcrwId());
    	 MongoLogger.info("task", "添加附加核查材料");
    }
    
    @Override
    public void updateHcclmx2(Hcclmx hcclmx) {
    	hcclmx.setUploadTime(new Date());
    	hcclmxMapper.updateByPrimaryKeySelective2(hcclmx);
    	calcDocFur(hcclmx.getHcrwId());
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

}
