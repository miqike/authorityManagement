package com.kysoft.cpsi.repo.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.Material;
import com.kysoft.cpsi.repo.mapper.MaterialMapper;

import net.sf.husky.log.MongoLogger;

@Service
public class MaterialServiceImpl implements MaterialService {

	@Resource
	MaterialMapper materialMapper;
	
	@Override
	public List<Material> getCandidateMaterial(String hcsxId) {
		return materialMapper.selectCandidateByHcsxId(hcsxId);
	}

	@Override
	public List<Material> getAllMaterial() {
		return materialMapper.selectAll();
	}

	@Override
	public void add(Material material) {
		
		materialMapper.insert(material);
		 MongoLogger.info("repo", "增加核查材料");
	}

	@Override
	public void updateMaterial(Material material) {
		materialMapper.updateByPrimaryKey(material);
		MongoLogger.info("repo", "修改核查材料",null,material.getId());

	}

	@Override
	public void deleteMaterial(String id) {
		materialMapper.deleteByPrimaryKey(id);
		MongoLogger.info("repo", "删除核查材料",null,id);
	}


}
