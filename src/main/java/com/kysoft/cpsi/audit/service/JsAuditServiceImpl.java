package com.kysoft.cpsi.audit.service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.audit.mapper.*;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;

@Service("jsAuditService")
public class JsAuditServiceImpl implements JsAuditService {

	@Resource
	HcsxMapper hcsxMapper;

    @Resource
    JsLicenseMapper jsLicenseMapper;
    @Resource
    JsGqbgMapper jsGqbgMapper;
    @Resource
    JsZscqMapper jsZscqMapper;
    @Resource
    JsXzcfMapper jsXzcfMapper;
    @Resource
    JsStockholderContributionMapper jsStockholderContributionMapper;

    Integer JS_GS_INFO_FLAG=4;//公示信息标志
    Integer JS_GS_INFO_REAL=5;//实际信息标志
    @Override
    public Map<String, Object> getCompareInfo(String hcrwId, String hcsxId) {
        Map<String, Object> result = Maps.newHashMap();
        Hcsx hcsx = hcsxMapper.selectByPrimaryKey(hcsxId);
        String hcsxMc = hcsx.getName();
        Map<String,Object> param=new HashedMap();
        param.put("hcrwId",hcrwId);
        switch (hcsxMc) {
			case "有限公司股东股权转让等变更信息":
                result.put("a", jsGqbgMapper.query(param));//即时信息
                param.put("sjly",JS_GS_INFO_FLAG);
                result.put("b", jsGqbgMapper.queryBD(param));//公示信息
                param.put("sjly",JS_GS_INFO_REAL);
                result.put("c", jsGqbgMapper.queryBD(param));//实际信息
                break;
            case "行政许可取得、变更、延续信息":
                result.put("a", jsLicenseMapper.query(param));//即时信息
                param.put("sjly",JS_GS_INFO_FLAG);
                result.put("b", jsLicenseMapper.queryBD(param));//公示信息
                param.put("sjly",JS_GS_INFO_REAL);
                result.put("c", jsLicenseMapper.queryBD(param));//实际信息
                break;
            case "知识产权出质登记信息":
                result.put("a", jsZscqMapper.query(param));//即时信息
                param.put("sjly",JS_GS_INFO_FLAG);
                result.put("b", jsZscqMapper.queryBD(param));//公示信息
                param.put("sjly",JS_GS_INFO_REAL);
                result.put("c", jsZscqMapper.queryBD(param));//实际信息
                break;
            case "行政处罚信息":
                result.put("a", jsXzcfMapper.query(param));//即时信息
                param.put("sjly",JS_GS_INFO_FLAG);
                result.put("b", jsXzcfMapper.queryBD(param));//公示信息
                param.put("sjly",JS_GS_INFO_REAL);
                result.put("c", jsXzcfMapper.queryBD(param));//实际信息
                break;
            case "股东或发起人认缴和实缴信息":
                result.put("a", jsStockholderContributionMapper.query(param));//即时信息
                param.put("sjly",JS_GS_INFO_FLAG);
                result.put("b", jsStockholderContributionMapper.queryBD(param));//公示信息
                param.put("sjly",JS_GS_INFO_REAL);
                result.put("c", jsStockholderContributionMapper.queryBD(param));//实际信息
                break;
            default:

        }
        return result;
    }

}
