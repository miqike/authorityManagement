package com.kysoft.cpsi.zcb.controller;


import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.kysoft.cpsi.zcb.entity.SctDwdb;
import com.kysoft.cpsi.zcb.entity.SctDwtz;
import com.kysoft.cpsi.zcb.entity.SctGdcz;
import com.kysoft.cpsi.zcb.entity.SctGqbg;
import com.kysoft.cpsi.zcb.entity.SctGsxxzcb;
import com.kysoft.cpsi.zcb.entity.SctLrb;
import com.kysoft.cpsi.zcb.entity.SctXjllb;
import com.kysoft.cpsi.zcb.entity.SctXzcf;
import com.kysoft.cpsi.zcb.entity.SctXzxk;
import com.kysoft.cpsi.zcb.entity.SctZcfzb;
import com.kysoft.cpsi.zcb.entity.SctZscq;
import com.kysoft.cpsi.zcb.service.SaveService;

import net.sf.husky.web.controller.BaseController;
@RestController
@RequestMapping("/zcb")
public class SaveController extends BaseController{
	@Resource
	SaveService saveService;
	@RequestMapping(value="/saveZCFZ",method=RequestMethod.POST)
	public Map<String, Object> saveZCFZ(SctZcfzb zcfz){
		Map<String, Object> result = Maps.newHashMap();
		
			 try {
				 saveService.saveZCFZ(zcfz);
		            result.put(STATUS, SUCCESS);
		            result.put(MESSAGE, "资产负债表保存成功");
		        } catch (Exception e) {
		            e.printStackTrace();
		            result.put(STATUS, FAIL);
		            result.put(MESSAGE, "资产负债表保存失败");
		        }
       
        
		return result;
	}
	
