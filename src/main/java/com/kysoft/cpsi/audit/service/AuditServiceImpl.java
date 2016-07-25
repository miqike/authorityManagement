package com.kysoft.cpsi.audit.service;

import java.text.DecimalFormat;
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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.kysoft.cpsi.audit.entity.AnnualReport;
import com.kysoft.cpsi.audit.entity.Guarantee;
import com.kysoft.cpsi.audit.entity.Homepage;
import com.kysoft.cpsi.audit.entity.Investment;
import com.kysoft.cpsi.audit.entity.License;
import com.kysoft.cpsi.audit.entity.MailVerify;
import com.kysoft.cpsi.audit.entity.MailVerifyException;
import com.kysoft.cpsi.audit.entity.StockRightChange;
import com.kysoft.cpsi.audit.entity.StockholderContribution;
import com.kysoft.cpsi.audit.mapper.AnnualReportMapper;
import com.kysoft.cpsi.audit.mapper.GuaranteeMapper;
import com.kysoft.cpsi.audit.mapper.HomepageMapper;
import com.kysoft.cpsi.audit.mapper.InvestmentMapper;
import com.kysoft.cpsi.audit.mapper.LicenseMapper;
import com.kysoft.cpsi.audit.mapper.MailVerifyMapper;
import com.kysoft.cpsi.audit.mapper.StockRightChangeMapper;
import com.kysoft.cpsi.audit.mapper.StockholderContributionMapper;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.service.HcsxjgService;

import net.sf.husky.exception.BaseException;
import net.sf.husky.log.service.LogService;

@Service("auditService")
public class AuditServiceImpl implements AuditService {

    @Resource
    MailVerifyMapper mailVerifyMapper;

    @Resource
    HcsxMapper hcsxMapper;
    
    @Resource
    HcrwMapper hcrwMapper;

    @Resource
    AnnualReportMapper annualReportMapper;

    @Resource
    GuaranteeMapper guaranteeMapper;

    @Resource
    LicenseMapper licenseMapper;

    @Resource
    HomepageMapper homepageMapper;

    @Resource
    InvestmentMapper investmentMapper;

    @Resource
    StockholderContributionMapper stockholderContributionMapper;
    
