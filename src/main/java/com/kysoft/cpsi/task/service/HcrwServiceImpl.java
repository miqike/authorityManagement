package com.kysoft.cpsi.task.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.kysoft.cpsi.repo.entity.Hcsx;
import com.kysoft.cpsi.repo.mapper.HcsxMapper;
import com.kysoft.cpsi.task.entity.Hcrw;
import com.kysoft.cpsi.task.entity.Hcsxjg;
import com.kysoft.cpsi.task.mapper.HcrwMapper;
import com.kysoft.cpsi.task.mapper.HcsxjgMapper;
import net.sf.husky.codelist.service.CodeListProvider;
import net.sf.husky.log.MongoLogger;
import net.sf.husky.security.entity.User;
import net.sf.husky.utils.WebUtils;
import org.apache.commons.collections.map.HashedMap;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("hcrwService")
public class HcrwServiceImpl implements HcrwService {

    @Resource
    HcrwMapper hcrwMapper;

    @Resource
    HcsxMapper hcsxMapper;

    @Resource
    HcsxjgMapper hcsxjgMapper;
    
    @Resource
    HcjhService hcjhService;

    @Resource
    CodeListProvider codeListProvider;

    @Override
    public void initTaskItem(String hcrwId, int pullDataFlag) {
        List<Hcsx> hcsxList = hcsxMapper.selectByTaskId(hcrwId);
        for (Hcsx hcsx : hcsxList) {
            Hcsxjg hcsxjg = new Hcsxjg();
            hcsxjg.setHcrwId(hcrwId);
            hcsxjg.setHcsxId(hcsx.getId());
            hcsxjg.setName(hcsx.getName());
            hcsxjg.setHcfs(hcsx.getHcff());
            hcsxjg.setPage(hcsx.getPage());
            hcsxjg.setHclx(hcsx.getHclx());
            hcsxjg.setDbxxly(hcsx.getDbxxly());
            hcsxjg.setHczt(1);
            hcsxjgMapper.insert(hcsxjg);
        }
        MongoLogger.info("task", "用户对核查任务进行初始操作,初始核查事项: " + hcsxList.size());
        if(pullDataFlag == 1) {
        	pullData(hcrwId);
        }
    }

    @Override
    public void pullData(String hcrwId) {
        Hcrw hcrw=hcrwMapper.selectByPrimaryKey(hcrwId);
        if(null!=hcrw.getHcjieguo()){
            throw new RuntimeException("已经设置核查结果，请先取消！");
        }else {
            Map<String, Object> param = Maps.newHashMap();
            param.put("hcrwId", hcrwId);
            hcrwMapper.pullData(param);
            hcrwMapper.updateLoadedByPrimaryKey(hcrwId);
            MongoLogger.info("task", "用户对核查任务进行数据加载操作");
        }
    }

    @Override
    public List<Map> getHcsxCode(String hcrwId) {
        return hcsxMapper.getHcsxCode(hcrwId);
    }

    @Override
    public Hcrw getHcrwById(String hcrwId) {
        return hcrwMapper.selectByPrimaryKey(hcrwId);
    }

    @Override
    public void updateHcrw(Hcrw hcrw) {
        hcrwMapper.updateByPrimaryKey(hcrw);
        MongoLogger.info("task", "用户更新任务检查结果: " + hcrw.getHcjieguo());
    }

    @Override
    public List<Hcrw> queryForOrg(Map<String, Object> params) {
        return hcrwMapper.queryForOrg(params);
    }

    @Override
    public Integer getTaskInitStatus(String hcrwId) {
        return hcsxjgMapper.selectCountByTaskId(hcrwId);
    }

	@Override
	public void accept(String planId, List<String> taskIds) {
		User user = WebUtils.getCurrentUser();
		hcrwMapper.updateAccept(taskIds, user.getUserId(), user.getName());
		hcjhService.reCalcAcceptStatus(planId);
		MongoLogger.info("task", "用户认领任务: " + taskIds.size(), null, planId);
	}
	
