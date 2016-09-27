package com.kysoft.cpsi.audit.service;

import com.kysoft.cpsi.audit.entity.*;
import com.kysoft.cpsi.audit.mapper.*;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import net.sf.husky.log.service.LogService;
import net.sf.husky.utils.POIUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.InputStream;
import java.text.DecimalFormat;
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
    HcrwMapper hcrwMapper;

    private void nianbao(Hcrw hcrw, Sheet sheetZCFZB, Sheet sheetZCB, Sheet sheetLRB){
        /**
         * 可能的数据错误
         * 从业人数：只能是数值
         * */
        DecimalFormat decimalFormat=new DecimalFormat(".00");
        //年报数据
        AnnualReport annualReport=new AnnualReport();
        annualReport.setNd(hcrw.getNd());
        annualReport.setXydm(hcrw.getHcdwXydm());
        annualReport.setQymc(hcrw.getHcdwName());
        annualReport.setHcrwId(hcrw.getId());

        annualReport.setSyzqyhj(Float.parseFloat(decimalFormat.format(Float.parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(47).getCell(10)))/10000)));
        annualReport.setLrze(Float.parseFloat(POIUtils.getCellFormatValue(sheetLRB.getRow(25).getCell(3))));
        annualReport.setYyzsr(Float.parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(6).getCell(3))));
        annualReport.setZyywsr(Float.parseFloat(POIUtils.getStringCellValue(sheetLRB.getRow(7).getCell(3))));
        annualReport.setJlr(Float.parseFloat(POIUtils.getCellFormatValue(sheetLRB.getRow(27).getCell(3))));
        annualReport.setNsze(Float.parseFloat(POIUtils.getStringCellValue(sheetZCB.getRow(9).getCell(5))));
        annualReport.setFzze(Float.parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(35).getCell(10))));
        annualReport.setZcze(Float.parseFloat(POIUtils.getCellFormatValue(sheetZCFZB.getRow(48).getCell(5))));

        annualReport.setTxdz(POIUtils.getStringCellValue(sheetZCB.getRow(6).getCell(3)));
        annualReport.setYzbm(POIUtils.getStringCellValue(sheetZCB.getRow(8).getCell(5)));
        annualReport.setLxdh(POIUtils.getStringCellValue(sheetZCB.getRow(5).getCell(5)));
        annualReport.setMail(POIUtils.getStringCellValue(sheetZCB.getRow(6).getCell(5)));
        annualReport.setCyrs(Integer.parseInt(POIUtils.getStringCellValue(sheetZCB.getRow(7).getCell(5))));
        annualReport.setJyzt(POIUtils.getStringCellValue(sheetZCB.getRow(8).getCell(3)));
        annualReport.setSftzgmgq(POIUtils.getStringCellValue(sheetZCB.getRow(13).getCell(4)));
        annualReport.setSfydwdbxx(POIUtils.getStringCellValue(sheetZCB.getRow(14).getCell(4)));
        //删除老数据
        annualReportMapper.deleteByTaskId2(hcrw.getId());
        //插入新数据
        annualReportMapper.insert2(annualReport);
    }
    private void gudongchuzi(Hcrw hcrw,Sheet sheetGDCZ){
        stockholderContributionMapper.deleteByTaskId2(hcrw.getId());
        // 得到总行数
        int rowNum = sheetGDCZ.getLastRowNum();
        for(int i=6;i<rowNum;i++){
            if(null != POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(3)) && !POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(3)).equals("")) {
                StockholderContribution stockholderContribution = new StockholderContribution();
                stockholderContribution.setId(UUID.randomUUID().toString().replace("-", ""));
                stockholderContribution.setNd(hcrw.getNd());
                stockholderContribution.setHcrwId(hcrw.getId());
                stockholderContribution.setXydm(hcrw.getHcdwXydm());
                stockholderContribution.setGd(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(2)));
                stockholderContribution.setRjcze(null);
                stockholderContribution.setRjczdqsj(null);
                stockholderContribution.setRjczfs(null);
                stockholderContribution.setSjcze(Float.parseFloat(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(3))));
                stockholderContribution.setSjczsj(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(4)));
                stockholderContribution.setSjczfs(POIUtils.getStringCellValue(sheetGDCZ.getRow(i).getCell(5)));
                stockholderContributionMapper.insert2(stockholderContribution);
            }
        }
    }
    private void guquanbiangeng(Hcrw hcrw,Sheet sheetGQBG){
        stockRightChangeMapper.deleteByTaskId2(hcrw.getId());
        // 得到总行数
        int rowNum = sheetGQBG.getLastRowNum();
        for(int i=6;i<rowNum;i++){
            if(null != POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(2)) && !POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(2)).equals("")) {
                StockRightChange stockRightChange = new StockRightChange();
                stockRightChange.setId(UUID.randomUUID().toString().replace("-", ""));
                stockRightChange.setNd(hcrw.getNd());
                stockRightChange.setHcrwId(hcrw.getId());
                stockRightChange.setXydm(hcrw.getHcdwXydm());
                stockRightChange.setGd(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(2)));
                stockRightChange.setBghGqbl(Float.parseFloat(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(3))));
                stockRightChange.setBghGqbl(Float.parseFloat(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(4))));
                stockRightChange.setBgrq(POIUtils.getStringCellValue(sheetGQBG.getRow(i).getCell(5)));
                stockRightChangeMapper.insert2(stockRightChange);
            }
        }
    }
    private void duiwaitouzi(Hcrw hcrw,Sheet sheetDWTZ){
        investmentMapper.deleteByTaskId2(hcrw.getId());
        // 得到总行数
        int rowNum = sheetDWTZ.getLastRowNum();
        for(int i=6;i<rowNum;i++){
            if(null != POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(3)) && !POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(3)).equals("")) {
                Investment investment = new Investment();
                investment.setId(UUID.randomUUID().toString().replace("-", ""));
                investment.setNd(hcrw.getNd());
                investment.setHcrwId(hcrw.getId());
                investment.setXydm(hcrw.getHcdwXydm());
                investment.setTzqymc(POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(3)));
                investment.setTzqyZch(POIUtils.getStringCellValue(sheetDWTZ.getRow(i).getCell(4)));
                investmentMapper.insert2(investment);
            }
        }
    }
    private void duiwandanbao(Hcrw hcrw,Sheet sheetDWDB){
        guaranteeMapper.deleteByTaskId2(hcrw.getId());
        // 得到总行数
        int rowNum = sheetDWDB.getLastRowNum();
        for(int i=6;i<rowNum;i++){
            if(null != POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(2)) && !POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(2)).equals("")) {
                Guarantee guarantee = new Guarantee();
                guarantee.setId(UUID.randomUUID().toString().replace("-", ""));
                guarantee.setNd(hcrw.getNd());
                guarantee.setHcrwId(hcrw.getId());
                guarantee.setXydm(hcrw.getHcdwXydm());
                guarantee.setZqr(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(2)));
                guarantee.setZwr(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(3)));
                guarantee.setZzqzl(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(4)));
                guarantee.setZzqse(Float.parseFloat(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(5))));
                guarantee.setLxzwqx(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(6)));
                guarantee.setBzqj(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(7)));
                guarantee.setBzfs(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(8)));
                guarantee.setBzdbfw(POIUtils.getStringCellValue(sheetDWDB.getRow(i).getCell(9)));
                guaranteeMapper.insert2(guarantee);
            }
        }

    }
    private void xingzhengxuke(Hcrw hcrw,Sheet sheetXZXK){
        licenseMapper.deleteByTaskId2(hcrw.getId());
        // 得到总行数
        int rowNum = sheetXZXK.getLastRowNum();
        for(int i=6;i<rowNum;i++){
            if(null != POIUtils.getStringCellValue(sheetXZXK.getRow(i).getCell(3)) && !POIUtils.getStringCellValue(sheetXZXK.getRow(i).getCell(3)).equals("")) {
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
    }

	@Override
	public void uploadSelfCheckData(InputStream is, String hcrwId, String fileName) throws Exception {
        Hcrw hcrw=hcrwMapper.selectByPrimaryKey(hcrwId);
        Workbook workbook=null;
        if (fileName.endsWith("xls")) {
            POIFSFileSystem fs=new POIFSFileSystem(is);
            workbook = new HSSFWorkbook(fs);
        } else if (fileName.endsWith("xlsx")) {
            workbook = new XSSFWorkbook(is);
        }
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

        workbook.close();
	}
}
