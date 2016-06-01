package com.kysoft.cpsi.task.service;

import com.kysoft.cpsi.task.entity.Hcclmx;
import com.kysoft.cpsi.task.mapper.HcclmxMapper;
import net.sf.husky.attachment.utils.DownloadUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.UUID;

@Service("hcclmxService")
public class HcclmxServiceImpl implements HcclmxService {

    @Resource
    HcclmxMapper hcclmxMapper;

    @Override
    public void delete(String id) {
        Hcclmx hcclmx = hcclmxMapper.selectByPrimaryKey(id);
        hcclmxMapper.deleteByPrimaryKey(id);
        DownloadUtils.mongoDelete(hcclmx.getMongoId());
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

    }

}