	public void unAccept(String planId, List<String> taskIds) {
		hcrwMapper.updateUnAccept(taskIds);
		hcjhService.reCalcAcceptStatus(planId);
		MongoLogger.info("task", "用户取消认领任务: " + taskIds.size(), null, planId);
	}

	@Override
	public void setTaskStatus(String hcrwId, Integer statusCode) {
		hcrwMapper.updateStatusByPrimaryKey(hcrwId, statusCode);
		MongoLogger.info("task", "用户修改任务状态: " + statusCode, null, hcrwId);
	}

	@Override
	public void updateDocReadyFlag(String hcrwId, int docReadyReportFlag) {
		int flag = docReadyReportFlag == 0? 1: 0;
		User user = WebUtils.getCurrentUser();
        Hcrw hcrw=hcrwMapper.selectByPrimaryKey(hcrwId);
        if(null != hcrw.getRwzt() && hcrw.getRwzt()==5 && docReadyReportFlag==1){
            throw new RuntimeException("任务已经完成，不能取消上报");
        }
		hcrwMapper.updateDocReadyReportFlag(hcrwId, flag, user.getName());
		MongoLogger.info("task", "用户对任务进行上报操作: " + docReadyReportFlag, null, hcrwId);
	}

	@Override
	public void auditHcrw(Hcrw hcrw) {
		User auditor = WebUtils.getCurrentUser();
		hcrw.setAuditor(auditor.getUserId());
		hcrw.setAuditorName(auditor.getName());
		hcrwMapper.updateAuditByPrimaryKey(hcrw);
		MongoLogger.info("task", "用户对任务结果进行审核");
	}

	@Override
	public void cancelAuditHcrw(String hcrwId) {
		hcrwMapper.updateCancelAuditByPrimaryKey(hcrwId);
		MongoLogger.info("task", "用户取消对任务结果的审核");
	}

	@Override
	public void batchAuditHcrw(Hcrw hcrw) {
		User auditor = WebUtils.getCurrentUser();
		hcrw.setAuditor(auditor.getUserId());
		hcrw.setAuditorName(auditor.getName());
		String[] id = hcrw.getId().split(",");
		
		hcrwMapper.updateAudit(Arrays.asList(id), hcrw.getAuditResult(), hcrw.getAuditComment(), 
				auditor.getUserId(), auditor.getName(), hcrw.getHcjieguo());
	}

	@Override
	public void batchCancelAuditHcrw(List<String> taskIds) {
		// TODO Auto-generated method stub
		hcrwMapper.updateCancelAudit(taskIds);		
	}

    @Override
    public JSONArray getHcsxJg(String hcrwId) {
        Map<String,Object> param=new HashedMap();
        param.put("hcrwId",hcrwId);
        hcrwMapper.getHcsxJgData(param);
        JSONArray resultStr=JSONArray.parseArray(param.get("resultStr").toString());
        return resultStr;
    }

