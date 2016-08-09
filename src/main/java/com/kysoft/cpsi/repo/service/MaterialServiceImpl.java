package com.kysoft.cpsi.repo.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.kysoft.cpsi.repo.entity.Material;
import com.kysoft.cpsi.repo.mapper.MaterialMapper;

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
		return null;//materialMapper.selectAll();
	}

	@Override
	public void add(Material material) {
		
		materialMapper.insert(material);
	}

	@Override
	public void updateMaterial(Material material) {
		materialMapper.updateByPrimaryKey(material);
		
	}

	@Override
	public void deleteMaterial(String id) {
		materialMapper.deleteByPrimaryKey(id);
	}


}
