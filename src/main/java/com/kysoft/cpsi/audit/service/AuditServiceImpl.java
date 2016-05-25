package com.kysoft.cpsi.audit.service;

import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kysoft.cpsi.audit.entity.MailVerify;
import com.kysoft.cpsi.audit.entity.MailVerifyException;
import com.kysoft.cpsi.audit.mapper.MailVerifyMapper;
import com.kysoft.cpsi.task.service.HcsxjgService;

import net.sf.husky.log.service.LogService;

@Service("auditService")
public class AuditServiceImpl implements AuditService {

	@Resource
	MailVerifyMapper mailVerifyMapper;
	
	@Resource
	HcsxjgService hcsxjgService;
	
	@Resource
	LogService logService;
	

	@Override
	public void sentVerifyMail(String hcrwId, String hcsxId, String mail) throws MailVerifyException {
		List<MailVerify> mvList = mailVerifyMapper.selectByTask(hcrwId, hcsxId);

		if (mvList.size() > 0) {
			throw new MailVerifyException("5分钟内不能重复发送验证邮件");
		} else {
			MailVerify mv = new MailVerify();
			mv.setHcrwId(hcrwId);
			mv.setHcsxId(hcsxId);
			mv.setMail(mail);
			mv.setId(UUID.randomUUID().toString().replace("-", ""));
			mailVerifyMapper.insertSelective(mv);

			JavaMailSender mailSender = new JavaMailSenderImpl();
			// 设置参数
			((JavaMailSenderImpl)mailSender).setHost("smtp.163.com");
			((JavaMailSenderImpl)mailSender).setUsername("coralsea_li");
			((JavaMailSenderImpl)mailSender).setPassword("LiHongTao#^())");

			MimeMessage mimeMessage;
			MimeMessageHelper mimeMessageHelper;
//			SimpleMailMessage simpleMailMessage;

			try {

				mimeMessage = mailSender.createMimeMessage();
				mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				mimeMessageHelper.setFrom("coralsea_li@163.com");
				mimeMessageHelper.setTo(mail);
				mimeMessageHelper.setSubject("工商公示系统邮箱验证");
				mimeMessageHelper.setText("您好, 请点击下面的链接验证邮箱: <a href='http://192.168.5.100:9080/cpsi/audit/mail/" + mv.getId()
				+ "' >验证链接</a>", true);
				mailSender.send(mimeMessage);
			} catch (MessagingException e) {
				e.printStackTrace();
			}

			hcsxjgService.start(hcrwId, hcsxId);
			logService.info("audit", "向被核查单位发送验证邮件", "向被核查单位发送验证邮件", hcrwId + "-" + hcsxId);
			
		}
	}

	@Override
	public void verifyMail(String id) {
		mailVerifyMapper.updateVerifiedByPrimaryKey(id);
		MailVerify mv = mailVerifyMapper.selectByPrimaryKey(id);
		hcsxjgService.complete(mv.getHcrwId(), mv.getHcsxId(), 1);
		logService.info("audit", "被核查单位收到验证邮件,本核查项完成", "被核查单位收到验证邮件", mv.getHcrwId() + "-" + mv.getHcsxId());
	}

}