    private HSSFCellStyle setCellStyle(HSSFWorkbook workBook, String dataFormat, HorizontalAlignment  alignment, VerticalAlignment verticalAlignment, BorderStyle boderLeft, BorderStyle boderRight, BorderStyle boderTop, BorderStyle boderBottom, boolean bold, int fontSize){

        HSSFFont font = workBook.createFont();
        font.setBold(bold);
        font.setFontHeightInPoints((short) fontSize);

        HSSFCellStyle cellStyle = workBook.createCellStyle();
        cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat(dataFormat));//设置数字单元格式
        cellStyle.setAlignment(alignment);
        cellStyle.setVerticalAlignment(verticalAlignment);
        cellStyle.setBorderLeft(boderLeft);
        cellStyle.setBorderRight(boderRight);
        cellStyle.setBorderTop(boderTop);
        cellStyle.setBorderBottom(boderBottom);
        cellStyle.setFont(font);
        cellStyle.setWrapText(true);
        return cellStyle;
    }
    //导出核查结果报告到EXCEL
    private JSONObject getDataFromDataList(int xh, JSONArray dataList,String zhongDian,JSONArray dataRelation){
        JSONObject data=new JSONObject();

        data.put("no1",xh);
        data.put("no2",zhongDian);
        data.put("no3",((JSONObject)dataRelation.get(xh-1)).get("dest"));
        data.put("no4","");
        data.put("no5","");
        data.put("no6","");
        data.put("no7","");
        data.put("no8","");
        for(int i =0;i<dataList.size();i++){
            if(((JSONObject)dataList.get(i)).get("name").equals(((JSONObject)dataRelation.get(xh-1)).get("source"))){
                data.put("no4",((JSONObject)dataList.get(i)).get("qygsnr"));
                data.put("no5",((JSONObject)dataList.get(i)).get("bznr"));
                data.put("no6",((JSONObject)dataList.get(i)).get("sjnr"));
                data.put("no7",codeListProvider.trans("hcjg",(String)((JSONObject)dataList.get(i)).get("hcjg")));
                data.put("no8",((JSONObject)dataList.get(i)).get("sm"));
            }
        }
        return data;
    }
    private void writeOneRowData(HSSFWorkbook workbook, HSSFSheet sheet, int rowNum, JSONObject jsonObject,int xh,short height,boolean lastFlag){
        HSSFRow row;
        HSSFCell cell;
        row = sheet.createRow(rowNum);
        row.setHeight(height);
        cell = row.createCell(0);
        int fontSize=6;
        if(lastFlag) {
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.MEDIUM , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
            cell.setCellValue(String.valueOf(xh));
            cell = row.createCell(1);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no2"));
            cell = row.createCell(2);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no3"));
            cell = row.createCell(3);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no4"));
            cell = row.createCell(4);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no5"));
            cell = row.createCell(5);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no6"));
            cell = row.createCell(6);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no7"));
            cell = row.createCell(7);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, BorderStyle.MEDIUM, false, fontSize));
        }else{
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.MEDIUM , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue(String.valueOf(xh));
            cell = row.createCell(1);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no2"));
            cell = row.createCell(2);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no3"));
            cell = row.createCell(3);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no4"));
            cell = row.createCell(4);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no5"));
            cell = row.createCell(5);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no6"));
            cell = row.createCell(6);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no7"));
            cell = row.createCell(7);
            cell.setCellType(CellType.STRING);
            cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, BorderStyle.THIN, false, fontSize));
            cell.setCellValue((String)jsonObject.get("no8"));
        }
    }
    @Override
    public Map<String, Object> exportExcelHcsxJg(String hcrwId) throws Exception {
        JSONArray jsonArray=getHcsxJg(hcrwId);
        Map<String,Object> result=new HashMap<>();

        //定义数据关系
        JSONArray dataRelation = new JSONArray();
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("xh",1);
        jsonObject.put("source","企业投资设立企业、购买股权信息");
        jsonObject.put("dest","企业投资设立企业、购买股权信息");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",2);
        jsonObject.put("source","股东或发起人认缴和实缴的出资额等信息");
        jsonObject.put("dest","股东或发起人认缴和实缴的出资额、出资时间、出资方式等信息");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",3);
        jsonObject.put("source","有限公司股东股权转让等股权变更信息");
        jsonObject.put("dest","有限公司股东股权转让等股权变更信息");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",4);
        jsonObject.put("source","资产总额（万元）");
        jsonObject.put("dest","资产总额（万元）");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",5);
        jsonObject.put("source","负债总额（万元）");
        jsonObject.put("dest","负债总额（万元）");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",6);
        jsonObject.put("source","所有者权益合计（万元）");
        jsonObject.put("dest","所有者权益合计（万元）");
        dataRelation.add(jsonObject);
        jsonObject.put("xh",7);
        jsonObject.put("source","营业总收入（万元）");
        jsonObject.put("dest","营业总收入（万元）");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",8);
        jsonObject.put("source","主营业务收入（万元）");
        jsonObject.put("dest","主营业务收入（万元）");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",9);
        jsonObject.put("source","利润总额（万元）");
        jsonObject.put("dest","利润总额（万元）");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",10);
        jsonObject.put("source","净利润（万元）");
        jsonObject.put("dest","净利润（万元）");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",11);
        jsonObject.put("source","纳税总额（万元）");
        jsonObject.put("dest","纳税总额（万元）");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",12);
        jsonObject.put("source","对外提供保证担保信息");
        jsonObject.put("dest","对外提供保证担保信息");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",13);
        jsonObject.put("source","企业通信地址");
        jsonObject.put("dest","企业通信地址");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",14);
        jsonObject.put("source","邮政编码");
        jsonObject.put("dest","邮政编码");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",15);
        jsonObject.put("source","联系电话");
        jsonObject.put("dest","联系电话");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",16);
        jsonObject.put("source","电子邮箱");
        jsonObject.put("dest","电子邮箱");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",17);
        jsonObject.put("source","企业网站及从事经营的网店的名称和网址");
        jsonObject.put("dest","企业网站以及从事网络经营的网店名称、网址等信息");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",18);
        jsonObject.put("source","存续状态");
        jsonObject.put("dest","企业开业、歇业、清算等存续状态");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",19);
        jsonObject.put("source","从业人员信息");
        jsonObject.put("dest","从业人数");
        dataRelation.add(jsonObject);
        jsonObject=new JSONObject();
        jsonObject.put("xh",20);
        jsonObject.put("source","党建信息");
        jsonObject.put("dest","党建信息");
        dataRelation.add(jsonObject);

        Hcrw hcrw=hcrwMapper.selectByPrimaryKey(hcrwId);

        int iRow=0;
        int nColumn=8;
        HSSFWorkbook workbook = new HSSFWorkbook(); //产生工作簿对象
        HSSFSheet sheet = workbook.createSheet(); //产生工作表对象
        HSSFPrintSetup ps1 = sheet.getPrintSetup();
        ps1.setPaperSize(HSSFPrintSetup.A4_PAPERSIZE);
        workbook.setSheetName(0,hcrw.getHcdwName());

        HSSFRow row;
        HSSFCell cell;
        //设置列宽
        sheet.setColumnWidth(0,800);
        sheet.setColumnWidth(1,1200);
        sheet.setColumnWidth(2,1500);
        sheet.setColumnWidth(3,4000);
        sheet.setColumnWidth(4,4000);
        sheet.setColumnWidth(5,4000);
        sheet.setColumnWidth(6,1200);
        sheet.setColumnWidth(7,4000);

        //表头
        row = sheet.createRow(iRow);
        row.setHeight((short)500);
        cell = row.createCell(0);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, true, 12));
        cell.setCellValue("企业年报公示信息核查结果报告");
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,0,nColumn-1));
        iRow++;
        row = sheet.createRow(iRow);
        row.setHeight((short)500);
        cell = row.createCell(0);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.LEFT, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, false, 8));
        cell.setCellValue("核查机关："+ hcrw.getHcjgmc());
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,0,5-1));
        cell = row.createCell(5);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.LEFT, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, false, 8));
        cell.setCellValue("检查时间："+new SimpleDateFormat("yyyy-MM-dd").format(hcrw.getSjwcrq()));
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,5,8-1));
        iRow++;
        row = sheet.createRow(iRow);
        row.setHeight((short)500);
        cell = row.createCell(0);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.LEFT, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, false, 8));
        cell.setCellValue("计划名称："+ hcrw.getJhmc());
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,0,5-1));
        cell = row.createCell(5);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.LEFT, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, false, 8));
        cell.setCellValue("计划编号："+hcrw.getJhbh());
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,5,8-1));
        iRow++;
        row = sheet.createRow(iRow);
        row.setHeight((short)500);
        cell = row.createCell(0);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.LEFT, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, false, 8));
        cell.setCellValue("企业名称："+ hcrw.getHcdwName());
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,0,8-1));
        iRow++;
        row = sheet.createRow(iRow);
        row.setHeight((short)500);
        cell = row.createCell(0);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.LEFT, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, false, 8));
        cell.setCellValue("注册号/社会统一信用代码："+ hcrw.getHcdwXydm());
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,0,5-1));
        cell = row.createCell(5);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.LEFT, VerticalAlignment.CENTER, BorderStyle.NONE , BorderStyle.NONE, BorderStyle.NONE, BorderStyle.NONE, false, 8));
        cell.setCellValue("抽查结果："+codeListProvider.trans("gsjg",String.valueOf(hcrw.getHcjieguo())));
        sheet.addMergedRegion(new CellRangeAddress(iRow,iRow,5,8-1));
        iRow++;
        row = sheet.createRow(iRow);
        row.setHeight((short)1000);
        cell = row.createCell(0);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.MEDIUM , BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("序号");
        cell = row.createCell(1);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("检查信息分类");
        cell = row.createCell(2);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("检查项目");
        cell = row.createCell(3);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("公示内容");
        cell = row.createCell(4);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("登记/备案内容");
        cell = row.createCell(5);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("实际内容");
        cell = row.createCell(6);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.THIN, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("对比结果");
        cell = row.createCell(7);
        cell.setCellType(CellType.STRING);
        cell.setCellStyle(setCellStyle(workbook, "@", HorizontalAlignment.CENTER, VerticalAlignment.CENTER, BorderStyle.THIN , BorderStyle.MEDIUM, BorderStyle.MEDIUM, BorderStyle.THIN, true, 8));
        cell.setCellValue("问题描述");

        iRow++;
        JSONObject data=getDataFromDataList(1,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,1,(short)500,false);
        iRow++;
        data=getDataFromDataList(2,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,2,(short)500,false);
        iRow++;
        data=getDataFromDataList(3,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,3,(short)500,false);
        iRow++;
        data=getDataFromDataList(4,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,4,(short)500,false);
        iRow++;
        data=getDataFromDataList(5,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,5,(short)500,false);
        iRow++;
        data=getDataFromDataList(6,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,6,(short)500,false);
        iRow++;
        data=getDataFromDataList(7,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,7,(short)500,false);
        iRow++;
        data=getDataFromDataList(8,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,8,(short)500,false);
        iRow++;
        data=getDataFromDataList(9,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,9,(short)500,false);
        iRow++;
        data=getDataFromDataList(10,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,10,(short)500,false);
        iRow++;
        data=getDataFromDataList(11,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,11,(short)500,false);
        iRow++;
        data=getDataFromDataList(12,jsonArray,"重点",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,12,(short)500,false);
        iRow++;
        data=getDataFromDataList(13,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,13,(short)500,false);
        iRow++;
        data=getDataFromDataList(14,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,14,(short)500,false);
        iRow++;
        data=getDataFromDataList(15,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,15,(short)500,false);
        iRow++;
        data=getDataFromDataList(16,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,16,(short)500,false);
        iRow++;
        data=getDataFromDataList(17,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,17,(short)500,false);
        iRow++;
        data=getDataFromDataList(18,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,18,(short)500,false);
        iRow++;
        data=getDataFromDataList(19,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,19,(short)500,false);
        iRow++;
        data=getDataFromDataList(20,jsonArray,"一般",dataRelation);
        writeOneRowData(workbook,sheet,iRow,data,20,(short)500,true);
        sheet.addMergedRegion(new CellRangeAddress(9,16,7,7));//合并财务数据问题描述

        result.put("workbook",workbook);
        result.put("sheet",sheet);
        result.put("fileName",hcrw.getHcdwName());
        return result;
    }


}
