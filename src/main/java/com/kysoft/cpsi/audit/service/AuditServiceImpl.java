package com.kysoft.cpsi.audit.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.audit.entity.MailVerify;
import com.kysoft.cpsi.audit.entity.MailVerifyException;
import com.kysoft.cpsi.audit.mapper.AnnualReportMapper;
import com.kysoft.cpsi.audit.mapper.GqbgMapper;
import com.kysoft.cpsi.audit.mapper.GuaranteeMapper;
import com.kysoft.cpsi.audit.mapper.MailVerifyMapper;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.service.HcsxjgService;

import net.sf.husky.log.service.LogService;

@Service("auditService")
public class AuditServiceImpl implements AuditService {

	@Resource
	MailVerifyMapper mailVerifyMapper;
	
	@Resource
	HcsxMapper hcsxMapper;
	
	@Resource
	AnnualReportMapper annualReportMapper;
	
	@Resource
	GqbgMapper gqbgMapper;
	
	@Resource
	GuaranteeMapper guaranteeMapper;
	
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

	@Override
	public Map<String, Object> getCompareInfo(String hcrwId, String hcsxId) {
		Map<String, Object> result = Maps.newHashMap();
		Hcsx hcsx = hcsxMapper.selectByPrimaryKey(hcsxId);
		String hcsxMc = hcsx.getName();
		switch (hcsxMc) {
			case "党建信息":
				result.put("a", annualReportMapper.selectByPrimaryKey(hcrwId));
				result.put("b", annualReportMapper.selectByPrimaryKey2(hcrwId));
				break;
			case "人员信息":
				result.put("a", annualReportMapper.selectByPrimaryKey(hcrwId));
				result.put("b", annualReportMapper.selectByPrimaryKey2(hcrwId));
				break;
			case "企业网站网店的名称和网址":
				
				break;
			case "实缴出资":
				
				break;
			case "投资设立企业":
				
				break;
			case "购买股权":
				
				break;
			case "资产财务":
				result.put("a", annualReportMapper.selectByPrimaryKey(hcrwId));
				result.put("b", annualReportMapper.selectByPrimaryKey2(hcrwId));
				break;
			case "股权变更信息":
				result.put("a", gqbgMapper.selectByTaskId(hcrwId));
				result.put("b", gqbgMapper.selectByTaskId2(hcrwId));
				break;
			case "对外提供保证担保信息":
				
				/*result.put("a", guaranteeMapper.selectByTaskId(hcrwId));
				result.put("b", guaranteeMapper.selectByTaskId2(hcrwId));*/
				break;
			case "行政许可取得、变更、延续信息":
				
				break;
			case "知识产权出质登记信息":
				
				break;
			case "行政处罚信息":
				
				break;
			default:
					
		}
		
		// TODO Auto-generated method stub
		
		return result;
	}
	

}