    @Resource
    StockRightChangeMapper stockRightChangeMapper;

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
            ((JavaMailSenderImpl) mailSender).setHost("smtp.163.com");
            ((JavaMailSenderImpl) mailSender).setUsername("coralsea_li");
            ((JavaMailSenderImpl) mailSender).setPassword("LiHongTao#^())");

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
            logService.info("audit", "向被检查单位发送验证邮件", "向被检查单位发送验证邮件", hcrwId + "-" + hcsxId);

        }
    }

    @Override
    public void verifyMail(String id) {
        mailVerifyMapper.updateVerifiedByPrimaryKey(id);
        MailVerify mv = mailVerifyMapper.selectByPrimaryKey(id);
        hcsxjgService.complete(mv.getHcrwId(), mv.getHcsxId(), 1, "正常");
        logService.info("audit", "被检查单位收到验证邮件,本检查项完成", "被检查单位收到验证邮件", mv.getHcrwId() + "-" + mv.getHcsxId());
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
                result.put("c", annualReportMapper.selectByPrimaryKey3(hcrwId));
                break;
            case "从业人员信息":
                result.put("a", annualReportMapper.selectByPrimaryKey(hcrwId));
                result.put("b", annualReportMapper.selectByPrimaryKey2(hcrwId));
                result.put("c", annualReportMapper.selectByPrimaryKey3(hcrwId));
                break;
            case "企业网站及从事经营的网店的名称和网址":
                result.put("a", homepageMapper.selectByTaskId(hcrwId));
                result.put("b", homepageMapper.selectByTaskId2(hcrwId));
                result.put("c", homepageMapper.selectByTaskId3(hcrwId));
                break;
            case "股东或发起人认缴和实缴信息":
                result.put("a", stockholderContributionMapper.selectByTaskId(hcrwId));
                result.put("b", stockholderContributionMapper.selectByTaskId2(hcrwId));
                result.put("c", stockholderContributionMapper.selectByTaskId3(hcrwId));
                break;
            case "股东或发起人认缴和实缴的出资额等信息":

                break;
            case "企业投资设立企业、购买股权信息":
                result.put("a", investmentMapper.selectByTaskId(hcrwId));
                result.put("b", investmentMapper.selectByTaskId2(hcrwId));
                result.put("c", investmentMapper.selectByTaskId3(hcrwId));
                break;
            case "有限公司股东股权转让等股权变更信息":

                break;
            case "资产总额、负债总额等资产财务数据":
                result.put("a", annualReportMapper.selectByPrimaryKey(hcrwId));
                result.put("b", annualReportMapper.selectByPrimaryKey2(hcrwId));
                result.put("c", annualReportMapper.selectByPrimaryKey3(hcrwId));
                break;
            case "有限公司股东股权转让等变更信息":
                result.put("a", stockRightChangeMapper.selectByTaskId(hcrwId));
                result.put("b", stockRightChangeMapper.selectByTaskId2(hcrwId));
                result.put("c", stockRightChangeMapper.selectByTaskId3(hcrwId));
                break;
            case "对外提供保证担保信息":
                result.put("a", guaranteeMapper.selectByTaskId(hcrwId));
                result.put("b", guaranteeMapper.selectByTaskId2(hcrwId));
                result.put("c", guaranteeMapper.selectByTaskId3(hcrwId));
                break;
            case "行政许可取得、变更、延续信息":
                result.put("a", licenseMapper.selectByTaskId(hcrwId));
                result.put("b", licenseMapper.selectByTaskId2(hcrwId));
                result.put("c", licenseMapper.selectByTaskId3(hcrwId));
                break;
            case "知识产权出质登记信息":

                break;
            case "行政处罚信息":

                break;
            default:

        }
        return result;
    }

	@Override
	public void importData(JSONObject jsonData) {
		AnnualReport ar = getAnnualReport(jsonData);
		Integer nd = ar.getNd();
		String xydm = ar.getXydm();
		System.out.println("---------nd-------------" + nd);
		System.out.println("---------xydm-------------" + xydm);
		String hcrwId = hcrwMapper.selectTaskIdByNdAndXydm(nd, xydm);
		System.out.println("================\t" + hcrwId);
		if(hcrwId == null) {
			throw new BaseException("核查任务不存在,请检查年度和企业统一社会信用代码是否正确录入");
		} else {
			ar.setHcrwId(hcrwId);
			annualReportMapper.deleteByTaskId2(hcrwId);
			annualReportMapper.insert2(ar);
			//股东出资
			reportStockholderContribution(hcrwId, jsonData);
			//对外投资
			reportInvestment(hcrwId, jsonData);
			//对外担保
			reportGuarantee(hcrwId, jsonData);
			//股权变更
			reportStockRightChange(hcrwId, jsonData);
			//网店
			reportHomepage(hcrwId, jsonData);
			//行政许可
			reportLicense(hcrwId, jsonData);
			
			//TODO call compare procedure
			Map<String, Object> param = Maps.newHashMap();
	        param.put("hcrwId", hcrwId);
			hcrwMapper.compareData(param);
		}
	}

	private AnnualReport getAnnualReport(JSONObject jsonData) {
		DecimalFormat df = new DecimalFormat("#.00");
		AnnualReport ar = new AnnualReport();
		ar.setNd(jsonData.getInteger("nd")); //126289223.960000,
		ar.setXydm(jsonData.getString("xydm")); //'0',
		ar.setSyzqyhj(Float.valueOf(df.format(jsonData.getFloat("syzqyhj")/1000))); //126289223.960000,
		ar.setLrze(Float.valueOf(df.format(jsonData.getFloat("lrze")/10000))); //-1645108.430000,
		ar.setYyzsr(Float.valueOf(df.format(jsonData.getFloat("yyzsr")/10000))); //113022006.660000,
		ar.setZyywsr(Float.valueOf(df.format(jsonData.getFloat("zyywsr")/10000))); //107588461.960000,
		ar.setJlr(Float.valueOf(df.format(jsonData.getFloat("jlr")/10000))); //-1645108.430000,
		ar.setNsze(Float.valueOf(df.format(jsonData.getFloat("nsze")/10000))); //0,
		ar.setFzze(Float.valueOf(df.format(jsonData.getFloat("fzze")/10000))); //19561910.140000,
		ar.setZcze(Float.valueOf(df.format(jsonData.getFloat("zcze")/10000))); //145851134.100000,
		ar.setTxdz(jsonData.getString("txdz")); //'中关村',
		ar.setYzbm(jsonData.getString("yzbm")); //'0',
		ar.setLxdh(jsonData.getString("lxdh")); //'132233221145',
		ar.setMail(jsonData.getString("dzyx")); //'7700266@qq.com',
		ar.setCyrs(jsonData.getInteger("crys")); //'10000',
		ar.setJyzt(jsonData.getString("jyzt")); //'0',
		//ar.setFzr(jsonData.getString("fzr")); //'大海',
		return ar;
	}
	
	
	//============================================================================
	//股东出资
	private void reportStockholderContribution(String hcrwId, JSONObject jsonData) {
		stockholderContributionMapper.deleteByTaskId(hcrwId);
		JSONArray shcArray = jsonData.getJSONArray("gdcz");
		
		Integer nd = jsonData.getInteger("nd"); 
		String xydm = jsonData.getString("xydm");
		
		if(null != shcArray && shcArray.size() > 0) {
			List<StockholderContribution> shcList = Lists.newArrayList();
			for(int i=0; i<shcArray.size(); i++) {
				JSONObject shc = shcArray.getJSONObject(i);
				shcList.add(parseStockHolderContribution(shc, nd, xydm, hcrwId));
			}
			
			for(int i=0;i<shcList.size(); i++) {
				stockholderContributionMapper.insert2(shcList.get(i));
			}
		}
	}

	private StockholderContribution parseStockHolderContribution(JSONObject shcObj, Integer nd, String xydm, String hcrwId) {
		StockholderContribution shc = new StockholderContribution();
		shc.setId(UUID.randomUUID().toString().replace("-", ""));
		shc.setNd(nd);
		shc.setXydm(xydm);
		shc.setGd(shcObj.getString("gd"));	//股东
		shc.setRjcze(shcObj.getFloat("rjcze")); //认缴出资额
		shc.setRjczdqsj(shcObj.getString("rjczsqsj")); //认缴出资到期时间
		shc.setRjczfs(shcObj.getString("rjczfs"));	//认缴出资方式
		shc.setSjcze(shcObj.getFloat("sjcze"));		//实缴出资额
		shc.setSjczsj(shcObj.getString("sjczsj"));	//出资时间
		shc.setSjczfs(shcObj.getString("sjczfs"));	//出资方式
		shc.setHcrwId(hcrwId);	//核查任务代码
		return shc;
	}
	
	//对外投资
	private void reportInvestment(String hcrwId, JSONObject jsonData) {
		investmentMapper.deleteByTaskId(hcrwId);
		JSONArray shcArray = jsonData.getJSONArray("qygmgq");
		
		Integer nd = jsonData.getInteger("nd"); 
		String xydm = jsonData.getString("xydm");
		
		if(null != shcArray && shcArray.size() > 0) {
			List<Investment> investmentList = Lists.newArrayList();
			for(int i=0; i<shcArray.size(); i++) {
				JSONObject investment = shcArray.getJSONObject(i);
				investmentList.add(parseInvestment(investment, nd, xydm, hcrwId));
			}
			for(int i=0;i<investmentList.size(); i++) {
				investmentMapper.insert2(investmentList.get(i));
			}
		}
	}
	
	private Investment parseInvestment(JSONObject investmentObj, Integer nd, String xydm, String hcrwId) {
		Investment investment = new Investment();
		investment.setId(UUID.randomUUID().toString().replace("-", ""));
		investment.setNd(nd);
		investment.setXydm(xydm);
		investment.setHcrwId(hcrwId); 	//核查任务代码
		investment.setTzqymc(investmentObj.getString("slqymc"));	//投资设立企业或者购买股权企业名称
		investment.setTzqyZch(investmentObj.getString("zch"));		//被投资企业注册号
		return investment;
	}
	
	//对外担保
	private void reportGuarantee(String hcrwId, JSONObject jsonData) {
		guaranteeMapper.deleteByTaskId(hcrwId);
		JSONArray shcArray = jsonData.getJSONArray("dwdb");
		Integer nd = jsonData.getInteger("nd"); 
		String xydm = jsonData.getString("xydm");
		
		if(null != shcArray && shcArray.size() > 0) {
			List<Guarantee> guaranteeList = Lists.newArrayList();
			for(int i=0; i<shcArray.size(); i++) {
				JSONObject guarantee = shcArray.getJSONObject(i);
				guaranteeList.add(parseGuarantee(guarantee, nd, xydm, hcrwId));
			}
			for(int i=0;i<guaranteeList.size(); i++) {
				guaranteeMapper.insert2(guaranteeList.get(i));
			}
		}
		
	}

	private Guarantee parseGuarantee(JSONObject guaranteeObj, Integer nd, String xydm, String hcrwId) {
		Guarantee guarantee = new Guarantee();
		guarantee.setId(UUID.randomUUID().toString().replace("-", ""));
		guarantee.setNd(nd);
		guarantee.setXydm(xydm);
		guarantee.setHcrwId(hcrwId); 	//核查任务代码
		
		guarantee.setZqr(guaranteeObj.getString("zqr")); 	//债权人
		guarantee.setZwr(guaranteeObj.getString("zwr")); 	//债务人
		guarantee.setZzqzl(guaranteeObj.getString("zzqzl")); 	//主债权种类
		guarantee.setZzqse(guaranteeObj.getFloat("zzqje")); 	//主债权数额
		guarantee.setLxzwqx(guaranteeObj.getString("lxzwqx")); 	//履行债务的期限
		guarantee.setBzqj(guaranteeObj.getString("bzqj")); 	//保证的期间
		guarantee.setBzfs(guaranteeObj.getString("bzfs")); 	//保证的方式
		guarantee.setBzdbfw(guaranteeObj.getString("dbfw")); 	//保证担保的范围

		return guarantee;
	}
	
	//股权变更
	private void reportStockRightChange(String hcrwId, JSONObject jsonData) {
		stockRightChangeMapper.deleteByTaskId(hcrwId);
		
		JSONArray shcArray = jsonData.getJSONArray("gqbg");
		Integer nd = jsonData.getInteger("nd"); 
		String xydm = jsonData.getString("xydm");
		
		if(null != shcArray && shcArray.size() > 0) {
			List<StockRightChange> stockRightChangeList = Lists.newArrayList();
			for(int i=0; i<shcArray.size(); i++) {
				JSONObject stockRightChange = shcArray.getJSONObject(i);
				stockRightChangeList.add(parseStockRightChange(stockRightChange, nd, xydm, hcrwId));
			}
			for(int i=0;i<stockRightChangeList.size(); i++) {
				stockRightChangeMapper.insert2(stockRightChangeList.get(i));
			}
		}
	}
	
	private StockRightChange parseStockRightChange(JSONObject stockRightChangeObj, Integer nd, String xydm, String hcrwId) {
		StockRightChange stockRightChange = new StockRightChange();
		stockRightChange.setId(UUID.randomUUID().toString().replace("-", ""));
		stockRightChange.setNd(nd);
		stockRightChange.setXydm(xydm);
		stockRightChange.setHcrwId(hcrwId); 	//核查任务代码
		stockRightChange.setGd(stockRightChangeObj.getString("gd"));	//股东
		stockRightChange.setBgqGqbl(stockRightChangeObj.getFloat("bgqbl"));	//变更前股权比例
		stockRightChange.setBghGqbl(stockRightChangeObj.getFloat("bghbl"));	//变更后股权比例
		stockRightChange.setBgrq(stockRightChangeObj.getString("stockRightChangeObj"));	//股权变更日期
		return stockRightChange;
	}
	
	//网店
	private void reportHomepage(String hcrwId, JSONObject jsonData) {
		homepageMapper.deleteByTaskId(hcrwId);
		
		JSONArray shcArray = jsonData.getJSONArray("wd");
		
		Integer nd = jsonData.getInteger("nd"); 
		String xydm = jsonData.getString("xydm");
		
		if(null != shcArray && shcArray.size() > 0) {
			List<Homepage> homepageList = Lists.newArrayList();
			for(int i=0; i<shcArray.size(); i++) {
				JSONObject homepage = shcArray.getJSONObject(i);
				homepageList.add(parseHomepage(homepage, nd, xydm, hcrwId));
			}
			for(int i=0;i<homepageList.size(); i++) {
				homepageMapper.insert2(homepageList.get(i));
			}
		}
		
	}
	
	private Homepage parseHomepage(JSONObject investmentObj, Integer nd, String xydm, String hcrwId) {
		Homepage homepage = new Homepage();
		homepage.setId(UUID.randomUUID().toString().replace("-", ""));
		homepage.setNd(nd);
		homepage.setXydm(xydm);
		homepage.setHcrwId(hcrwId); 	//核查任务代码
		
		homepage.setType(investmentObj.getString("type"));	//类型
		homepage.setName(investmentObj.getString("name"));	//名称
		homepage.setWz(investmentObj.getString("wz"));		//网址
		return homepage;
	}
	//行政许可
	private void reportLicense(String hcrwId, JSONObject jsonData) {
		licenseMapper.deleteByTaskId(hcrwId);
		JSONArray shcArray = jsonData.getJSONArray("xzxk");
		Integer nd = jsonData.getInteger("nd"); 
		String xydm = jsonData.getString("xydm");
		
		if(null != shcArray && shcArray.size() > 0) {
			List<License> licenseList = Lists.newArrayList();
			for(int i=0; i<shcArray.size(); i++) {
				JSONObject license = shcArray.getJSONObject(i);
				licenseList.add(parseLicense(license, nd, xydm, hcrwId));
			}
			for(int i=0;i<licenseList.size(); i++) {
				licenseMapper.insert2(licenseList.get(i));
			}
		}
	}
	
	private License parseLicense(JSONObject licenseObj, Integer nd, String xydm, String hcrwId) {
		License license = new License();
		license.setId(UUID.randomUUID().toString().replace("-", ""));
		license.setNd(nd);
		license.setXydm(xydm);
		license.setHcrwId(hcrwId); 	//核查任务代码
		license.setXkwjmc(licenseObj.getString("xkwjmc"));	//许可文件名称
		license.setYxq(licenseObj.getString("yxq_ks") + " 至 " + licenseObj.getString("yxq_zz") );		//有效期至
		//license.setDjzt(licenseObj.getString("yxq"));		//有效期至
		return license;
	}

}
