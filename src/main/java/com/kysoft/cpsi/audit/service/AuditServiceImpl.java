package com.kysoft.cpsi.audit.service;

import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.kysoft.cpsi.audit.entity.MailVerify;
import com.kysoft.cpsi.audit.mapper.MailVerifyMapper;

@Service("auditService")
public class AuditServiceImpl implements AuditService {

	@Resource
	MailVerifyMapper mailVerifyMapper;
	
	@Override
	public void sentVerifyMail(String hcrwId, String hcsxId, String mail) {
		// TODO Auto-generated method stub
		System.out.println(hcrwId);
		System.out.println(hcsxId);
		System.out.println(mail);
		
		MailVerify mv = new MailVerify();
		mv.setHcrwId(hcrwId);
		mv.setHcsxId(hcsxId);
		mv.setSentTime(new Date());
		mv.setMail(mail);
		mv.setId(UUID.randomUUID().toString().replace("-", ""));
		mailVerifyMapper.insert(mv);
		
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		// 设置参数
		mailSender.setHost("smtp.163.com");
		mailSender.setUsername("coralsea_li");
		mailSender.setPassword("LiHongTao#^())");
		
		SimpleMailMessage smm = new SimpleMailMessage();
	    // 设定邮件参数
	    smm.setFrom("CPSI");
	    smm.setTo(mail);
	    smm.setSubject("Hello world");
	    smm.setText("Hello world via spring mail sender");
	    // 发送邮件
	    mailSender.send(smm);
	    
	}
	
}
