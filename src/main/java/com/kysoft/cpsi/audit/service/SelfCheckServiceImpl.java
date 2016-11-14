package com.kysoft.cpsi.audit.service;

import com.kysoft.cpsi.audit.entity.*;
import com.kysoft.cpsi.audit.mapper.*;
import com.kysoft.cpsi.repo.mapper.HcclMapper;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import net.sf.husky.exception.ExceptionUtils;
import net.sf.husky.log.MongoLogger;
import net.sf.husky.log.service.LogService;
import net.sf.husky.utils.POIUtils;
import org.apache.commons.collections.map.HashedMap;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Service("selfCheckService")
public class SelfCheckServiceImpl implements SelfCheckService {

    @Resource
    AnnualReportMapper annualReportMapper;//年报

    @Resource
    GuaranteeMapper guaranteeMapper;//对外担保

    @Resource
    LicenseMapper licenseMapper;//行政许可

    @Resource
    HomepageMapper homepageMapper;//网址网店

    @Resource
    InvestmentMapper investmentMapper;//对外投资

    @Resource
    StockholderContributionMapper stockholderContributionMapper;//股东出资
    
    @Resource
    StockRightChangeMapper stockRightChangeMapper;//股权变更

    @Resource
    LogService logService;

    @Resource
    JsStockholderContributionMapper jsStockholderContributionMapper;

    @Resource
    JsGqbgMapper jsGqbgMapper;

    @Resource
    JsXzcfMapper jsXzcfMapper;

    @Resource
    JsLicenseMapper jsLicenseMapper;

    @Resource
    JsZscqMapper jsZscqMapper;

    @Resource
    HcrwMapper hcrwMapper;

    @Resource
    HcclMapper hcclMapper;

    @Value(value = "${import.selfdata.flag}")
    private String importFlag;

