package com.kysoft.cpsi.repo.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.Zfry;
import com.kysoft.cpsi.repo.mapper.ZfryMapper;

import net.sf.husky.exception.BaseException;
import net.sf.husky.log.MongoLogger;
import net.sf.husky.security.entity.User;
import net.sf.husky.security.service.UserService;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("zfryService")
public class ZfryServiceImpl implements ZfryService {

    @Resource
    ZfryMapper zfryMapper;

    @Resource
    UserService userService;

    @Override
    public void insert(Zfry zfry) {
        zfryMapper.insert(zfry);
        MongoLogger.info("ccxxk", "增加执法人员");
    }

    @Override
    public void delete(String code) {
        zfryMapper.deleteByPrimaryKey(code);
    }

    @Override
    public void update(Zfry zfry) {
        zfryMapper.updateByPrimaryKey(zfry);
        MongoLogger.info("ccxxk", "修改执法人员");
    }

    @Override
    public List<Zfry> query(Map<String, Object> params) {
        return zfryMapper.query(params);
    }

	@Override
	public int lock(String code) {
		Zfry zfry = zfryMapper.selectByPrimaryKey(code);
        int targetStatus;
        if(zfry.getZt() == null || zfry.getZt() == 1) {
        	targetStatus = 2;
        	MongoLogger.info("ccxxk", "注销执法人员");
        } else {
        	targetStatus = 1;
        	MongoLogger.info("ccxxk", "取消注销执法人员");
        }
        zfryMapper.updateStatusByPrimaryKey(zfry.getCode(), targetStatus);
        return targetStatus;
	}

	@Override
	public void addSysUser(String code, String userId) {
		User user = userService.findByUserId(userId);
		if(null != user) {
			throw new BaseException("用户名已存在!");
		} else {
			Zfry zfry = zfryMapper.selectByPrimaryKey(code);
			user = new User();
			user.setUserId(userId);
			user.setName(zfry.getName());
			user.setEmail(zfry.getMail());
			user.setMobile(zfry.getMail());
			user.setCreateTime(new Date());
			user.setStatus(zfry.getZt());
			user.setOrgId(zfry.getGxdwId());
			user.setOrgName(zfry.getGxdwName());
			user.setZfry(code);
			userService.add(user);
			zfryMapper.updateUserIdByPrimaryKey(code, userId);
		}
	}
}
