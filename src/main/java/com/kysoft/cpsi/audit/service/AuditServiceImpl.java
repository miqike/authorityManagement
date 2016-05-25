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

@Service("auditService")
public class AuditServiceImpl implements AuditService {

	@Resource
	MailVerifyMapper mailVerifyMapper;
	
	@Resource
	HcsxjgService hcsxjgService;
	

	@Override
	public void sentVerifyMail(String hcrwId, String hcsxId, String mail) throws MailVerifyException {
		// TODO Auto-generated method stub
		System.out.println(hcrwId);
		System.out.println(hcsxId);
		System.out.println(mail);
		List<MailVerify> mvList = mailVerifyMapper.selectByTask(hcrwId, hcsxId);

		if (mvList.size() > 0) {
			// if() {
			throw new MailVerifyException("5分钟内不能重复发送验证邮件");

			// } else {
			// throw new Exception("不能重复发送");
			// }
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
		}
	}

	@Override
	public void verifyMail(String id) {
		mailVerifyMapper.updateVerifiedByPrimaryKey(id);
		MailVerify mv = mailVerifyMapper.selectByPrimaryKey(id);
		hcsxjgService.complete(mv.getHcrwId(), mv.getHcsxId(), 1);
	}

}
