package com.kysoft.cpsi.repo.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kysoft.cpsi.repo.entity.Material;
import com.kysoft.cpsi.repo.service.MaterialService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/21")
public class MaterialController extends BaseController {

	@Resource
	MaterialService materialService;

	@RequestMapping(value = "/getCandidateMaterial/{hcsxId}", method = RequestMethod.GET)
	public List<Material> getCandidateMaterial(@PathVariable String hcsxId) {
		return materialService.getCandidateMaterial(hcsxId);
	}
	
	@RequestMapping(value = "/getAllMaterial", method = RequestMethod.GET)
	public List<Material> getAllMaterial() {
		return materialService.getAllMaterial();
	}
	
	/*@RequestMapping(value = "/hccl", method = RequestMethod.POST)
	public Map<String, Object> addHccl(Hccl hccl) {
		
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclService.addHccl(hccl);
			result.put(MESSAGE, "检查材料保存成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查材料保存失败");
		}
		return result;
	}
	

	@RequestMapping(value = "/hccl/{id}", method = RequestMethod.DELETE)
	public Map<String, Object> delete(@PathVariable String id) {
		Map<String, Object> result = Maps.newHashMap();
		try {
			hcclService.delete(id);
			result.put(MESSAGE, "检查材料删除成功");
			result.put(STATUS, SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.put(STATUS, FAIL);
			result.put(MESSAGE, "检查材料删除失败");
		}
		return result;
	}*/
}