    /**
     * 可能的数据错误
     * 从业人数：只能是数值
     * 日期格式 yyyy-MM-dd
     * */
    private Date getDateValue(String dateStr) throws Exception{
        if(null !=dateStr && !dateStr.equals("")){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.parse(dateStr);
        }else{
            return null;
        }
    }
    private Float parseFloat(String floatStr){
        if(null !=floatStr && !floatStr.trim().equals("")){
            return Float.parseFloat(floatStr);
        }else{
            return Float.parseFloat("0.00");
        }
    }
    private Integer parseInt(String floatStr){
        if(null !=floatStr && !floatStr.trim().equals("")){
            return Integer.parseInt(floatStr);
        }else{
            return 0;
        }
    }
    private BigDecimal parseBigDecimal(String bigDecimalStr){
        DecimalFormat   df   =new   java.text.DecimalFormat("#.00");
        if(null !=bigDecimalStr && !bigDecimalStr.trim().equals("")){
            return new BigDecimal(df.format(new BigDecimal(bigDecimalStr)));
        }else{
            return new BigDecimal("0.00");
        }
    }
    //年报网址网店
    private void nianbaoWangzhiwangdian(Hcrw hcrw, Sheet sheetZCB){

        try {
            //年报数据
            if(null!=POIUtils.getCellFormatValue(sheetZCB.getRow(7).getCell(3)).trim() && !POIUtils.getCellFormatValue(sheetZCB.getRow(7).getCell(3)).trim().equals("")){
                Homepage homepage = new Homepage();
                homepage.setNd(hcrw.getNd());
                homepage.setXydm(hcrw.getHcdwXydm());
                homepage.setHcrwId(hcrw.getId());
                homepage.setId(UUID.randomUUID().toString().replace("-", ""));

                homepage.setName("非网络交易平台网站");
                homepage.setType("非网络交易平台网站");
                homepage.setWz(POIUtils.getCellFormatValue(sheetZCB.getRow(7).getCell(3)));
                //删除老数据
                homepageMapper.deleteByTaskId(hcrw.getId());
                //插入新数据
                homepageMapper.insert2(homepage);
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 网址 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[企业公示信息自查表][网址信息部分]数据导入处理出错;");
        }
    }
    //年报基本信息
    private void nianbao(Hcrw hcrw, Sheet sheetZCFZB, Sheet sheetZCB, Sheet sheetLRB){

        try {
            DecimalFormat decimalFormat = new DecimalFormat(".00");
            //年报数据
            AnnualReport annualReport = new AnnualReport();
            annualReport.setNd(hcrw.getNd());
            annualReport.setXydm(hcrw.getHcdwXydm());
            annualReport.setQymc(hcrw.getHcdwName());
            annualReport.setHcrwId(hcrw.getId());

            annualReport.setSyzqyhj(parseFloat(decimalFormat.format(parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(47).getCell(10))) / 10000)));

            //计算利润总额
            Float lrze=parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(6).getCell(3)))
                    -parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(9).getCell(3)))
                    -parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(12).getCell(3)))
                    -parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(13).getCell(3)))
                    -parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(14).getCell(3)))
                    -parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(15).getCell(3)))
                    -parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(16).getCell(3)))
                    +parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(18).getCell(3)))
                    +parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(19).getCell(3)))
                    +parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(21).getCell(3)))
                    -parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(23).getCell(3)))
                    ;
            annualReport.setLrze(parseFloat(decimalFormat.format(lrze / 10000)));
            //计算净利润
            Float jlr=lrze-parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(26).getCell(3)));
            annualReport.setJlr(parseFloat(decimalFormat.format(jlr / 10000)));

            annualReport.setYyzsr(parseFloat(decimalFormat.format(parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(6).getCell(3))) / 10000)));
            annualReport.setZyywsr(parseFloat(decimalFormat.format(parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(7).getCell(3))) / 10000)));
            annualReport.setNsze(parseFloat(decimalFormat.format(parseFloat(POIUtils.getStringCellValue(sheetZCB.getRow(9).getCell(5))) )));
            annualReport.setFzze(parseFloat(decimalFormat.format(parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(35).getCell(10))) / 10000)));
            annualReport.setZcze(parseFloat(decimalFormat.format(parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(5))) / 10000)));

            annualReport.setTxdz(POIUtils.getStringCellValue(sheetZCB.getRow(6).getCell(3)));
            annualReport.setYzbm(POIUtils.getStringCellValue(sheetZCB.getRow(8).getCell(5)));
            annualReport.setLxdh(POIUtils.getStringCellValue(sheetZCB.getRow(5).getCell(5)));
            annualReport.setMail(POIUtils.getStringCellValue(sheetZCB.getRow(6).getCell(5)));

            annualReport.setCyrs(parseInt(POIUtils.getStringCellValue(sheetZCB.getRow(7).getCell(5))));
            annualReport.setGxbysGg(0);
            annualReport.setGxbysJy(0);
            annualReport.setTysbsGg(0);
            annualReport.setTysbsJy(0);
            annualReport.setCjrsGg(0);
            annualReport.setCjrsJy(0);
            annualReport.setZjysGg(0);
            annualReport.setZjysJy(0);

            annualReport.setJyzt(POIUtils.getStringCellValue(sheetZCB.getRow(8).getCell(3)));
            annualReport.setSftzgmgq(POIUtils.getStringCellValue(sheetZCB.getRow(13).getCell(4)));
            annualReport.setSfydwdbxx(POIUtils.getStringCellValue(sheetZCB.getRow(14).getCell(4)));
            //删除老数据
            annualReportMapper.deleteByTaskId2(hcrw.getId());
            //插入新数据
            annualReportMapper.insert2(annualReport);
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 年报基本信息 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[企业公示信息年报基本信息]数据导入处理出错;");
        }
    }
    //年报-股东出资
    private void gudongchuzi(Hcrw hcrw,Sheet sheetGDCZ){
        try{
            stockholderContributionMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheetGDCZ.getLastRowNum();
            for(int i=6;i<rowNum;i++){
                if(null != POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(2)).trim().equals("")) {
                    StockholderContribution stockholderContribution = new StockholderContribution();
                    stockholderContribution.setId(UUID.randomUUID().toString().replace("-", ""));
                    stockholderContribution.setNd(hcrw.getNd());
                    stockholderContribution.setHcrwId(hcrw.getId());
                    stockholderContribution.setXydm(hcrw.getHcdwXydm());
                    stockholderContribution.setGd(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(2)));
                    stockholderContribution.setRjcze(null);
                    stockholderContribution.setRjczdqsj(null);
                    stockholderContribution.setRjczfs(null);
                    stockholderContribution.setSjcze(parseFloat(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(3))));
                    stockholderContribution.setSjczsj(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(4)));
                    stockholderContribution.setSjczfs(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(5)));
                    stockholderContributionMapper.insert2(stockholderContribution);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 股东及出资信息 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[股东及出资信息]数据导入处理出错;");
        }
    }
    //年报-股权变更
    private void guquanbiangeng(Hcrw hcrw,Sheet sheetGQBG){
        try {
            stockRightChangeMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheetGQBG.getLastRowNum();
            for (int i = 6; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(2)).trim().equals("")) {
                    StockRightChange stockRightChange = new StockRightChange();
                    stockRightChange.setId(UUID.randomUUID().toString().replace("-", ""));
                    stockRightChange.setNd(hcrw.getNd());
                    stockRightChange.setHcrwId(hcrw.getId());
                    stockRightChange.setXydm(hcrw.getHcdwXydm());
                    stockRightChange.setGd(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(2)));
                    stockRightChange.setBgqGqbl(parseFloat(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(3))));
                    stockRightChange.setBghGqbl(parseFloat(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(4))));
                    stockRightChange.setBgrq(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(5)));
                    stockRightChangeMapper.insert2(stockRightChange);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 股东股权转让等股权变更信息 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[股东股权转让等股权变更信息]数据导入处理出错;");
        }
    }
    //年报-对外投资
    private void duiwaitouzi(Hcrw hcrw,Sheet sheetDWTZ){
        try {
            investmentMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheetDWTZ.getLastRowNum();
            for (int i = 5; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(3)).trim() && !POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(3)).trim().equals("")) {
                    Investment investment = new Investment();
                    investment.setId(UUID.randomUUID().toString().replace("-", ""));
                    investment.setNd(hcrw.getNd());
                    investment.setHcrwId(hcrw.getId());
                    investment.setXydm(hcrw.getHcdwXydm());
                    investment.setTzqymc(POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(2)));
                    investment.setTzqyZch(POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(3)));
                    investmentMapper.insert2(investment);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 企业投资设立企业、购买股权信息 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[企业投资设立企业、购买股权信息]数据导入处理出错;");
        }
    }
    //年报-对外担保
    private void duiwandanbao(Hcrw hcrw,Sheet sheetDWDB){
        try {
            guaranteeMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheetDWDB.getLastRowNum();
            for (int i = 5; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(2)).trim().equals("")) {
                    Guarantee guarantee = new Guarantee();
                    guarantee.setId(UUID.randomUUID().toString().replace("-", ""));
                    guarantee.setNd(hcrw.getNd());
                    guarantee.setHcrwId(hcrw.getId());
                    guarantee.setXydm(hcrw.getHcdwXydm());
                    guarantee.setZqr(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(2)));
                    guarantee.setZwr(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(3)));
                    guarantee.setZzqzl(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(4)));
                    guarantee.setZzqse(parseFloat(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(5))));
                    guarantee.setLxzwqx(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(6)));
                    guarantee.setBzqj(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(7)));
                    guarantee.setBzfs(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(8)));
                    guarantee.setBzdbfw(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(9)));
                    guaranteeMapper.insert2(guarantee);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 对外担保信息 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[对外担保信息]数据导入处理出错;");
        }
    }
    //年报-行政许可
    private void xingzhengxuke(Hcrw hcrw,Sheet sheetXZXK){
        try {
            licenseMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheetXZXK.getLastRowNum();
            for (int i = 5; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheetXZXK.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheetXZXK.getRow(i).getCell(2)).trim().equals("")) {
                    License license = new License();
                    license.setId(UUID.randomUUID().toString().replace("-", ""));
                    license.setNd(hcrw.getNd());
                    license.setHcrwId(hcrw.getId());
                    license.setXydm(hcrw.getHcdwXydm());
                    license.setXkwjmc(POIUtils.getStringCellValue(sheetXZXK.getRow(i).getCell(3)));
                    license.setYxq(POIUtils.getStringCellValue(sheetXZXK.getRow(i).getCell(4)) + "-" + POIUtils.getStringCellValue(sheetXZXK.getRow(i).getCell(5)));
                    licenseMapper.insert2(license);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 行政许可取得、变更、延续信息 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[行政许可取得、变更、延续信息]数据导入处理出错;");
        }
    }

    //即时-股东出资
    private void jsGudongchuzhi(Hcrw hcrw,Sheet sheet) throws Exception{
        try {
            jsStockholderContributionMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            for (int i = 6; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim().equals("")) {
                    JsStockholderContribution jsStockholderContribution = new JsStockholderContribution();
                    jsStockholderContribution.setId("");
                    jsStockholderContribution.setHcrwId(hcrw.getId());
                    jsStockholderContribution.setXydm(hcrw.getHcdwXydm());
                    jsStockholderContribution.setGd(POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)));
                    jsStockholderContribution.setBgrq(getDateValue(POIUtils.getStringCellValue(sheet.getRow(i).getCell(4))));
                    jsStockholderContribution.setRje(null);
                    jsStockholderContribution.setSje(new BigDecimal(POIUtils.getStringCellValue(sheet.getRow(i).getCell(3))));
                    jsStockholderContribution.setGssj(null);
                    jsStockholderContribution.setRjczfs(null);
                    jsStockholderContribution.setRjcze(null);
                    jsStockholderContribution.setRjczrq(null);
                    jsStockholderContribution.setSjczfs(POIUtils.getStringCellValue(sheet.getRow(i).getCell(5)));
                    jsStockholderContribution.setSjcze(parseFloat(POIUtils.getStringCellValue(sheet.getRow(i).getCell(3))));
                    jsStockholderContribution.setSjczrq(getDateValue(POIUtils.getStringCellValue(sheet.getRow(i).getCell(4))));
                    jsStockholderContributionMapper.insert2(jsStockholderContribution);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 股东及出资信息 即时 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[股东及出资信息](即时)数据导入处理出错;");
        }
    }
    //即时-股权变更
    private void jsGuquanbiangeng(Hcrw hcrw,Sheet sheet) throws Exception{
        try {
            jsGqbgMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            for (int i = 6; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim().equals("")) {
                    JsGqbg jsGqbg = new JsGqbg();
                    jsGqbg.setId("");
                    jsGqbg.setHcrwId(hcrw.getId());
                    jsGqbg.setXydm(hcrw.getHcdwXydm());
                    jsGqbg.setGd(POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)));
                    jsGqbg.setBgrq(getDateValue(POIUtils.getStringCellValue(sheet.getRow(i).getCell(5))));
                    jsGqbg.setBgqbl(new BigDecimal(POIUtils.getStringCellValue(sheet.getRow(i).getCell(3))));
                    jsGqbg.setBghbl(new BigDecimal(POIUtils.getStringCellValue(sheet.getRow(i).getCell(4))));
                    jsGqbg.setGssj(null);
                    jsGqbgMapper.insert2(jsGqbg);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 股东股权转让等股权变更信息 即时 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[股东股权转让等股权变更信息](即时)数据导入处理出错;");
        }
    }
    //即时-行政处罚
    private void jsXingzhengchufa(Hcrw hcrw,Sheet sheet) throws Exception{
        try {
            jsXzcfMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            for (int i = 6; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim().equals("")) {
                    JsXzcf jsXzcf = new JsXzcf();
                    jsXzcf.setId("");
                    jsXzcf.setHcrwId(hcrw.getId());
                    jsXzcf.setXydm(hcrw.getHcdwXydm());
                    jsXzcf.setXzcfjdswh(POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)));
                    jsXzcf.setWflx(POIUtils.getStringCellValue(sheet.getRow(i).getCell(3)));
                    jsXzcf.setXzcfnr(POIUtils.getStringCellValue(sheet.getRow(i).getCell(4)));
                    jsXzcf.setCfjg(POIUtils.getStringCellValue(sheet.getRow(i).getCell(5)));
                    jsXzcf.setCfrq(getDateValue(POIUtils.getStringCellValue(sheet.getRow(i).getCell(6))));
                    jsXzcf.setBz(null);
                    jsXzcf.setGssj(null);
                    jsXzcfMapper.insert2(jsXzcf);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 受到行政处罚信息 即时 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[受到行政处罚信息](即时)数据导入处理出错;");
        }
    }
    //即时-行政许可
    private void jsXingzhengxuke(Hcrw hcrw,Sheet sheet) throws Exception{
        try {
            jsLicenseMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            for (int i = 5; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim().equals("")) {
                    JsLicense jsXjsLicensecf = new JsLicense();
                    jsXjsLicensecf.setId("");
                    jsXjsLicensecf.setHcrwId(hcrw.getId());
                    jsXjsLicensecf.setXydm(hcrw.getHcdwXydm());
                    jsXjsLicensecf.setXkwjbh(POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)));
                    jsXjsLicensecf.setXkwjmc(POIUtils.getStringCellValue(sheet.getRow(i).getCell(3)));
                    jsXjsLicensecf.setYxqKs(getDateValue(POIUtils.getStringCellValue(sheet.getRow(i).getCell(4))));
                    jsXjsLicensecf.setYxqJs(getDateValue(POIUtils.getStringCellValue(sheet.getRow(i).getCell(5))));
                    jsXjsLicensecf.setXkjg(POIUtils.getStringCellValue(sheet.getRow(i).getCell(6)));
                    jsXjsLicensecf.setXknr("");
                    jsXjsLicensecf.setZt(POIUtils.getStringCellValue(sheet.getRow(i).getCell(7)));
                    jsXjsLicensecf.setXq(null);
                    jsXjsLicensecf.setHdrq(null);
                    jsXjsLicensecf.setGssj(null);
                    jsLicenseMapper.insert2(jsXjsLicensecf);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 行政许可取得、变更、延续信息 即时 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[行政许可取得、变更、延续信息](即时)数据导入处理出错;");
        }
    }
    //即时-知识产权出质
    private void jsZhishichanquan(Hcrw hcrw,Sheet sheet) throws Exception{
        try {
            jsZscqMapper.deleteByTaskId2(hcrw.getId());
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            for (int i = 5; i < rowNum; i++) {
                if (null != POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim() && !POIUtils.getStringCellValue(sheet.getRow(i).getCell(2)).trim().equals("")) {
                    JsZscq jsZscq = new JsZscq();
                    jsZscq.setId("");
                    jsZscq.setHcrwId(hcrw.getId());
                    jsZscq.setXydm(hcrw.getHcdwXydm());
                    jsZscq.setQymc(POIUtils.getStringCellValue(sheet.getRow(i).getCell(3)));
                    jsZscq.setZl(POIUtils.getStringCellValue(sheet.getRow(i).getCell(4)));
                    jsZscq.setCzrmc(POIUtils.getStringCellValue(sheet.getRow(i).getCell(5)));
                    jsZscq.setZqrmc(POIUtils.getStringCellValue(sheet.getRow(i).getCell(6)));
                    jsZscq.setZqdjrq(getDateValue(POIUtils.getStringCellValue(sheet.getRow(i).getCell(7))));
                    jsZscq.setZt(POIUtils.getStringCellValue(sheet.getRow(i).getCell(8)));
                    jsZscq.setBhqk(POIUtils.getStringCellValue(sheet.getRow(i).getCell(9)));
                    jsZscq.setGssj(null);
                    jsZscqMapper.insert2(jsZscq);
                }
            }
        }catch(Exception e){
            e.printStackTrace();
            MongoLogger.warn("企业自查表数据上传 知识产权出质登记信息 即时 出错", ExceptionUtils.getStackTrace(e),hcrw.getId());
            throw new RuntimeException("[知识产权出质登记信息](即时)数据导入处理出错;");
        }
    }

    private BigDecimal getSumValue(Sheet sheet,int columnId,int startRow,int endRow){
        BigDecimal result= new BigDecimal("0");
        for(int i=startRow;i<=endRow;i++){
            result=result.add(parseBigDecimal(POIUtils.getCellFormatValue(sheet.getRow(i).getCell(columnId))));
        }
        return result;
    }
    private void validateExcel(String hcrwId, Workbook workbook) throws Exception{
        Sheet sheetZCFZB = workbook.getSheet("资产负债表");
        Sheet sheetLRB = workbook.getSheet("利润表");
        String errorMsg="";

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(4))).compareTo(new BigDecimal("0"))==0
                && parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(5))).compareTo(new BigDecimal("0"))==0
                && parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(9))).compareTo(new BigDecimal("0"))==0
                && parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(10))).compareTo(new BigDecimal("0"))==0){
            errorMsg=errorMsg+"[资产负债表E49 F49 J49 K49不能全为0] ";
        }else{
        }*/

        if(Math.abs(parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(4)))-parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(9))))<0.00000001){

        }else{
            errorMsg=errorMsg+"资产负债表的资产总计期初数E49不等于负债和所有者权益(或股东权益)总计期初数J49；";
        }

        if(Math.abs(parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(5)))-parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(10))))<0.00000001){

        }else{
            errorMsg=errorMsg+"资产负债表的资产总计期末数F49不等于负债和所有者权益(或股东权益)总计期末数K49；";
        }

        if(Math.abs(parseFloat(POIUtils.getCellFormatValue(sheetLRB.getRow(40).getCell(3)))-parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(46).getCell(10))))<0.00000001
                || parseBigDecimal(POIUtils.getCellFormatValue(sheetLRB.getRow(40).getCell(3))).compareTo(
                parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(46).getCell(10))).subtract(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(46).getCell(9)))))==0){

        }else{
            errorMsg=errorMsg+"利润表的未分配利润本期发生额D41不等于资产负债表的未分配利润期末数K47；";// 或者 利润表的未分配利润本期发生额D41应该等于资产表资产负债表的未分配利润期末数K47-资产负债表的未分配利润期初数J47]
        }

        if(Math.abs(parseFloat(POIUtils.getCellFormatValue(sheetLRB.getRow(40).getCell(4)))-parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(46).getCell(9))))<0.00000001){

        }else{
            errorMsg=errorMsg+"利润表的未分配利润上期发生额E41不等于资产负债表的未分配利润期初数J47；";
        }

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(20).getCell(4))).compareTo(getSumValue(sheetZCFZB,4,7,19))==0){

        }else{
            errorMsg=errorMsg+"资产负债表的E8-E20的合计数不等于E21";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(20).getCell(5))).compareTo(getSumValue(sheetZCFZB,5,7,19))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的F8-F20的合计数不等于F21] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(39).getCell(4))).compareTo(getSumValue(sheetZCFZB,4,22,38))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的E23-E39的合计数不等于E40] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(39).getCell(5))).compareTo(getSumValue(sheetZCFZB,5,22,38))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的F23-F39的合计数不等于F40] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(4))).compareTo(
                parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(20).getCell(4))).add(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(39).getCell(4)))))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的E49不等于E21+E40] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(5))).compareTo(
                parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(20).getCell(5))).add(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(39).getCell(5)))))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的F49不等于F21+F40] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(21).getCell(9))).compareTo(getSumValue(sheetZCFZB,9,7,20))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的J8-J21的合计数不等于J22] ";
        }*/

       /* if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(21).getCell(10))).compareTo(getSumValue(sheetZCFZB,10,7,20))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的k8-k21的合计数不等于k22] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(34).getCell(9))).compareTo(getSumValue(sheetZCFZB,9,27,33).add(getSumValue(sheetZCFZB,9,23,24)))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的J24-J25之和加上J28-J34之和不等于J35] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(34).getCell(10))).compareTo(getSumValue(sheetZCFZB,10,27,33).add(getSumValue(sheetZCFZB,10,23,24)))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的K24-K25之和加上K28-K34之和不等于K35] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(35).getCell(9))).compareTo(
                parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(21).getCell(9))).add(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(34).getCell(9)))))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的J22+J35不等于J36] ";
        }*/

       /* if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(35).getCell(10))).compareTo(
                parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(21).getCell(10))).add(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(34).getCell(10)))))==0){

        }else{
            errorMsg=errorMsg+"[资产负债表的K22+K35不等于K36] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(47).getCell(9))).compareTo(
                parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(37).getCell(9))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(38).getCell(9)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(41).getCell(9)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(43).getCell(9)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(44).getCell(9)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(45).getCell(9)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(46).getCell(9)))))==0){
        }else{
            errorMsg=errorMsg+"[资产负债表的J38+J39+J42+J44+J45+J46+J47不等于J48] ";
        }*/

        /*if(parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(47).getCell(10))).compareTo(
                parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(37).getCell(10))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(38).getCell(10)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(41).getCell(10)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(43).getCell(10)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(44).getCell(10)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(45).getCell(10)))).add(
                        parseBigDecimal(POIUtils.getCellFormatValue(sheetZCFZB.getRow(46).getCell(10)))))==0){
        }else{
            errorMsg=errorMsg+"[资产负债表的K38+K39+K42+K44+K45+K46+K47不等于K48] ";
        }*/

        /*if(Math.abs(parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(4)))-parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(9))))<0.00000001){

        }else{
            errorMsg=errorMsg+"[资产负债表的资产期初数总计E49不等于负债期初数总计J49] ";
        }*/

        /*if(Math.abs(parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(5)))-parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(10))))<0.00000001){

        }else{
            errorMsg=errorMsg+"[资产负债表的资产本期数总计F49不等于负债本期数总计K49] ";
        }*/

        /*if(!errorMsg.equals("")){
            throw new RuntimeException(errorMsg);
        }*/
        if(null!=errorMsg && !errorMsg.equals("")) {
            hcrwMapper.updateZcbResultByPrimaryKey(hcrwId, "      企业上报自查表报表数据有误，其中：" + errorMsg);
        }else{
            hcrwMapper.updateZcbResultByPrimaryKey(hcrwId, "");
        }
    }
	@Override
    @Transactional
	public void uploadSelfCheckData(InputStream is, String hcrwId, String fileName) throws Exception {
        Hcrw hcrw=hcrwMapper.selectByPrimaryKey(hcrwId);
        Workbook workbook=null;
        if (fileName.endsWith("xls")) {
            POIFSFileSystem fs=new POIFSFileSystem(is);
            workbook = new HSSFWorkbook(fs);
        } else if (fileName.endsWith("xlsx")) {
            workbook = new XSSFWorkbook(is);
        }

        //校验表数据
        validateExcel(hcrwId, workbook);
        if(importFlag.equals("1")) {
            //网址
            nianbaoWangzhiwangdian(hcrw,workbook.getSheet("企业公示信息自查表"));
            //年报数据
            nianbao(hcrw,workbook.getSheet("资产负债表"),workbook.getSheet("企业公示信息自查表"),workbook.getSheet("利润表"));

            //股东出资
            gudongchuzi(hcrw,workbook.getSheet("股东及出资信息"));

            //股权变更
            guquanbiangeng(hcrw,workbook.getSheet("股东股权转让等股权变更信息"));

            //对外投资
            duiwaitouzi(hcrw,workbook.getSheet("企业投资设立企业、购买股权信息"));

            //对外担保
            duiwandanbao(hcrw,workbook.getSheet("对外担保信息"));

            //行政许可
            xingzhengxuke(hcrw,workbook.getSheet("行政许可取得、变更、延续信息"));

            jsGudongchuzhi(hcrw,workbook.getSheet("股东及出资信息"));
            jsGuquanbiangeng(hcrw,workbook.getSheet("股东股权转让等股权变更信息"));
            jsXingzhengxuke(hcrw,workbook.getSheet("行政许可取得、变更、延续信息"));
            jsZhishichanquan(hcrw,workbook.getSheet("知识产权出质登记信息"));
            jsXingzhengchufa(hcrw,workbook.getSheet("受到行政处罚信息"));
        }
        workbook.close();
    }

    @Override
    public Map<String, Object> getDXNHccl(Map<String,Object> params) {
        return hcclMapper.getDXNHcsx(params).get(0);
    }

    @Override
    public void judgeRepeatExcle(InputStream is, int firstRowNum, int colNum,String fileName) throws Exception {
        Map<String,Object> sheetValues = new HashedMap();
        Workbook workbook=null;
        if (fileName.endsWith("xls")) {
            POIFSFileSystem fs=new POIFSFileSystem(is);
            workbook = new HSSFWorkbook(fs);
        } else if (fileName.endsWith("xlsx")) {
            workbook = new XSSFWorkbook(is);
        }
        Sheet sheet = workbook.getSheetAt(0);
        for (int i=firstRowNum;i<sheet.getLastRowNum()+1;i++){
            Row row = sheet.getRow(i-1);
            System.out.println(i);
            Cell cell=row.getCell(colNum-1);
            if(null!=cell && null!=POIUtils.getStringCellValue(cell) && !POIUtils.getStringCellValue(cell).equals("")) {
                if (sheetValues.containsKey(POIUtils.getStringCellValue(cell))) {
                    throw new RuntimeException(POIUtils.getStringCellValue(cell) + "科目编码重复，请重新修改后上传！");
                } else {
                    sheetValues.put(POIUtils.getStringCellValue(cell), i);
                }
            }
        }
    }

}
