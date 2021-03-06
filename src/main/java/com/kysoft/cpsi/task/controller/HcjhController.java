package com.kysoft.cpsi.task.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Maps;
import com.kysoft.cpsi.task.entity.Hcjh;
import com.kysoft.cpsi.task.service.HcjhService;

import net.sf.husky.query.service.DataAccessService;
import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/31")
public class HcjhController extends BaseController {
	
	@Resource
	HcjhService hcjhService;
	
	@Resource
	DataAccessService dataAccessService;
	
	@RequestMapping(value = "/hcjh", method = RequestMethod.POST)
	public Map<String, Object> save(Hcjh hcjh) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			String id = hcjhService.save(hcjh);
			result.put("id", id);
			result.put(MESSAGE, "保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "保存失败");
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/{hcjhId}", method = RequestMethod.DELETE)
	public Map<String, Object> delete(@PathVariable String hcjhId) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.delete(hcjhId);
			result.put(STATUS, SUCCESS);
			result.put(MESSAGE, "核查计划删除成功");
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "核查计划删除失败");
			result.put(STACK, e);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/hcsx/{hcjhId}", method = RequestMethod.PUT)
	public Map<String, Object> saveCheckList(@PathVariable String hcjhId,  @RequestBody String[] hcsxIds) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.saveCheckList(hcjhId, hcsxIds);
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            result.put(STATUS, FAIL);
            e.printStackTrace();
        }
		return result;
	}

	@RequestMapping(value = "/hcjh/hcsx/{hcjhId}", method = RequestMethod.DELETE)
	public Map<String, Object> deleteCheckList(@PathVariable String hcjhId,  @RequestBody String[] hcsxIds) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.deleteCheckList(hcjhId, hcsxIds);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/audit/{hcjhId}/{shzt}", method = RequestMethod.GET)
	public Map<String, Object> audit(@PathVariable String hcjhId, @PathVariable Integer shzt) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.audit(hcjhId, shzt);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			e.printStackTrace();
		}
		return result;
	}
	
	
	@RequestMapping(value = "/hcjh/dispatch/{hcjhId}/{xdzt}", method = RequestMethod.GET)
	public Map<String, Object> dispatch(@PathVariable String hcjhId, @PathVariable Integer xdzt) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.dispatch(hcjhId, xdzt);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			result.put(MESSAGE, e.getMessage());
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/testDblink/{hcjhId}", method = RequestMethod.GET)
	public Map<String, Object> testDblink(@PathVariable String hcjhId) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			Map<String, Object> report = hcjhService.testDblink(hcjhId);
			result.putAll(report);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/importDblink/{hcjhId}", method = RequestMethod.GET)
	public Map<String, Object> importDblink(@PathVariable String hcjhId) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			Map<String, Object> report = hcjhService.importDblink(hcjhId);
			result.putAll(report);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/validate/{gsjhbh}", method = RequestMethod.GET)
	public Map<String, Object> validateGsjh(@PathVariable String gsjhbh) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			boolean validate = hcjhService.validateGsjh(gsjhbh);
			result.put("validate", validate);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			e.printStackTrace();
		}
		return result;
	}
	
	
	@RequestMapping(value = "/hcjh/addEnterprise/{hcjhId}", method = RequestMethod.PUT)
	public Map<String, Object> addEnterprise(@PathVariable String hcjhId,  @RequestBody String[] zchs) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.addEnterprise(hcjhId, zchs);
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            result.put(STATUS, FAIL);
            e.printStackTrace();
        }
		return result;
	}
	
	@RequestMapping(value = "/hcjh/addEnterpriseShortcut/{hcjhId}", method = RequestMethod.PUT)
	public Map<String, Object> addEnterpriseShortcut(@PathVariable String hcjhId,  @RequestBody String[] zchs) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.addEnterpriseShortcut(hcjhId, zchs);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/removeEnterprise/{hcjhId}", method = RequestMethod.PUT)
	public Map<String, Object> removeEnterprise(@PathVariable String hcjhId,  @RequestBody String[] hcrwIds) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.removeEnterprise(hcjhId, hcrwIds);
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			result.put(STATUS, FAIL);
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/hcjh/statement/{hcjhId}", method = RequestMethod.POST)
	public Map<String, Object> updateStatement(@PathVariable String hcjhId, String statement) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcjhService.updateStatement(hcjhId, statement);
            result.put(STATUS, SUCCESS);
        } catch (Exception e) {
            result.put(STATUS, FAIL);
            e.printStackTrace();
        }
		return result;
	}
	
	
}
