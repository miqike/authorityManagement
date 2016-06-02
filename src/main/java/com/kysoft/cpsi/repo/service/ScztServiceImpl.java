package com.kysoft.cpsi.repo.service;

import com.kysoft.cpsi.audit.entity.LoginToken;
import com.kysoft.cpsi.audit.entity.LoginTokenException;
import com.kysoft.cpsi.audit.mapper.LoginTokenMapper;
import com.kysoft.cpsi.repo.entity.Sczt;
import com.kysoft.cpsi.repo.mapper.ScztMapper;

import net.sf.husky.sms.SMSService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


/**
 * Created by Tommy on 7/20/2015.
 */
@Service("scztService")
public class ScztServiceImpl implements ScztService {

    @Resource
    ScztMapper scztMapper;
    
    @Resource
    SMSService smsService;
    
    @Resource
    LoginTokenMapper loginTokenMapper;
    
    @Override
    public void insert(Sczt sczt) {
        if (sczt.getXydm() == null || sczt.getXydm().equals("")) {
            //sczt.setXydm(UUID.randomUUID().toString().replace("-", ""));
        }
        scztMapper.insert(sczt);
    }

    @Override
    public void delete(String xydm) {
        scztMapper.deleteByPrimaryKey(xydm);
    }

    @Override
    public void update(Sczt sczt) {
        scztMapper.updateByPrimaryKey(sczt);
    }

    @Override
    public List<Sczt> query(Map<String, Object> params) {
        return scztMapper.query(params);
    }

    @Override
    public List<Map<String, Object>> queryHccl(String xydm) {
        Map<String, Object> params = new HashMap<>();
        params.put("xydm", xydm);
        return scztMapper.queryHccl(params);
    }

	@Override
	public Sczt loadByXydm(String xydm) {
		return scztMapper.selectByPrimaryKey(xydm);
	}

	@Override
	public String sendToken(String xydm, String mobile) {
		Sczt sczt = loadByXydm(xydm);
		if(mobile == null) {
			mobile = sczt.getLxdh();
		}
		LoginToken loginToken = new LoginToken();
		loginToken.setId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
		loginToken.setXydm(xydm);
		loginToken.setName(sczt.getName());
		loginToken.setValidateFlag(1);
		loginToken.setSentTime(new Date());
		loginToken.setMobile(mobile);
		loginToken.setToken(getToken(sczt));
		loginTokenMapper.insert(loginToken);
		smsService.sendSMS(mobile, "公示核查系统临时验证码: " + loginToken.getToken());
		return loginToken.getId();
	}

	private String getToken(Sczt sczt) {
		int _token = (int)((Math.random()*9+1)*100000);
		String token = String.valueOf(_token);
		System.out.println(token);
		return token;
	}

	@Override
	public void login(String xydm, String tokenId, String token) throws LoginTokenException {
		LoginToken loginToken = loginTokenMapper.selectByPrimaryKey(tokenId);
		long now = System.currentTimeMillis();
		long sentTime = loginToken.getSentTime().getTime();
		if(now - sentTime > 3600000) {
			throw new LoginTokenException("口令过期");
		} else if(!loginToken.getToken().equals(token) ) {
			throw new LoginTokenException("口令错误");
		} else {
			loginToken.setValidateFlag(0);
			loginTokenMapper.updateByPrimaryKeySelective(loginToken);
		}
	}
}
