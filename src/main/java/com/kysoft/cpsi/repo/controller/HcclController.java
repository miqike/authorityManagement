package com.kysoft.cpsi.repo.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.kysoft.cpsi.repo.entity.Hccl;
import com.kysoft.cpsi.repo.service.HcclService;

import net.sf.husky.web.controller.BaseController;

@RestController
@RequestMapping("/21")
public class HcclController extends BaseController {

	@Resource
	HcclService hcclService;

	
	@RequestMapping(value = "/{hcsxId}/hccl", method = RequestMethod.GET)
	public List<Hccl> getHcclCode(@PathVariable String hcsxId) {
		return hcclService.getHcclCode(hcsxId);
	}
	
}