	@RequestMapping(value="/saveDWDB",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveDWDB(@RequestBody JSONObject[] jsonObjects){
		Map<String, Object> result = Maps.newHashMap();
		
			 try {
				 for(JSONObject jsonObject:jsonObjects){
					 SctDwdb dwdb=JSON.parseObject(jsonObject.toJSONString(), SctDwdb.class);
				 saveService.saveDWDB(dwdb);
				 }
		            result.put(STATUS, SUCCESS);
		            result.put(MESSAGE, "对外担保信息表保存成功");
		        } catch (Exception e) {
		            e.printStackTrace();
		            result.put(STATUS, FAIL);
		            result.put(MESSAGE, "对外担保信息表保存失败");
		        }
       
        
		return result;
	}
	
	@RequestMapping(value="/saveGDCZ",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveGDCZ(@RequestBody List<JSONObject> gdczs){
		Map<String, Object> result = Maps.newHashMap();
		
			 try {
				 for(JSONObject jsonObject:gdczs){
					 SctGdcz gdcz=JSON.parseObject(jsonObject.toJSONString(), SctGdcz.class); 
					 saveService.saveGDCZ(gdcz);
				 }
		            result.put(STATUS, SUCCESS);
		            result.put(MESSAGE, "股东及出资信息表保存成功");
		        } catch (Exception e) {
		            e.printStackTrace();
		            result.put(STATUS, FAIL);
		            result.put(MESSAGE, "股东及出资信息表保存失败");
		        }
       
        
		return result;
	}
	
	@RequestMapping(value="/saveGQBG",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveGDBG(@RequestBody List<JSONObject> gqbgs){
		Map<String, Object> result = Maps.newHashMap();
		
		
			 try {
				 for(JSONObject jsonObject:gqbgs){
					 SctGqbg gqbg=JSON.parseObject(jsonObject.toJSONString(), SctGqbg.class); 
					 saveService.saveGQBG(gqbg);
				 }
		            result.put(STATUS, SUCCESS);
		            result.put(MESSAGE, "股权变更信息表保存成功");
		        } catch (Exception e) {
		            e.printStackTrace();
		            result.put(STATUS, FAIL);
		            result.put(MESSAGE, "股权变更信息表保存失败");
		        }
       
        
		return result;
	}
	
	@RequestMapping(value="/saveLR",method=RequestMethod.POST)
	public Map<String, Object> saveLR(SctLrb lrb){
		Map<String, Object> result = Maps.newHashMap();
		
			 try {
				 saveService.saveLR(lrb);
		            result.put(STATUS, SUCCESS);
		            result.put(MESSAGE, "利润表保存成功");
		        } catch (Exception e) {
		            e.printStackTrace();
		            result.put(STATUS, FAIL);
		            result.put(MESSAGE, "利润表保存失败");
		        }
       
        
		return result;
	}
	
	
	@RequestMapping(value="/saveGSXXZCB",method=RequestMethod.POST)
	public Map<String, Object> saveGSXXZCB(SctGsxxzcb gsxxzcb){
		Map<String, Object> result = Maps.newHashMap();
		
			 try {
				 saveService.saveGSXXZCB(gsxxzcb);
		            result.put(STATUS, SUCCESS);
		            result.put(MESSAGE, "公示信息自查表保存成功");
		        } catch (Exception e) {
		            e.printStackTrace();
		            result.put(STATUS, FAIL);
		            result.put(MESSAGE, "公示信息自查表保存失败");
		        }
       
        
		return result;
	}
	@RequestMapping(value="/saveXJLL",method=RequestMethod.POST)
	public Map<String, Object> saveXJLL(SctXjllb xjllb){
		Map<String, Object> result = Maps.newHashMap();
		
		try {
			saveService.saveXJLL(xjllb);
			result.put(STATUS, SUCCESS);
			result.put(MESSAGE, "现金流量表保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "现金流量表保存失败");
		}
		
		
		return result;
	}
	
	@RequestMapping(value="/saveDWTZ",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveDWTZ(@RequestBody List<JSONObject> jsonObjects){
		Map<String, Object> result = Maps.newHashMap();
		
			 try {
				 for(JSONObject jsonObject:jsonObjects){
					 SctDwtz dwtz=JSON.parseObject(jsonObject.toJSONString(), SctDwtz.class); 
					 saveService.saveDWTZ(dwtz);
					 
				 }
		            result.put(STATUS, SUCCESS);
		            result.put(MESSAGE, "对外投资信息表保存成功");
		        } catch (Exception e) {
		            e.printStackTrace();
		            result.put(STATUS, FAIL);
		            result.put(MESSAGE, "对外投资信息表保存失败");
		        }
       
        
		return result;
	}
	
	@RequestMapping(value="/saveXZCF",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveXZCF(@RequestBody JSONObject[] jsonObjects){
		Map<String, Object> result = Maps.newHashMap();
		
		try {
			 for(JSONObject jsonObject:jsonObjects){
				SctXzcf xzcf=JSON.parseObject(jsonObject.toJSONString(), SctXzcf.class); 
				 saveService.saveXZCF(xzcf);;
				 
			 }
			result.put(STATUS, SUCCESS);
			result.put(MESSAGE, "行政处罚信息表保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "行政处罚信息表保存失败");
		}
		
		
		return result;
	}
	
	@RequestMapping(value="/saveXZXK",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveXZXK(@RequestBody JSONObject[] jsonObjects){
		Map<String, Object> result = Maps.newHashMap();
		
		try {
			 for(JSONObject jsonObject:jsonObjects){
				SctXzxk xzxk=JSON.parseObject(jsonObject.toJSONString(), SctXzxk.class); 
				 saveService.saveXZXK(xzxk);
				 
			 }
			result.put(STATUS, SUCCESS);
			result.put(MESSAGE, "行政许可信息表保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "行政许可信息表保存失败");
		}
		
		
		return result;
	}
	
	@RequestMapping(value="/saveZSCQ",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveZSCQ(@RequestBody JSONObject[] jsonObjects){
		Map<String, Object> result = Maps.newHashMap();
		
		try {
			 for(JSONObject jsonObject:jsonObjects){
				SctZscq zscq=JSON.parseObject(jsonObject.toJSONString(), SctZscq.class); 
				 saveService.saveZSCQ(zscq);
				 
			 }
			result.put(STATUS, SUCCESS);
			result.put(MESSAGE, "知识产权信息表保存成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "知识产权信息表保存失败");
		}
		
		
		return result;
	}
}
